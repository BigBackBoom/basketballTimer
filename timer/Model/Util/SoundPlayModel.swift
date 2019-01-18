//
//  SoundPlayModel.swift
//  Sefo Timer
//
//  Created by 菊池広大 on 2018/12/31.
//  Copyright © 2018 bigbackboom. All rights reserved.
//

import AVFoundation
import UIKit
import RxSwift

class SoundPlayModel {

    enum Sounds: String {
        case buzzer = "buzzer"
    }

    var player: AVAudioPlayer? = nil
    let disposeBag = DisposeBag()

    func setSound(soundToPlay sound: Sounds) {
        let backgroundScheduler = SerialDispatchQueueScheduler(qos: .default)
        Single<Bool>.create(subscribe: { [weak self] singleEvent -> Disposable in
                    if let asset = NSDataAsset(name: sound.rawValue) {
                        self?.player = try? AVAudioPlayer(data: asset.data)
                        self?.player?.prepareToPlay()
                    }
                    return Disposables.create()
                })
                .subscribeOn(backgroundScheduler)
                .subscribe()
                .disposed(by: disposeBag)
    }

    func playSounds() {
        let backgroundScheduler = SerialDispatchQueueScheduler(qos: .default)
        Single<Bool>.create(subscribe: { [weak self] singleEvent -> Disposable in
                    self?.player?.play()
                    singleEvent(.success(true))
                    return Disposables.create()
                })
                .subscribeOn(backgroundScheduler)
                .subscribe()
                .disposed(by: disposeBag)
    }

    func stopSounds() {
        self.player?.stop()
    }
}
