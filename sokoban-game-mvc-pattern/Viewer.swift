import UIKit
class Viewer: UIViewController {
    private var controller: Controller!
    private var canvas: Canvas!
    private var chieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    init() {
        super.init(nibName: nil, bundle: nil)
        self.controller = Controller(viewer: self)
        let model = controller!.getmodel()
        self.canvas =  Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300), model: model)
       print("im viewer")
    }
    required init?(coder: NSCoder) {
        print("im viewer root")
        super.init(coder: coder)
        
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
            controller.movePressed(position: position)
           }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
               let position = touch.location(in: view)
            controller.mouseReleased(position: position)
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
}

