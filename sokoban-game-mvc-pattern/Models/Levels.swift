class Levels {
    private var level: Int
    init() {
        self.level = 1
    }
    
    public func nextlevel() -> [[Int]] {
        var desktop: [[Int]]
        switch level {
        case 1 :desktop = getFirstLevel()
        case 2: desktop = getSecondLevel()
        case 3: desktop = getThirdLevel()
        default:
            level = 1
            desktop = getFirstLevel()
        }
        level = level + 1
        return desktop
    }
    
    private func getFirstLevel() -> [[Int]] {
        let array: [[Int]] = [
        [2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
        [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
        [2, 0, 0, 0, 0, 0, 0, 3, 4, 2],
        [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
        [2, 0, 0, 1, 0, 0, 0, 0, 0, 2],
        [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
        [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
        [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
        [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]]
        
        return array
    }
    private func getSecondLevel() -> [[Int]] {
        let array: [[Int]] = [
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
            [2, 0, 0, 4, 4, 0, 0, 0, 0, 2],
            [2, 0, 0, 3, 3, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 1, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]]
        
        return array
    }
    private func getThirdLevel() -> [[Int]] {
        let array: [[Int]] = [
            [0, 0, 2, 2, 2, 2, 2, 0, 0, 0],
            [2, 2, 2, 0, 0, 0, 2, 0, 0, 0],
            [2, 0, 1, 0, 0, 0, 2, 0, 0, 0],
            [2, 2, 2, 0, 3, 4, 2, 0, 0, 0],
            [2, 4, 2, 2, 3, 0, 2, 0, 0, 0],
            [2, 0, 2, 0, 4, 0, 2, 2, 0, 0],
            [2, 3, 0, 0, 3, 3, 4, 2, 0, 0],
            [2, 0, 0, 0, 4, 0, 0, 2, 0, 0],
            [2, 2, 2, 2, 2, 2, 2, 2, 0, 0]]
        
        return array
    }
    
    public func getLevel() -> Int {
        return self.level - 1
    }
}
