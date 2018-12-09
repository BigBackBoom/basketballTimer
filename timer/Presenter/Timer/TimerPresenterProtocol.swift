//
// Created by 菊池広大 on 2018-12-08.
// Copyright (c) 2018 bigbackboom. All rights reserved.
//

import Foundation

protocol TimerPresenterProtocol {
    func startTimer()
    func stopTimer()
    func updateTenthMin(_ time: UInt)
    func updateMin(_ time: UInt)
    func updateTenthSec(_ time: UInt)
    func updateSec(_ time: UInt)
}
