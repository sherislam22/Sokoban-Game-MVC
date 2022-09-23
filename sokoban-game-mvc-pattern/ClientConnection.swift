





//import Foundation
//import Network
//class ClientConnection {
//
//    let  nwConnection: NWConnection
//    let queue = DispatchQueue(label: "Client connection Q")
//    public var text: String
//    init(nwConnection: NWConnection) {
//        self.nwConnection = nwConnection
//        text = "error"
//    }
//    var didStopCallback: ((Error?) -> Void)? = nil
//    func start() {
//        print("connection will start")
//        nwConnection.stateUpdateHandler = stateDidChange(to:)
////        setupReceive()
//        nwConnection.start(queue: queue)
//    }
//    private func stateDidChange(to state: NWConnection.State) {
//        switch state {
//        case .waiting(let error):
//            connectionDidFail(error: error)
//        case .ready:
//            print("Client connection ready")
//        case .failed(let error):
//            connectionDidFail(error: error)
//        default:
//            break
//        }
//    }
//    private func getMessage(text: String) {
//        self.text = text
//    }
//
//    func send(data: Data) {
//        nwConnection.send(content: data, completion: .contentProcessed( { error in
//            if let error = error {
//                self.connectionDidFail(error: error)
//                return
//            }
//            let text = String(data: data, encoding: .utf8)
//            print("Connection did send, data: \(text ?? "")")
//        }))
//
//    }
//    func setupReceive() {
//        if nwConnection.state == .ready {
//            nwConnection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, isComplete, error) in
//                if let data = data, !data.isEmpty {
//                    let message = String(data: data, encoding: .utf8)
//                    self.text = ""
//                    self.text = message!
//                }
//                if isComplete {
//                    self.connectionDidEnd()
//                } else if let error = error {
//                    self.connectionDidFail(error: error)
//                }
//                else {
//                    self.setupReceive()
//                }
//            }
//            print(text)
//        }
//
//    }
//
//    func stop() {
//        print("connection will stop")
//        stop(error: nil)
//    }
//
//    private func connectionDidFail(error: Error) {
//        print("connection did fail, error: \(error)")
//        self.stop(error: error)
//    }
//
//    private func connectionDidEnd() {
//        print("connection did end")
//        self.stop(error: nil)
//    }
//
//    private func stop(error: Error?) {
//        self.nwConnection.stateUpdateHandler = nil
//        self.nwConnection.cancel()
//        if let didStopCallback = self.didStopCallback {
//            self.didStopCallback = nil
//            didStopCallback(error)
//        }
//    }
//}
//
//
