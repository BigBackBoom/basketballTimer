//
//  PossArrowPresenter.swift
//  Sefo Timer
//
//  Created by 菊池広大 on 2019/01/20.
//  Copyright © 2019 bigbackboom. All rights reserved.
//

import Foundation

class PossArrowPresenter: PossArrowProtocol {

    private let delegate: PossArrowUIDelegate
    private var possArrowModel: PossArrowModel = PossArrowModel()

    required init(delegate: PossArrowUIDelegate) {
        self.delegate = delegate
    }

    func turnOnArrow(arrowDirection: ArrowDirection) {
        switch arrowDirection {
        case .arrowLeft:
            possArrowModel.turnOnSwitch(dir: .arrowLeft)
        case .arrowRight:
            possArrowModel.turnOnSwitch(dir: .arrowRight)
        }
        updateArrowDirection()
    }

    func switchArrow() {
        possArrowModel.switchArrow()
        updateArrowDirection()
    }

    func isTurnedOn() -> Bool {
        return possArrowModel.isTurnedOn()
    }

    func resetArrow() {
        possArrowModel.isRight = false
        possArrowModel.isLeft = false
        delegate.updateLeftArrow(isHidden: true)
        delegate.updateRightArrow(isHidden: true)
    }

    private func updateArrowDirection() {
        if (possArrowModel.isRight) {
            delegate.updateLeftArrow(isHidden: false)
            delegate.updateRightArrow(isHidden: true)
        } else {
            delegate.updateLeftArrow(isHidden: true)
            delegate.updateRightArrow(isHidden: false)
        }
    }
}
