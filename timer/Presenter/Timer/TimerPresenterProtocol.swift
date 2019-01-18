//
// Created by 菊池広大 on 2018-12-08.
// Copyright (c) 2018 bigbackboom. All rights reserved.
//

import Foundation

protocol TimerPresenterProtocol {
    func startTimer()
    func resumeTimer()
    func stopTimer()
    func resetTimer()
    func getTimerState() -> TimerViewPresenter.PresenterTimerStatus
    func updateTimeLabel(isSecCountEnabled isEnabled: Bool)
    func updateTenthMin(_ time: Int)
    func updateMin(_ time: Int)
    func updateTenthSec(_ time: Int)
    func updateSec(_ time: Int)
    func updateSeparator(_ str: String)
}
