import Foundation
import UIKit

public class Canvas: UIView {
    private var model: Model?
    private var desktop: [[Int]]
    private var start = 0
    private var didSetupConstraints = false
    private var cellSide  = 0
    private var herodown: UIImage!
    private var heroup: UIImage!
    private var heroleft: UIImage!
    private var heroright: UIImage!
    private var imageBox: UIImage!
    private var imageGoal: UIImage!
    private var imageWall: UIImage!
    private var errorImage: UIImage!
    private var imageWhiteplace: UIImage!
    public init(frame: CGRect, model: Model) {
        self.model = model
        self.desktop = model.getdesktop()
        super.init(frame: frame)
        herodown = UIImage(named: "hero_down")
        heroup = UIImage(named: "hero_up")
        heroleft = UIImage(named: "hero_left")
        heroright = UIImage(named: "hero_right")
        imageWall = UIImage(named: "wall")
        imageBox = UIImage(named: "box")
        imageGoal = UIImage(named: "ground_goal")
        imageWhiteplace = UIImage(named: "ground")
        errorImage = UIImage(named: "error")

        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func updateView() {
       drawBoard()
        
    }
    public override func draw(_ rect: CGRect) {
        desktop = model!.getdesktop()
        drawBoard()
    }
    func drawBoard() {
        if model!.checkStateModel() {
            let col: CGFloat =  CGFloat(desktop.count)
            let fitWidth = frame.height / col
            let row: CGFloat = CGFloat(desktop.count)
            let fitHeight = frame.width / row
            cellSide = Int(min(fitWidth, fitHeight) / 1.2)
            start = Int(CGFloat(frame.width - CGFloat(cellSide) * col) / 2) - 10
            var x = start
            var y = Int(CGFloat(frame.height - CGFloat(cellSide) * row) / 2)
            for i in 0..<desktop.count {
                for j in 0..<desktop[i].count {
                    if desktop[i][j] == 1 {
                        switch model?.getplayerfacedirection() {
                        case .down :
                            herodown.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        case .up:
                            heroup.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        case .rigth:
                            heroright.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        case .left:
                            heroleft.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                       
                        case .none:
                            herodown.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        }
                    }else if desktop[i][j] == 2 {
                        imageWall.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                    }
                    else if desktop[i][j] == 3 {
                        imageBox.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                    }
                    else if desktop[i][j] == 4 {
                        imageGoal.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                    }
                    else if desktop[i][j] == 0 {
                        imageWhiteplace.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                    } else{
                    }
                    x = x + cellSide
                }
                y = y + cellSide
                x = start
                
            }
        } else {
            errorImage.draw(in: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
            
        }
        
    }
}


