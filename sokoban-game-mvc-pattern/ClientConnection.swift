import Foundation
import Network
protocol ClientDelegate {
    func recieve(text: String) -> String
}
class ClientConnection {
    
    let  nwConnection: NWConnection
    let queue = DispatchQueue(label: "Client connection Q")
    private var text: String
    init(nwConnection: NWConnection) {
        self.nwConnection = nwConnection
        text = ""
    }
    
    var didStopCallback: ((Error?) -> Void)? = nil
    
    func start() {
        print("connection will start")
        nwConnection.stateUpdateHandler = stateDidChange(to:)
        setupReceive()
        nwConnection.start(queue: queue)
    }
    
    private func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .waiting(let error):
            connectionDidFail(error: error)
        case .ready:
            print("Client connection ready")
        case .failed(let error):
            connectionDidFail(error: error)
        default:
            break
        }
    }
    
    private func setupReceive() {
        nwConnection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, isComplete, error) in
            if let data = data, !data.isEmpty {
                let message = String(data: data, encoding: .utf8)
                print("SERVER: \(String(describing: message))")
                self.text = message ?? "error"
            }
            if isComplete {
                self.connectionDidEnd()
            } else if let error = error {
                self.connectionDidFail(error: error)
            } else {
                self.setupReceive()
            }
        }
    }
    
    public func recieve() -> String {
        return text
    }
    
    func send(data: Data) {
        nwConnection.send(content: data, completion: .contentProcessed( { error in
            if let error = error {
                self.connectionDidFail(error: error)
                return
            }
            let text = String(data: data, encoding: .utf8)
            print("Connection did send, data: \(text ?? "")")
        }))
    }
    
    func stop() {
        print("connection will stop")
        stop(error: nil)
    }
    
    private func connectionDidFail(error: Error) {
        print("connection did fail, error: \(error)")
        self.stop(error: error)
    }
    
    private func connectionDidEnd() {
        print("connection did end")
        self.stop(error: nil)
    }
    
    private func stop(error: Error?) {
        self.nwConnection.stateUpdateHandler = nil
        self.nwConnection.cancel()
        if let didStopCallback = self.didStopCallback {
            self.didStopCallback = nil
            didStopCallback(error)
        }
    }
}


