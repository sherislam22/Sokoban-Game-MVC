import UIKit
@main
public class Viewer: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    private var canvas: Canvas?
    private var controller: Controller?
    public override init() {
        super.init()
        controller = Controller(viewer: self)
        let model = controller!.getmodel()
        let frame: CGRect = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        canvas = Canvas( frame: frame, model: model)
        controller?.view.addSubview(canvas!)
        let navigationController = UINavigationController(rootViewController: controller!)
        window?.rootViewController = navigationController
        window?.contentMode = .scaleToFill
        window?.makeKeyAndVisible()
    
    }
    func update() {
        canvas?.setNeedsDisplay()
    }
    
    func alert() {
        let ac = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        controller?.present(ac, animated: true)
    
    }
//    public func applicationWillResignActive(_ application: UIApplication) {
//        stopSound()
//    }
//    public func applicationDidBecomeActive(_ application: UIApplication) {
//        playSound()
//    }
    func SuccesAlert() {
        let alert = UIAlertController(title: "Succes", message: "Succes level", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next", style: .default)
        alert.addAction(action)
        controller?.present(alert, animated: true)
    }
}
