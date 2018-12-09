//
// Created by 菊池広大 on 2018-12-08.
// Copyright (c) 2018 bigbackboom. All rights reserved.
//

import Foundation

class TimerModel {

    enum TimerStatus {
        case TimerReady
        case TimerCounting
        case TimerStopped
        case TimerRinging
    }

    var timerState = TimerStatus.TimerReady
    var time = 0.0
    var stringTime: String {

        get {
            let min = Int(time / 60)
            let sec = Int(time) % 60
            let stringTime = String(format: "%02d:%02d", min, sec)
            return stringTime
        }

        set(stringTime) {
            let split = stringTime.components(separatedBy: "stringTime")
            let min = (Int(split[0]) ?? 0) * 60
            let sec = (Int(split[1]) ?? 0)
            time = Double(min + sec)
        }
    }

}
