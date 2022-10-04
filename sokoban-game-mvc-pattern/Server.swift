import Foundation
public class Server: NSObject {
    private let address: String
    private let port: Int
    private var inputStream: InputStream!
    private var outputStream: OutputStream!
    private let maxReadLength: Int
    private var serverState: Bool
    public override init() {
        address = "194.152.37.7"
        port = 5546
        maxReadLength = 56842
        serverState = false
        Stream.getStreamsToHost(withName: self.address, port: self.port, inputStream: &self.inputStream, outputStream: &self.outputStream)
    }
    public func connect() {
        serverState = true
        guard let _ = inputStream, let _ = outputStream else {
            return
        }
        inputStream.delegate = self
        outputStream.delegate = self
        inputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        outputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        inputStream?.open()
        outputStream?.open()
    }
    public func serverError() -> Bool {
        return serverState
    }
    
    public func disconnect() {
        if let stream = self.inputStream {
            stream.close()
            stream.remove(from: RunLoop.current, forMode: .common)
        }
        if let stream = self.outputStream {
            stream.close()
            stream.remove(from: RunLoop.current, forMode: .common)
        }
        self.inputStream = nil
        self.outputStream = nil
    }
    
    public func write(level: String) {
        let data = level.data(using: .utf8)!
        let nsdata = NSData(data: data).bytes
        outputStream.write(nsdata, maxLength: data.count)
    }
    
    public func readAvailableBytes() -> String {
        if serverState == false {
            return "error"
        }
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        let read = inputStream.read(buffer, maxLength: maxReadLength)
        if read != -1 {
            let data = Data(bytes: buffer, count: read)
            let answer = String(data: data, encoding: .utf8)
            return answer ?? "error"
        }
        buffer.deallocate()
        return ""
    }
}
extension Server: StreamDelegate {
    public func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .errorOccurred:
            serverState = false
            print("ERROR DEBUG SERVER FAIL")
            disconnect()
        case .openCompleted:
            serverState = true
        default:
            serverState = true
        }
        
    }
}
