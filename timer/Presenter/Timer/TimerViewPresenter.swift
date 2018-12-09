//
// Created by 菊池広大 on 2018-12-08.
// Copyright (c) 2018 bigbackboom. All rights reserved.
//

import Foundation

class TimerViewPresenter: TimerPresenterProtocol {

    private let delegate: TimerUIDelegate

    required init(delegate: TimerUIDelegate) {
        self.delegate = delegate
    }

    func startTimer() {

    }

    func stopTimer() {

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
