import Foundation


var isServer = false

@available(macOS 10.15.4, *)
func initServer(port: UInt16) {
    let server = EchoServer(port: Int(port))
    server.run()

}
let firstArgument = CommandLine.arguments[1]
switch (firstArgument) {
case "-l":
    isServer = true
default:
    break
}

if isServer {
    if let port = UInt16(CommandLine.arguments[2]) {
        if #available(macOS 10.15.4, *) {
            initServer(port: port)
        } else {
            // Fallback on earlier versions
        }
    } else {
        print("Error invalid port")
    }
} 
RunLoop.current.run()

