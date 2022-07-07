import Foundation
import UIKit
import AVFoundation



class Model{
    
    fileprivate static let modelInstance = Model()
    
    fileprivate init() {}
    
    static var instance : Model{
        get{
            return modelInstance
        }
    }
    
    
    var player : AVAudioPlayer?
    
  
    
    func play(sound name : String){
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else{
            return
        }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    
    
}



struct Constant {
    static let win_sound : String = "win"
    static let spin_sound : String = "spin"
    
}


enum Games {
    
    static let firstGameImageSet: [UIImage] = [UIImage(named: "1.1")!,
                                               UIImage(named: "1.2")!,
                                               UIImage(named: "1.3")!,
                                               UIImage(named: "1.4")!,
                                               UIImage(named: "1.5")!,
                                               UIImage(named: "1.6")!,
                                               UIImage(named: "1.7")!,
                                               UIImage(named: "1.8")!,
                                               UIImage(named: "1.9")!]
    
    
    static let secondGameImageSet: [UIImage] = [UIImage(named: "2.1")!,
                                                UIImage(named: "2.2")!,
                                                UIImage(named: "2.3")!,
                                                UIImage(named: "2.4")!,
                                                UIImage(named: "2.5")!,
                                                UIImage(named: "2.6")!,
                                                UIImage(named: "2.7")!,
                                                UIImage(named: "2.8")!,
                                                UIImage(named: "2.9")!]
    
    
    static let thirdGameImageSet: [UIImage] = [UIImage(named: "2.1")!,
                                               UIImage(named: "2.2")!,
                                               UIImage(named: "2.3")!,
                                               UIImage(named: "2.4")!,
                                               UIImage(named: "2.5")!,
                                               UIImage(named: "2.6")!,
                                               UIImage(named: "2.7")!,
                                               UIImage(named: "2.8")!,
                                               UIImage(named: "2.9")!]
    
}




