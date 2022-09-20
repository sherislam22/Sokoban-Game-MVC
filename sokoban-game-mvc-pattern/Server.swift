import Foundation

public protocol serverDelegate: AnyObject {
    func recieve(message: String)
}

public class Server: NSObject {
    private var inputstream: InputStream
    private var outputstream: OutputStream
    public var delegate: serverDelegate?
    private let maxReadLength: Int = 4096
    private var ip: String
    private var port: Int
    public init(ip: String, port: Int) {
        self.ip = ip
        self.port = port
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                           self.ip as CFString,
                                           UInt32(self.port),
                                           &readStream,
                                           &writeStream)
        
        inputstream = readStream!.takeRetainedValue()
        outputstream = writeStream!.takeRetainedValue()
        super.init()
        inputstream.delegate = self
        
        inputstream.schedule(in: .current, forMode: .common)
        outputstream.schedule(in: .current, forMode: .common)
        
        inputstream.open()
        outputstream.open()
        
    }
    public func sendMessage(message: String) -> String? {
        let data = "\(message)".data(using: .utf8)!
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error joining chat")
                return
            }
            outputstream.write(pointer, maxLength: data.count)
        }
        let input = inputstream.read(buffer, maxLength: maxReadLength)
        let data1 = Data(bytes: buffer, count: input)
        return String(data: data1, encoding: .utf8)
    }
    func stopChatSession() {
        inputstream.close()
        outputstream.close()
    }
}
extension Server: StreamDelegate {
    public func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            print("new message received")
        case .endEncountered:
            print("new message received")
            stopChatSession()
        case .errorOccurred:
            print("error occurred")
        case .hasSpaceAvailable:
            print("has space available")
        default:
            print("some other event...")
        }
    }
}
