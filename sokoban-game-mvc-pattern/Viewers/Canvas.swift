import Foundation
import UIKit
public class Canvas: UIView {
    private var model: Model?
    private var desktop: [[Int]]
    private var start: Int
    private var didSetupConstraints = false
    private var cellSide: Int
    private var herodown: UIImage!
    private var heroup: UIImage!
    private var heroleft: UIImage!
    private var heroright: UIImage!
    private var imageBox: UIImage!
    private var imageGoal: UIImage!
    private var imageWall: UIImage!
    private var errorImage: UIImage!
    private var imageWhiteplace: UIImage!
    public init(model: Model) {
        self.model = model
        self.desktop = model.getdesktop()
        cellSide = 29
        start = Int(UIScreen.main.bounds.width - 290) / 2
        super.init(frame: UIScreen.main.bounds)
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
    public override func draw(_ rect: CGRect) {
        desktop = model!.getdesktop()
        drawBoard()
    }
    func drawBoard() {
        if model!.checkStateModel() {
            var x =  start
            var y = Int(UIScreen.main.bounds.height / 2) - 145
            for i in 0..<desktop.count {
                var indexTwoArray = [Int]()
                for j in 0..<desktop[i].count {
                    if desktop[i][j] == 2 {
                        indexTwoArray.append(j)
                    }
                }
                for k in 0..<desktop[i].count {
                    if desktop[i][k] == 1 {
                        if model?.getplayerfacedirection() == "Down" {
                            herodown.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        } else if model?.getplayerfacedirection() == "Up" {
                            heroup.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        } else if model?.getplayerfacedirection() ==  "Right" {
                            heroright.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        } else if model?.getplayerfacedirection() ==  "Left" {
                            heroleft.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        }
                        else {
                            herodown.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                        }
                    }
                    else if desktop[i][k] == 2 {
                        imageWall.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                    }
                    else if desktop[i][k] == 3 {
                        imageBox.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                    }
                    else if desktop[i][k] == 4 {
                        imageGoal.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                    }
                    else if desktop[i][k] == 0 && k > indexTwoArray[0] && k < indexTwoArray[indexTwoArray.count - 1]  {
                        imageWhiteplace.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                    } else{
                        
                    }
                    
                    x = x + cellSide
                }
                y = y + cellSide
                x = start
                
            }
        } else {
            model?.ifNotConnection()
        }
        
    }
}


