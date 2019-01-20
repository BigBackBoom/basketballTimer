//
//  PossArrowModel.swift
//  Sefo Timer
//
//  Created by 菊池広大 on 2019/01/20.
//  Copyright © 2019 bigbackboom. All rights reserved.
//

import Foundation

class PossArrowModel {

    enum ArrowDirection {
        case arrowRight
        case arrowLeft
    }

    let arrowRight = "▶︎"
    let arrowLeft = "◀︎"

    var isRight = false
    var isLeft = false

    func isTurnedOn() -> Bool {
        return !isLeft && !isRight
    }

    func turnOnSwitch(dir: ArrowDirection) {
        switch dir {
        case .arrowRight:
            isRight = true
            isLeft = false
        case .arrowLeft:
            isRight = false
            isLeft = true
        }
    }

    func switchArrow() {
        if (isRight) {
            isRight = false
            isLeft = true
        } else {
            isRight = true
            isLeft = false
        }
    }
}
