import AVFoundation
public class Music {
    static var player: AVAudioPlayer?
    static public func playSound() {
        
        guard let path = Bundle.main.path(forResource: "music", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    static public func muteSound() {
        player?.volume = 0
    }
    static public func unMuteSound() {
        player?.volume = 1
    }
    static func stopSound() {
        player?.stop()
    }
    
}
