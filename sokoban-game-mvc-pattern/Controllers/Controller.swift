import Foundation
class Controller {
    private var x1: Int!
    private var y1: Int!
    private var model: Model
    
    init(viewer: Viewer) {
        self.x1 = 0
        self.y1 = 0
        self.model = Model(viewer: viewer)
    }
    public func getmodel() -> Model {
        return model
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

