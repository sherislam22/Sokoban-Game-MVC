import UIKit
public class Controller: UIViewController {
    private var model: Model!
    private var x1: Int!
    private var y1: Int!
    private let dataArray: [Int] = [1,2,3,4,5,6]
    public required init?(coder: NSCoder) {
        print("im viewer root")
        super.init(coder: coder)
    }
    
    public init(viewer: Viewer) {
        self.model = Model(viewer: viewer)
        x1 = 0
        y1 = 0
        super.init(nibName: nil, bundle: nil)
        view.contentMode = .scaleToFill
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                                   style: .done,
                                                                   target: self,
                                                                   action: #selector(selectLevels))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "RESTART", style: .done, target: self, action: #selector(restartLevel))
        playSound()

    }
    @objc private func restartLevel() {
        model.restartLevel()
    }
    private func selectLevel(level: Int) {
        model.selectLevel(level: level)
    }
    
    @objc private func selectLevels() {
        let menuController = MenuViewer()
               menuController.delegate = self
        menuController.modalPresentationStyle = .popover
               let popoverPresentationController = menuController.popoverPresentationController
        popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
               popoverPresentationController?.delegate = self
        navigationController!.present(menuController, animated: true)

    }
    
    public func getmodel() -> Model {
        return model
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            movePressed(position: position)
        }
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            mouseReleased(position: position)
        }
        
    }
    public func movePressed(position: CGPoint) {
        x1 = Int(position.x)
        y1 = Int(position.y)
        
    }
    
    public func mouseReleased(position: CGPoint) {
        let x2: Int = Int(position.x)
        let y2: Int = Int(position.y)
        movePosition(x2: x2, y2: y2)
    }
    
    private func movePosition(x2: Int, y2: Int) {
        let deltaX: Int = x1 - x2
        let deltaY: Int = y1 - y2
        var direction: String = "NO DIRECTION"
        if abs(deltaX) > abs(deltaY) {
            if deltaX < 0 {
                direction = "Right"
            }else {
                direction = "Left"
            }
        } else {
            if deltaY < 0 {
                direction = "Down"
            } else {
                direction = "Up"
            }
        }
        if direction.elementsEqual("NO DIRECTION") {
            return
        }
        model.move(direction: direction)
    }
}
extension Controller: UIPopoverPresentationControllerDelegate, MenuDelegate {
    func returnLevel(level: Int) {
        selectLevel(level: level)
        
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
