import Foundation
public class Model {
    private let viewer: Viewer
    private var desktop: [[Int]]
    private var IndexX: Int
    private var IndexY: Int
    private var levels: Levels
    private var arrayOfIndexies: [[Int]]
    private var drawBlueprint: Bool
    private var stateModel: Bool
    private var level: Int
    private var playerFaceDirection: PlayerDirection
    public init(viewer: Viewer) {
        self.viewer = viewer
        drawBlueprint = false
        stateModel = true
        levels = Levels()
        level = 1
        desktop = []
        arrayOfIndexies = []
        IndexX = 0
        IndexY = 0
        playerFaceDirection = .down
        initialization()
    
    }
    
private func initialization() {
    desktop = levels.nextlevel(level: level)
    
        var countOne = 0
        var countThree = 0
        var countFour = 0
        for i in 0..<desktop.count {
            for j in 0..<desktop[i].count {
             if(desktop[i][j] == 4) {
                countFour = countFour + 1
             } else if(desktop[i][j] == 3) {
                countThree = countThree + 1
             } else if(desktop[i][j] == 1) {
                 IndexX = i
                 IndexY = j
                countOne = countOne + 1
             }
          }
       }
       if(countOne != 1 || (countThree != countFour) || countThree <= 0 || countFour <= 0) {
          stateModel = false
       } else {
           stateModel = true
       }
        arrayOfIndexies = Array(repeating: Array(repeating: 2, count: countFour), count: 2)
        var a = 0
        for  i in 0..<desktop.count {
            for  j in 0..<desktop[i].count {
                    if desktop[i][j] == 4 {
                       arrayOfIndexies[0][a] = i
                       arrayOfIndexies[1][a] = j
                       a = a + 1
                    }
                 }
              }
    
                                
    }
    public func checkStateModel() -> Bool {
        return stateModel
    }
public func move(direction: String) {
        switch direction {
        case "Right": MoveRight()
        case "Left": MoveLeft()
        case "Up": MoveTop()
        case "Down": MoveDown()
        default:
            return
        }
        check()
        won()
        viewer.update()
    }
private func won() {
        var won: Bool = true
        for j in 0..<arrayOfIndexies[0].count {
                    let x = arrayOfIndexies[0][j]
                    let y = arrayOfIndexies[1][j]
                    if desktop[x][y] != 3 {
                        won = false
                        break
                    }
                }
        if won {
            level = level + 1
            viewer.SuccesAlert()
            initialization()
            viewer.update()
            
        }

    }
    public func selectLevel(level: Int) {
        self.level = level
        initialization()
        viewer.update()
    }
    public func restartLevel() {
        initialization()
        viewer.update()
    }

private func check() {
        for j in 0..<arrayOfIndexies[0].count {
                 let x = arrayOfIndexies[0][j]
                 let y = arrayOfIndexies[1][j]
                 if desktop[x][y] == 0 {
                    desktop[x][y] = 4;
                 }
              }
    if level >= 10 {
        level = 1
    }
    }
public func getdesktop() -> [[Int]] {
        return self.desktop
    }
private func MoveBoxRight(x: Int, y:Int) -> Bool {
        if desktop[x][y] == 3 {
            if desktop[x][y + 1] == 0 || desktop[x][y + 1] == 4  {
               
                desktop[x][y] = 0
                desktop[x][y + 1] = 3
                viewer.update()
                return true
            } else {
                return false
            }
        }
        return true
    }
    
private func MoveBoxLeft(x: Int, y:Int) -> Bool {
        if desktop[x][y] == 3 {
            if desktop[x][y - 1] == 0 ||  desktop[x][y - 1] == 4 {
                desktop[x][y] = 0
                desktop[x][y - 1] = 3
                viewer.update()
                return true
            } else {
                return false
            }
        }
        return true
    }

private func MoveBoxUp(x: Int, y:Int) -> Bool {
        if desktop[x][y] == 3 {
            if desktop[x - 1][y] == 0 ||  desktop[x - 1][y] == 4  {
                desktop[x][y] = 0
                desktop[x - 1][y] = 3
                viewer.update()
                return true
            } else {
                return false
            }
        }
        return true
    }
private func MoveBoxDown(x: Int, y:Int) -> Bool {
        if desktop[x][y] == 3 {
            if desktop[x + 1][y] == 0  ||  desktop[x + 1][y] == 4  {
                desktop[x][y] = 0
                desktop[x + 1][y] = 3
                viewer.update()
                return true
            } else {
                return false
            }
        }
        return true
    }
    
public func MoveRight() {
        if MoveBoxRight(x: IndexX, y: IndexY  + 1) {
            if  desktop[IndexX][IndexY + 1] == 0 || desktop[IndexX][IndexY + 1] == 4 {
                desktop[IndexX][IndexY] = 0
                IndexY = IndexY + 1
            }
        }
    desktop[IndexX][IndexY] = 1
    playerFaceDirection = .rigth
    }
    
public func MoveLeft() {
        if MoveBoxLeft(x: IndexX, y: IndexY  - 1) {
            if  desktop[IndexX][IndexY - 1] == 0 || desktop[IndexX][IndexY - 1] == 4 {
                desktop[IndexX][IndexY] = 0
                IndexY = IndexY - 1
            }
        }
    desktop[IndexX][IndexY] = 1
    playerFaceDirection = .left
    }
    
public func MoveTop() {
        if MoveBoxUp(x: IndexX  - 1, y: IndexY) {
            if  desktop[IndexX - 1][IndexY] == 0  || desktop[IndexX - 1][IndexY] == 4{
                desktop[IndexX][IndexY] = 0
                IndexX = IndexX  - 1
            }
        }
    desktop[IndexX][IndexY] = 1
    playerFaceDirection = .up
    }

public func MoveDown() {
        if MoveBoxDown(x: IndexX  + 1, y: IndexY) {
            if  desktop[IndexX + 1][IndexY] == 0  || desktop[IndexX + 1][IndexY] == 4 {
                desktop[IndexX][IndexY] = 0
                IndexX = IndexX + 1
            }
        }
    desktop[IndexX][IndexY] = 1
    playerFaceDirection = .down
    }
    
func getplayerfacedirection() -> PlayerDirection {
        return playerFaceDirection
    }
//    func getplayerInGround() -> Bool {
//        return playerInGround
//    }
}
