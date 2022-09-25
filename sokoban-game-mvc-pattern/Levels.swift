import Foundation
public class Levels {
    private var prefixFileName: String
    private var endFileName: String
    private var levelAtServer: [[Int]]
    public init() {
        prefixFileName = "level"
        endFileName = ".sok"
        
        levelAtServer = []
    }
    
    public func nextlevel(level: Int) -> [[Int]] {
        var desktop: [[Int]]
        switch level {
        case 1 : desktop = getFirstLevel()
        case 2: desktop = getSecondLevel()
        case 3: desktop = getThirdLevel()
        case 4: desktop = loadLevelFromFile(filename: "\(prefixFileName)\(level)\(endFileName)")
        case 5: desktop = loadLevelFromFile(filename: "\(prefixFileName)\(level)\(endFileName)")
        case 6:
            desktop = loadLevelFromFile(filename: "\(prefixFileName)\(level)\(endFileName)")
        case 7: desktop = loadTextFromServer(filename: "\(prefixFileName)\(level)")
        case 8: desktop = loadTextFromServer(filename: "\(prefixFileName)\(level)")
        case 9: desktop = loadTextFromServer(filename: "\(prefixFileName)\(level)")
        default:
            desktop = getFirstLevel()
        }
        return desktop
    }
    private func getFirstLevel() -> [[Int]] {
        let array: [[Int]] = [
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 3, 4, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 1, 0, 0, 0, 0, 0, 2],
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
    
    private func loadLevelFromFile(filename: String) -> [[Int]] {
        var text: String = ""
        do {
            let url = Bundle.main.url(forAuxiliaryExecutable: filename)?.absoluteURL
            let attributes = try? FileManager.default.attributesOfItem(atPath: url!.path)
            let fileSize: Int? = attributes![.size] as? Int
            var array: [Character] = Array(repeating: "0", count: fileSize!)
            let filehandle = FileHandle(forReadingAtPath: url!.path)
            var index = 0
            let data = try? filehandle?.read(upToCount: fileSize!)
            for i in data! {
                let unicode: Int = Int(i)
                // преобразование unicode в символ
                let symbol: Character = unicode.charAt
                if symbol.isWholeNumber || symbol == "\n" {
                    array[index] = symbol
                    index = index + 1
                }
                else {
                    array.remove(at: index)
                }
            }
            text = String(array)
            array.removeAll()
        }
        return convert(text: text)
    }
    
    private func  loadTextFromServer(filename: String) -> [[Int]] {
        let server = Server()
        server.connect()
        server.write(level: filename)
        let answer = server.readAvailableBytes()
        if answer != "error" || server.serverError() {
            return convert(text: answer)
        } else {
            server.disconnect()
            return []
            
        }
    }

    
    private func convert(text: String) -> [[Int]] {
        var row: Int = 0
        for i in text {
            if i == "\n" {
                row = row + 1
            }
        }
        var array: [[Int]] = Array(repeating: Array(repeating: 0, count: row), count: row)
        var column: Int = 0
        var indexRow: Int = 0
        for i in text {
            if i == "\n" {
                array[indexRow] = Array(repeating: 0, count: column)
                indexRow = indexRow + 1
                column = 0
            } else {
                column = column + 1
            }
        }
        row = 0
        column = 0
        for i in text {
            if i == "\n" {
                row = row + 1
                column = 0
            } else {
                if let number = Int(String(i)) {
                    array[row][column] = number
                    column = column + 1
                }
            }
        }
        return array
    }
}
extension Int {
    var charAt: Character {
        return Character(UnicodeScalar(self)!)
    }
}

