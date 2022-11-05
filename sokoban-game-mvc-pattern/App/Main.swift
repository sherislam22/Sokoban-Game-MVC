import UIKit
@main
public class Main: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    public override init() {
        super.init()
        window = UIWindow()
        let navigationController = UINavigationController(rootViewController: Viewer())
        window?.rootViewController = navigationController
        window?.contentMode = .scaleToFill
        window?.makeKeyAndVisible()
        
    }
   
    public func applicationWillResignActive(_ application: UIApplication) {
        Music.stopSound()
    }
    public func applicationDidBecomeActive(_ application: UIApplication) {
        Music.playSound()
    }
    
}
