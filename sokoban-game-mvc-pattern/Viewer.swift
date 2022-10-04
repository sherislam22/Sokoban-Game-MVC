import UIKit
@main
public class Viewer: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    private var canvas: Canvas?
    private var model: Model?
    private var controller: Controller?
    public override init() {
        super.init()
        controller = Controller(viewer: self)
        model = controller!.getmodel()
        let frame: CGRect = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        canvas = Canvas( frame: frame, model: model!)
        controller?.view.addSubview(canvas!)
        let navigationController = UINavigationController(rootViewController: controller!)
        window?.rootViewController = navigationController
        window?.contentMode = .scaleToFill
        window?.makeKeyAndVisible()
        
    }
    func update() {
        canvas?.setNeedsDisplay()
    }
    public func applicationWillResignActive(_ application: UIApplication) {
        stopSound()
    }
    public func applicationDidBecomeActive(_ application: UIApplication) {
        playSound()
    }
    func SuccesAlert() {
        let alert = UIAlertController(title: "Succes", message: "Succes level", preferredStyle: .alert)
        let reloadLevel = UIAlertAction(title: "reload level", style: .default, handler: { _ in
            self.model?.restartLevel()
        })
        let nextLevel = UIAlertAction(title: "Next level", style: .default, handler: { _ in
            self.model?.nextLevel()
        })
        alert.addAction(reloadLevel)
        alert.addAction(nextLevel)
        controller?.present(alert, animated: true)
    }
    public func notConnectionAlert() {
        let alert = UIAlertController(title: "Not connection", message: "click to button", preferredStyle: .actionSheet)
        let alertButton = UIAlertAction(title: "OK", style: .default) { _ in
            self.model?.returnFirstLevel()
        }
        alert.addAction(alertButton)
        controller?.present(alert, animated: true)
    }
}
