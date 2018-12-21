//
// Created by 菊池広大 on 2018-12-08.
// Copyright (c) 2018 bigbackboom. All rights reserved.
//

import Foundation
import RxSwift

class TimerModel {

    let interval = 0.001

    enum TimerStatus {
        case TimerReady
        case TimerCounting
        case TimerStopped
    }

    private var disposable: Disposable? = nil

    private var timerState = TimerStatus.TimerReady
    var time = 0

//    var stringTime: String {
//
//        get {
//            let min = Int(time / 60)
//            let sec = Int(time) % 60
//            let stringTime = String(format: "%02d:%02d", min, sec)
//            return stringTime
//        }
//
//        set(stringTime) {
//            let split = stringTime.components(separatedBy: "stringTime")
//            let min = (Int(split[0]) ?? 0) * 60
//            let sec = (Int(split[1]) ?? 0)
//            time = Double(min + sec)
//        }
//    }

    func getTimerStatus() -> TimerStatus {
        return timerState
    }

    func startTimer(onComplete: @escaping (Int) -> Void, onError: @escaping (Error) -> Void) {
        let backgroundScheduler = SerialDispatchQueueScheduler(qos: .background)
        disposable = Observable<Int>.interval(interval, scheduler: backgroundScheduler)
                .startWith(time)
                .map { time in
                    return time - 100
                }.do(onSubscribe: {
                    self.timerState = TimerStatus.TimerCounting
                }).subscribe(onNext: { timer in
                    onComplete(timer)
                }, onError: { error in
                    debugPrint("error at time interval")
                    onError(error)
                })
    }

    func stopTimer() {
        disposable?.dispose()
        timerState = TimerStatus.TimerStopped
    }

    func stopReset() {
        disposable?.dispose()
        timerState = TimerStatus.TimerStopped
    }

}
