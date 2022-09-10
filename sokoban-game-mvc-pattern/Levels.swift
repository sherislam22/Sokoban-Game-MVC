import CoreFoundation
import Foundation
class Levels {
    private var level: Int
    private var prefixFileName: String
    private var endFileName: String
    init() {
        self.level = 1
        prefixFileName = "level"
        endFileName = ".sok"
    }
    
    public func nextlevel() -> [[Int]] {
        var desktop: [[Int]]
        switch level {
        case 1 : desktop = getFirstLevel()
        case 2: desktop = getSecondLevel()
        case 3: desktop = getThirdLevel()
        case 4: desktop = loadLevelFromFile(filename: "\(prefixFileName)\(level)\(endFileName)")
        case 5: desktop = loadLevelFromFile(filename: "\(prefixFileName)\(level)\(endFileName)")
        case 6:
            desktop = loadLevelFromFile(filename: "\(prefixFileName)\(level)\(endFileName)")
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
    
    private func loadLevelFromFile(filename: String) -> [[Int]] {
        var text: String = ""
        if let url = Bundle.main.url(forAuxiliaryExecutable: filename)?.absoluteURL {
            let fileInputStream = InputStream(url: url)!
            var attributes = try? FileManager.default.attributesOfItem(atPath: url.path)
            var fileSize: Int? = attributes?[.size] as? Int
            var array: [Character] = Array(repeating: "0", count: fileSize!)
            // очищаю память
            fileSize = nil
            attributes = nil
            var index = 0
            do {
                // чтение по символьно и запись в Data
                // расширил Data и там реализовал чтение по символьно
                let data = try! Data(reading: fileInputStream)
                for i in data {
                    let byte: Int = Int(i)
                    // преобразование байта в символ
                    let symbol: Character = byte.charAt
                    if symbol.isWholeNumber || symbol == "\n" {
                        array[index] = symbol
                        index = index + 1
                    } else if symbol == "\n" {
                        array[index] = "A"
                        index = index + 1
                    }
                    else {
                        array.remove(at: index)
                    }
                }
            }
            text = String(array)
            array.removeAll()
        }
        return convert(text: text)
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
    
    public func getLevel() -> Int {
        return self.level - 1
    }
}

extension Data {
    init(reading input: InputStream) throws {
        self.init()
        input.open()
        defer {
            input.close()
        }
        let bufferSize: Int = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer {
            buffer.deallocate()
        }
        while input.hasBytesAvailable {
            let read = input.read(buffer, maxLength: bufferSize)
            if read < 0 {
                //Stream error occured
                print("error")
                throw input.streamError!
            } else if read == 0 {
                break
            }
            self.append(buffer, count: read)
        }
    }
}
extension Int {
    var charAt: Character {
        return Character(UnicodeScalar(self)!)
    }
}
