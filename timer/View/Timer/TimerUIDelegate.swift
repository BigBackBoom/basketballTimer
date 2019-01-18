//
//  TimerProtocol.swift
//  timer
//
//  Created by 菊池広大 on 2018/12/02.
//  Copyright © 2018 bigbackboom. All rights reserved.
//
import UIKit

protocol TimerUIDelegate {
    func updateTenthMin(_ str: String)
    func updateMin(_ str: String)
    func updateTenthSec(_ str: String)
    func updateSec(_ str: String)
    func updateSeparator(_ str: String)
    func updateButton(_ str: String, _ color: UIColor)
}
