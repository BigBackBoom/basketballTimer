//
// Created by 菊池広大 on 2018-12-08.
// Copyright (c) 2018 bigbackboom. All rights reserved.
//

import Foundation
import UIKit

class TimerViewPresenter: TimerPresenterProtocol {

    enum PresenterTimerStatus {
        case TimerReady
        case TimerCounting
        case TimerStopped
        case TimerRinging
    }

    private let delegate: TimerUIDelegate
    private var timerModel: TimerModel = TimerModel()

    required init(delegate: TimerUIDelegate) {
        self.delegate = delegate
    }

    func startTimer() {
        timerModel.startTimer(onComplete: { time in
            self.countDown(time: time)
        }, onError: { error in
            debugPrint(error)
        })

        delegate.updateButton("Stop", UIColor.buttonDisabledColor())
    }

    func resumeTimer() {
        timerModel.startTimer(onComplete: { time in
            self.countDown(time: time)
        }, onError: { error in
            debugPrint(error)
        })
        delegate.updateButton("Stop", UIColor.buttonDisabledColor())
    }

    func stopTimer() {
        timerModel.stopTimer()
        delegate.updateButton("Start", UIColor.buttonEnabledColor())
    }

    func getTimerState() -> TimerViewPresenter.PresenterTimerStatus {

        var status = TimerViewPresenter.PresenterTimerStatus.TimerReady

        switch timerModel.getTimerStatus() {
        case .TimerCounting:
            status = TimerViewPresenter.PresenterTimerStatus.TimerCounting
        case .TimerStopped:
            status = TimerViewPresenter.PresenterTimerStatus.TimerStopped
        default:
            status = TimerViewPresenter.PresenterTimerStatus.TimerReady
        }
        return status
    }

    func updateTimeLabel(time: Int) {

        let minutes = Int(time / 60)
        let second = Int(time) % 60

        let tenthMinDisplay = minutes / 10
        let minDisplay = minutes % 10
        let tenthSecDisplay = second / 10
        let secDisplay = second % 10

        self.updateTenthMin(tenthMinDisplay)
        self.updateMin(minDisplay)
        self.updateTenthSec(tenthSecDisplay)
        self.updateSec(secDisplay)
    }

    func updateTenthMin(_ time: Int) {
        let tenthMinString = String(time)
        timerModel.timerLabel.tenthMin = tenthMinString
        delegate.updateTenthMin(tenthMinString)
    }

    func updateMin(_ time: Int) {
        let minString = String(time)
        timerModel.timerLabel.min = minString
        delegate.updateMin(minString)
    }

    func updateTenthSec(_ time: Int) {
        let tenthSecString = String(time)
        timerModel.timerLabel.tenthSec = tenthSecString
        delegate.updateTenthSec(tenthSecString)
    }

    func updateSec(_ time: Int) {
        let secString = String(time)
        timerModel.timerLabel.sec = secString
        delegate.updateSec(secString)
    }
    
    private func countDown(time : Int){
        self.updateTimeLabel(time: time)
        
        if (time <= 0) {
            self.timerModel.resetTimer()
            self.delegate.updateButton("Start", UIColor.buttonEnabledColor())
        }
    }

}
