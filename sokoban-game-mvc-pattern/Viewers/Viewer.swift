import UIKit
public class Viewer: UIViewController {
    private var controller: Controller?
    private var shuffle = false
    private var model: Model?
    private var canvas: Canvas?
    public required init?(coder: NSCoder) {
        print("im viewer root")
        super.init(coder: coder)
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        controller = Controller(viewer: self)
        model = (controller?.getmodel())!
        canvas = Canvas(model: (model!))
        view.addSubview(canvas!)
        canvas?.center = view.center
        view.contentMode = .scaleToFill
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        setupNavBar()
        
    }
    //MARK: --------------
    @objc private func restartLevel() {
        controller?.getmodel().restartLevel()
    }
    @objc private func sounfOff() {
        shuffle = !shuffle
        if shuffle {
            Music.muteSound()
            
        } else if !shuffle {
            Music.unMuteSound()
        }
        
    }
    //MARK: -
    func update() {
        canvas?.setNeedsDisplay()
    }
    //MARK: -
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            controller!.movePressed(position: position)
        }
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            controller!.mouseReleased(position: position)
        }
    }
    private func selectLevel(level: Int) {
        model?.selectLevel(level: level)
    }
    @objc private func selectLevels() {
        let menuController = MenuViewer()
        menuController.delegate = self
        menuController.modalPresentationStyle = .popover
        let popoverPresentationController = menuController.popoverPresentationController
        popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        popoverPresentationController?.delegate = self
        navigationController!.present(menuController, animated: true)
//
    }
    //MARK: -
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(selectLevels))
        navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "backward.end"), style: .done, target: self, action: #selector(restartLevel)),UIBarButtonItem(image: UIImage(systemName: "speaker.slash.fill"), style: .done, target: self, action: #selector(sounfOff))]
    }
    
    func SuccesAlert() {
        let alert = UIAlertController(title: "Succes", message: "Succes level", preferredStyle: .alert)
        let reloadLevel = UIAlertAction(title: "reload level", style: .default, handler: { _ in
            self.controller?.getmodel().restartLevel()
        })
        let nextLevel = UIAlertAction(title: "Next level", style: .default, handler: { _ in
            self.model?.nextLevel()
        })
        alert.addAction(reloadLevel)
        alert.addAction(nextLevel)
        present(alert, animated: true)
    }
    
    public func notConnectionAlert() {
        let alert = UIAlertController(title: "Not connection", message: "click to button", preferredStyle: .actionSheet)
        let alertButton = UIAlertAction(title: "OK", style: .default) { _ in
            self.model?.returnFirstLevel()
        }
        alert.addAction(alertButton)
        present(alert, animated: true)
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension Viewer: UIPopoverPresentationControllerDelegate, MenuDelegate {
    func returnLevel(level: Int) {
        selectLevel(level: level)
        
    }
}
