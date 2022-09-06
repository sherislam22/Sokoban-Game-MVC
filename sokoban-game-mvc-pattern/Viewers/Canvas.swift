import Foundation
import UIKit

class Canvas: UIView {
    private var model: Model?
    private var desktop: [[Int]]
    private let start = 0
    private var didSetupConstraints = false
    private var cellSide  = 29
    private let offset = 0
    private var imageGamer: UIImage!
    private var imageBox: UIImage!
    private var imageGoal: UIImage!
    private var imageWall: UIImage!
    private var imageWhiteplace: UIImage!
  init(frame: CGRect, model: Model) {
        self.model = model
        self.desktop = model.getdesktop()
      super.init(frame: frame)
      imageGamer = UIImage(named: "hero")
      imageWall = UIImage(named: "Wall")
      imageBox = UIImage(named: "box")
      imageGoal = UIImage(named: "goal")
      imageWhiteplace = UIImage(named: "whiteBox")
        drawBoard()
    }
    required init?(coder aCoder: NSCoder) {
        self.desktop = model!.getdesktop()
        
        super.init(coder: aCoder)
        drawBoard()
    }
    public func updateView() {
        drawBoard()
    }
    override func draw(_ rect: CGRect) {
        self.desktop = model!.getdesktop()
        drawBoard()
        backgroundColor = .clear
        }
    func drawBoard() {
        var x = start
        var y = start
       
        for i in 0..<desktop.count {
            for j in 0..<desktop[i].count {
                if desktop[i][j] == 1 {
                    imageGamer.draw(in: CGRect(x: x, y: y, width: cellSide, height: cellSide))
                } else if desktop[i][j] == 2 {
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
                x = x + cellSide + offset
            }
            y = y + cellSide + offset
            x = start
                
            }
    }
}



