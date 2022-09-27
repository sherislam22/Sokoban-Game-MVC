import Foundation
class Server: NSObject {
    private let address: String
    private let port: Int
    private var inputStream: InputStream!
    private var outputStream: OutputStream!
    private let maxReadLength: Int
    private var serverState: Bool
    override init() {
        address = "194.152.37.7"
        port = 5546
        maxReadLength = 56842
        serverState = true
        Stream.getStreamsToHost(withName: self.address, port: self.port, inputStream: &self.inputStream, outputStream: &self.outputStream)
    }
    func connect() {
        
        guard let _ = inputStream, let _ = outputStream else {
            return
        }

        self.inputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        self.outputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)

        self.inputStream?.open()
        self.outputStream?.open()
    }
    public func serverError() -> Bool {
        return serverState
    }

    func disconnect() {
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

    func write(level: String) {
        let data = level.data(using: .utf8)!
                let nsdata = NSData(data: data).bytes
                outputStream.write(nsdata, maxLength: data.count)
    }

    func readAvailableBytes() -> String {
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
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .errorOccurred:
            serverState = false
            disconnect()
        case .openCompleted:
            serverState = true
        default:
            serverState = true
        }
    
    }
}
