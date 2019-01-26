//
//  PossArrowProtocol.swift
//  Sefo Timer
//
//  Created by 菊池広大 on 2019/01/20.
//  Copyright © 2019 bigbackboom. All rights reserved.
//

import Foundation

protocol PossArrowProtocol {
    func turnOnArrow(arrowDirection: ArrowDirection)
    func switchArrow()
    func isTurnedOn() -> Bool
    func resetArrow()
}
