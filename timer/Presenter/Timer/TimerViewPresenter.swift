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

    func startTimer(_ time: Int) {
        delegate.updateButton("Stop", UIColor.buttonDisabledColor())
    }

    func resumeTimer() {
        delegate.updateButton("Stop", UIColor.buttonDisabledColor())
    }

    func stopTimer() {
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

    func updateTenthMin(_ time: UInt) {
        let tenthMinString = String(time)
        delegate.updateTenthMin(tenthMinString)
    }

    func updateMin(_ time: UInt) {
        let tenthMinString = String(time)
        delegate.updateMin(tenthMinString)
    }

    func updateTenthSec(_ time: UInt) {
        let tenthMinString = String(time)
        delegate.updateTenthSec(tenthMinString)
    }

    func updateSec(_ time: UInt) {
        let tenthMinString = String(time)
        delegate.updateSec(tenthMinString)
    }

}
