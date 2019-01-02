//
//  SoundPlayModel.swift
//  Sefo Timer
//
//  Created by 菊池広大 on 2018/12/31.
//  Copyright © 2018 bigbackboom. All rights reserved.
//

import AVFoundation
import UIKit

class SoundPlayModel {

//    private let fileType = "m4a"

    enum Sounds: String {
        case buzzer = "buzzer"
    }

    var player: AVAudioPlayer? = nil
    
    func setSound(soundToPlay sound : Sounds){
        if let asset = NSDataAsset(name: sound.rawValue) {
            self.player = try? AVAudioPlayer(data: asset.data)
            self.player?.prepareToPlay()
        }
    }

    func playSounds() {
        self.player?.play()
    }

    func stopSounds() {
        self.player?.stop()
    }
}
