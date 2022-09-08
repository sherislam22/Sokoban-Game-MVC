import UIKit
class Viewer: UIViewController {
    private var controller: Controller!
    private var board: Canvas!
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
        self.board =  Canvas(frame: CGRect(x: 0, y: 0, width: 300, height: 300), model: model)
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
        board.backgroundColor = .clear
        board.translatesAutoresizingMaskIntoConstraints = false
       
        view.addSubview(chieldView)
        chieldView.addSubview(board)
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
        
    }    // буду это менять
//    func swipe() {
//        let swupegestureright = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
//        print(swupegestureright.direction)
//        swupegestureright.direction = .right
//        let swupegestureleft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
//        swupegestureleft.direction = .left
//        let swupegesturedown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown))
//        swupegesturedown.direction = .down
//        let swupegestureup = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp))
//        swupegestureup.direction = .up
//        chieldView.addGestureRecognizer(swupegestureright)
//        chieldView.addGestureRecognizer(swupegestureleft)
//        chieldView.addGestureRecognizer(swupegesturedown)
//        chieldView.addGestureRecognizer(swupegestureup)
//    }
//    @objc func didSwipeRight() {
//        model.MoveRight()
//    }
//    @objc func didSwipeLeft() {
//        model.MoveLeft()
//    }
//    @objc func didSwipeDown() {
//        model.MoveDown()
//    }
//    @objc func didSwipeUp() {
//        model.MoveTop()
//    }
    func update() {
        board.setNeedsDisplay()
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

