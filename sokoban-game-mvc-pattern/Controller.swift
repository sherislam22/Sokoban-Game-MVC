import UIKit
class Controller: UIViewController {
    private var model: Model!
    private var canvas: Canvas!
    private var x1: Int!
    private var y1: Int!
    private var chieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    required init?(coder: NSCoder) {
        print("im viewer root")
        super.init(coder: coder)
        self.model = Model(viewer: self)
        self.canvas =  Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300), model: model)
        x1 = 0
        y1 = 0
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg-1")!)
        setupBoard()

    }
    private func setupBoard() {
        canvas.backgroundColor = .clear
        canvas.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubview(chieldView)
        chieldView.addSubview(canvas)
//        swipe()
        NSLayoutConstraint.activate([
            chieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            chieldView.widthAnchor.constraint(equalToConstant: 300),
            chieldView.heightAnchor.constraint(equalToConstant: 300)
           
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
               let position = touch.location(in: view)
            movePressed(position: position)
           }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
               let position = touch.location(in: view)
            mouseReleased(position: position)
           }
        
    }
    func update() {
        canvas.setNeedsDisplay()
        view.setNeedsDisplay()
        chieldView.setNeedsDisplay()
    }
    
    func SuccesAlert() {
        let alert = UIAlertController(title: "Succes", message: "Succes level", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
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

