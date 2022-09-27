
import Foundation
import Socket
import Dispatch

@available(macOS 10.15.4, *)
class EchoServer {
    
    static let quitCommand: String = "QUIT"
    static let shutdownCommand: String = "SHUTDOWN"
    static let bufferSize = 4096
    
    let port: Int
    var listenSocket: Socket? = nil
    var continueRunningValue = true
    var connectedSockets = [Int32: Socket]()
    let socketLockQueue = DispatchQueue(label: "com.kitura.serverSwift.socketLockQueue")
    var continueRunning: Bool {
        set(newValue) {
            socketLockQueue.sync {
                self.continueRunningValue = newValue
            }
        }
        get {
            return socketLockQueue.sync {
                self.continueRunningValue
            }
        }
    }
    
    init(port: Int) {
        self.port = port
    }
    
    deinit {
        // Close all open sockets...
        for socket in connectedSockets.values {
            socket.close()
        }
        self.listenSocket?.close()
    }
    
    func run() {
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        queue.async { [unowned self] in
            
            do {
                // Create an IPV6 socket...
                try self.listenSocket = Socket.create(family: .inet)
                
                guard let socket = self.listenSocket else {
                    
                    print("Unable to unwrap socket...")
                    return
                }
                
                try socket.listen(on: self.port)
                
                print("Listening on port: \(socket.listeningPort)")
                
                repeat {
                    let newSocket = try socket.acceptClientConnection()
                    
                    print("Accepted connection from: \(newSocket.remoteHostname) on port \(newSocket.remotePort)")
                    self.addNewConnection(socket: newSocket)
                    
                } while self.continueRunning
                
            }
            catch let error {
                guard let socketError = error as? Socket.Error else {
                    print("Unexpected error...")
                    return
                }
                if self.continueRunning {
                    
                    print("Error reported:\n \(socketError.description)")
                }
            }
        }
        dispatchMain()
    }
    
    func addNewConnection(socket: Socket) {
        
        // Add the new socket to the list of connected sockets...
        socketLockQueue.sync { [unowned self, socket] in
            self.connectedSockets[socket.socketfd] = socket
        }
        
        // Get the global concurrent queue...
        let queue = DispatchQueue.global(qos: .default)
        
        // Create the run loop work item and dispatch to the default priority global queue...
        queue.async { [unowned self, socket] in
            
            var shouldKeepRunning = true
            
            var readData = Data(capacity: EchoServer.bufferSize)
            
            do {
                
                repeat {
                    let bytesRead = try socket.read(into: &readData)
                    
                    if bytesRead > 0 {
                        guard let response = String(data: readData, encoding: .utf8) else {
                            
                            print("Error decoding response...")
                            readData.count = 0
                            break
                        }
                        if response.hasPrefix(EchoServer.shutdownCommand) {
                            
                            print("Shutdown requested by connection at \(socket.remoteHostname):\(socket.remotePort)")
                            
                            // Shut things down...
                            self.shutdownServer()
                            
                            return
                        }
                        let url = Bundle.module.path(forResource: response, ofType: "sok")
                        if url != nil {
                            let answer = loadLevelFromFile(filename: url ?? "")
                            try socket.write(from: answer)
                            print(answer)
                        } else {
                            
                            try socket.write(from: "error")
                            print("error")
                        }
                        if (response.uppercased().hasPrefix(EchoServer.quitCommand) || response.uppercased().hasPrefix(EchoServer.shutdownCommand)) &&
                            (!response.hasPrefix(EchoServer.quitCommand) && !response.hasPrefix(EchoServer.shutdownCommand)) {
                            
                        }
                        
                        if response.hasPrefix(EchoServer.quitCommand) || response.hasSuffix(EchoServer.quitCommand) {
                            
                            shouldKeepRunning = false
                        }
                    }
                    
                    if bytesRead == 0 {
                        
                        shouldKeepRunning = false
                        break
                    }
                    
                    readData.count = 0
                    
                } while shouldKeepRunning
                
                print("Socket: \(socket.remoteHostname):\(socket.remotePort) closed...")
                //                socket.close()
                
                self.socketLockQueue.sync { [unowned self, socket] in
                    self.connectedSockets[socket.socketfd] = nil
                }
                
            }
            catch let error {
                guard let socketError = error as? Socket.Error else {
                    print("Unexpected error by connection at \(socket.remoteHostname):\(socket.remotePort)...")
                    return
                }
                if self.continueRunning {
                    print("Error reported by connection at \(socket.remoteHostname):\(socket.remotePort):\n \(socketError.description)")
                }
            }
        }
    }
    
    private func loadLevelFromFile(filename: String) -> String {
        var text: String = ""
        do {
            let attributes = try? FileManager.default.attributesOfItem(atPath: filename)
            let fileSize: Int? = attributes?[.size] as? Int
            let filehandle = FileHandle(forReadingAtPath: filename)
            let data = try? filehandle?.read(upToCount: fileSize!)
            var array: [Character] = Array(repeating: "0", count: fileSize!)
            var index = 0
            text = String(data: data ?? Data(), encoding: .utf8) ?? ""
            for char in text {
                if char.isNumber || char == "\n" {
                    array[index] = char
                    index = index + 1
                } else {
                    array.remove(at: index)
                }
            }
            text = String(array)
            array.removeAll()
            
        }
        return text
    }
    
    func shutdownServer() {
        print("\nShutdown in progress...")
        
        self.continueRunning = false
        
        // Close all open sockets...
        for socket in connectedSockets.values {
            
            self.socketLockQueue.sync { [unowned self, socket] in
                self.connectedSockets[socket.socketfd] = nil
                socket.close()
            }
        }
        
        DispatchQueue.main.sync {
            exit(0)
        }
    }
}

