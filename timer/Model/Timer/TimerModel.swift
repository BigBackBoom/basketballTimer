//
// Created by 菊池広大 on 2018-12-08.
// Copyright (c) 2018 bigbackboom. All rights reserved.
//

import Foundation
import RxSwift

class TimerModel {

    let interval = 0.1

    enum TimerStatus {
        case TimerReady
        case TimerCounting
        case TimerStopped
    }

    struct TimerLabel {
        var tenthMin: String = "0"
        var min: String = "0"
        var tenthSec: String = "0"
        var sec: String = "0"
        var deciSec: String = "0"
        var centiSec: String = "0"
    }

    var timerLabel = TimerLabel()
    var timerState = TimerStatus.TimerReady

    private var disposable: Disposable? = nil
    private var time = 0

    func startTimer(onComplete: @escaping (Int) -> Void, onError: @escaping (Error) -> Void) {

        let tenMin = Int(timerLabel.tenthMin) ?? 0
        let min = Int(timerLabel.min) ?? 0
        let tenSec = Int(timerLabel.tenthSec) ?? 0
        let sec = Int(timerLabel.sec) ?? 0
        time = ((tenMin * 600) + (min * 60) + (tenSec * 10) + (sec)) * 1000

        TimerCountStart(onComplete: onComplete, onError: onError)
    }

    func resumeTimer(onComplete: @escaping (Int) -> Void, onError: @escaping (Error) -> Void) {
        TimerCountStart(onComplete: onComplete, onError: onError)
    }

    func stopTimer() {
        disposable?.dispose()
        timerState = TimerStatus.TimerStopped
    }

    func resetTimer() {
        disposable?.dispose()
        timerState = TimerStatus.TimerReady
    }

    private func TimerCountStart(onComplete: @escaping (Int) -> Void, onError: @escaping (Error) -> Void) {
        let backgroundScheduler = SerialDispatchQueueScheduler(qos: .default)
        disposable = Observable<Int>.interval(interval, scheduler: backgroundScheduler)
                .startWith(0)
                .observeOn(MainScheduler.instance)
                .map { (timer) -> Int in
                    self.time -= 100
                    return self.time
                }.do(onSubscribe: {
                    self.timerState = TimerStatus.TimerCounting
                }).subscribe(onNext: { time in
                    let convertedTime = time / 1000
                    let minutes = Int(convertedTime / 60)
                    let second = Int(convertedTime) % 60
                    let milliSec = time % 1000

                    self.timerLabel.tenthMin = String(minutes / 10)
                    self.timerLabel.min = String(minutes % 10)
                    self.timerLabel.tenthSec = String(second / 10)
                    self.timerLabel.sec = String(second % 10)
                    self.timerLabel.deciSec = String(milliSec / 100)
                    self.timerLabel.centiSec = String((milliSec % 100) / 10)

                    onComplete(time)
                }, onError: { error in
                    debugPrint("error at time interval")
                    onError(error)
                })
    }

}
