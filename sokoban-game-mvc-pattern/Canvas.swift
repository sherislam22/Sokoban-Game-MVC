import Foundation
import UIKit

public class Canvas: UIView {
    private var model: Model?
    private var desktop: [[Int]]
    private var start = 0
    private var didSetupConstraints = false
    private var cellSide  = 29
    private let offset = 0
    private var imageGamer: UIImage!
    private var imageBox: UIImage!
    private var imageGoal: UIImage!
    private var imageWall: UIImage!
    private var imageWhiteplace: UIImage!
    public init(frame: CGRect, model: Model) {
        self.model = model
        self.desktop = model.getdesktop()
        super.init(frame: frame)
        imageGamer = UIImage(named: "hero")
        imageWall = UIImage(named: "Wall")
        imageBox = UIImage(named: "box")
        imageGoal = UIImage(named: "goal")
        imageWhiteplace = UIImage(named: "whiteBox")
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
        let col: CGFloat =  CGFloat(desktop.count)
        let fitWidth = frame.height / col
        let row: CGFloat = CGFloat(desktop.count)
        let fitHeight = frame.width / row
        cellSide = Int(min(fitWidth, fitHeight))
        start = Int(CGFloat(frame.width - CGFloat(cellSide) * col) / 2)
        var x = start
        var y = Int(CGFloat(frame.height - CGFloat(cellSide) * row) / 2)
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



