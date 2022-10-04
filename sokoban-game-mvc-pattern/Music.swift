import AVFoundation
var player: AVAudioPlayer?
public func playSound() {
    guard let path = Bundle.main.path(forResource: "music", ofType:"mp3") else {
        return }
    let url = URL(fileURLWithPath: path)
    
    do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}

public func stopSound() {
    guard let path = Bundle.main.path(forResource: "music", ofType:"mp3") else {
        return }
    let url = URL(fileURLWithPath: path)
    
    do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.stop()
        
    } catch let error {
        print(error.localizedDescription)
    }
}
