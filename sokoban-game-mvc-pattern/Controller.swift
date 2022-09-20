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
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-1")!)
        view.contentMode = .scaleToFill
    }
    public func getmodel() -> Model {
        return model
    }
    @objc public func getfunc() {
        model.getlevel(level: 1)
        pickerView()
    }
    
    private func pickerView() {
        let UIPicker: UIPickerView = UIPickerView()
        UIPicker.delegate = self
        UIPicker.dataSource = self
        UIPicker.contentMode = .scaleToFill
        self.view.addSubview(UIPicker)
        UIPicker.center = self.view.center
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

extension Controller: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = dataArray[row]
        return String(row)
    }
}
