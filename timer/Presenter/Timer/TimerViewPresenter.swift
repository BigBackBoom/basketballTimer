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
    }

    private let minConvert = 60000

    private let delegate: TimerUIDelegate
    private var timerModel: TimerModel = TimerModel()

    private var soundPlayModel: SoundPlayModel = SoundPlayModel()


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
        timerModel.resumeTimer(onComplete: { time in
            self.countDown(time: time)
        }, onError: { error in
            debugPrint(error)
        })
        delegate.updateButton("Stop", UIColor.buttonDisabledColor())
    }

    func stopTimer() {
        timerModel.stopTimer()
        delegate.updateButton("Start", UIColor.buttonEnabledColor())
        updateTimeLabel(isSecCountEnabled: true)
    }

    func resetTimer() {
        self.timerModel.resetTimer()
        timerModel.timerLabel.tenthMin = "0"
        timerModel.timerLabel.min = "0"
        timerModel.timerLabel.tenthSec = "0"
        timerModel.timerLabel.sec = "0"
        timerModel.timerLabel.deciSec = "0"
        timerModel.timerLabel.centiSec = "0"
        delegate.updateButton("Start", UIColor.buttonEnabledColor())
        updateTimeLabel(isSecCountEnabled: false)
    }

    func getTimerState() -> TimerViewPresenter.PresenterTimerStatus {

        var status = TimerViewPresenter.PresenterTimerStatus.TimerReady

        switch timerModel.timerState {
        case .TimerCounting:
            status = TimerViewPresenter.PresenterTimerStatus.TimerCounting
        case .TimerStopped:
            status = TimerViewPresenter.PresenterTimerStatus.TimerStopped
        default:
            status = TimerViewPresenter.PresenterTimerStatus.TimerReady
        }
        return status
    }

    func updateTimeLabel(isSecCountEnabled isEnabled: Bool) {

        if(timerModel.timerLabel.tenthMin == "0" && timerModel.timerLabel.min == "0" && isEnabled){

            if(timerModel.timerLabel.tenthSec != "0"){
                delegate.updateTenthMin(timerModel.timerLabel.tenthSec)
            } else {
                delegate.updateTenthMin("")
            }
            delegate.updateMin(timerModel.timerLabel.sec)
            delegate.updateSeparator(".")
            delegate.updateTenthSec(timerModel.timerLabel.deciSec)
            delegate.updateSec("")

        } else {
            delegate.updateTenthMin(timerModel.timerLabel.tenthMin)
            delegate.updateMin(timerModel.timerLabel.min)
            delegate.updateTenthSec(timerModel.timerLabel.tenthSec)
            delegate.updateSec(timerModel.timerLabel.sec)
            delegate.updateSeparator(":")
        }
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

    func updateSeparator(_ str: String) {
        delegate.updateSeparator(str)
    }

    private func countDown(time: Int) {

        if (time <= 0) {
            soundPlayModel.playSounds()
            self.timerModel.resetTimer()
            self.delegate.updateButton("Start", UIColor.buttonEnabledColor())
            self.updateTimeLabel(isSecCountEnabled: false)
        } else if(time == 1000){
            soundPlayModel.setSound(soundToPlay: SoundPlayModel.Sounds.buzzer)
            self.updateTimeLabel(isSecCountEnabled: true)
        } else {
            self.updateTimeLabel(isSecCountEnabled: true)
        }
    }

}
