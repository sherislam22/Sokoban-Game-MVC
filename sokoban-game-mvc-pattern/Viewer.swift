import UIKit
@main
public class Viewer: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?
    private var canvas: Canvas?
    private var controller: Controller?
    public override init() {
        let frame: CGRect = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        super.init()
        controller = Controller(viewer: self)
        let model = controller!.getmodel()
        canvas = Canvas( frame: frame, model: model)
        window?.rootViewController = controller
        window?.contentMode = .scaleToFill
        window?.makeKeyAndVisible()
        controller?.view.addSubview(canvas!)
        levelsmenu() 
    }
    func update() {
        canvas?.setNeedsDisplay()
    }
    
    private func levelsmenu() {
        let button: UIButton = {
           let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Levels", for: .normal)
            button.backgroundColor = .red
            button.layer.cornerRadius = 10
            return button
        }()
        controller?.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: (controller?.view.centerXAnchor)!),
            button.topAnchor.constraint(equalTo: (controller?.view.topAnchor)!,constant: 50),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        button.addTarget(self, action: #selector(controller?.getfunc), for: .touchUpInside)
    }

    
    func SuccesAlert() {
        let alert = UIAlertController(title: "Succes", message: "Succes level", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next", style: .default)
        alert.addAction(action)
        controller?.present(alert, animated: true)
    }
}
