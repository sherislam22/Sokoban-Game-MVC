import UIKit
@main
class Viewer: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    private var canvas: Canvas?
    private var controller: Controller?
    public override init() {
        super.init()
       print("ok")
        controller = Controller(viewer: self)
        canvas = Canvas(model: controller!.getmodel())
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
       
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        window?.addSubview(canvas!)
        canvas?.center = window!.center
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
               let position = touch.location(in: window)
            controller?.movePressed(position: position)
           }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
               let position = touch.location(in: window)
            controller?.mouseReleased(position: position)
           }
        
    }
    func update() {
        canvas?.setNeedsDisplay()
    }
    func SuccesAlert() {
        let alert = UIAlertController(title: "Succes", message: "Succes level", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next", style: .default)
        alert.addAction(action)
        controller?.present(alert, animated: true)
    }
}
