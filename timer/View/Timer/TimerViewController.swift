//
//  TimerViewController.swift
//  timer
//
//  Created by 菊池広大 on 2018/11/30.
//  Copyright © 2018 bigbackboom. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    private enum TimeLabelTag: Int {
        case tenthMinLabel = 0
        case minLabel = 1
        case tenthSecLabel = 2
        case secLabel = 3
    }

    @IBOutlet weak var tenthMinLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var tenthSecLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var switchButton: UIButton!

    private var prevOrientation = UIInterfaceOrientationMask.landscapeLeft
    private var timerViewPresenter: TimerPresenterProtocol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        timerViewPresenter = TimerViewPresenter(delegate: self)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == .landscapeRight {
            prevOrientation = UIInterfaceOrientationMask.landscapeLeft
        } else {
            prevOrientation = UIInterfaceOrientationMask.landscapeRight
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timerViewPresenter?.stopTimer()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        var orientation: UIInterfaceOrientationMask

        switch UIDevice.current.orientation {
        case .landscapeLeft:
            orientation = UIInterfaceOrientationMask.landscapeRight
        case .landscapeRight:
            orientation = UIInterfaceOrientationMask.landscapeLeft
        default:
            orientation = prevOrientation
        }
        return orientation
    }

    @IBAction func onSwipeLabelUp(_ sender: UISwipeGestureRecognizer) {
        if sender.view is UILabel {
            let label = sender.view as! UILabel
            var min = Int(label.text ?? "0") ?? 0
            if (min < 99) {
                min = min + 1
                setTimer(label.tag, min)
            }
        }
    }

    @IBAction func onSwipeLabelDown(_ sender: UISwipeGestureRecognizer) {
        if sender.view is UILabel {
            let label = sender.view as! UILabel
            var min = Int(label.text ?? "0") ?? 0
            if (min > 0) {
                min = min - 1
                setTimer(label.tag, min)
            }
        }
    }

    @IBAction func onSwitchButtonClick(_ sender: Any) {

        let status = timerViewPresenter?.getTimerState() ?? TimerViewPresenter.PresenterTimerStatus.TimerReady
        switch status {

        case TimerViewPresenter.PresenterTimerStatus.TimerReady:
            timerViewPresenter?.startTimer()

        case TimerViewPresenter.PresenterTimerStatus.TimerStopped:
            timerViewPresenter?.resumeTimer()

        case TimerViewPresenter.PresenterTimerStatus.TimerCounting:
            timerViewPresenter?.stopTimer()

        default:
            timerViewPresenter?.startTimer()
        }
    }

    private func setTimer(_ tag: Int, _ time: Int) {
        switch tag {
        case TimeLabelTag.tenthMinLabel.rawValue:
            timerViewPresenter?.updateTenthMin(time)
        case TimeLabelTag.minLabel.rawValue:
            timerViewPresenter?.updateMin(time)
        case TimeLabelTag.tenthSecLabel.rawValue:
            timerViewPresenter?.updateTenthSec(time)
        case TimeLabelTag.secLabel.rawValue:
            timerViewPresenter?.updateSec(time)
        default:
            break;
        }
    }
}

extension TimerViewController: TimerUIDelegate {

    func updateTenthMin(_ str: String) {
        tenthMinLabel.text = str
    }

    func updateMin(_ str: String) {
        minLabel.text = str
    }

    func updateTenthSec(_ str: String) {
        tenthSecLabel.text = str
    }

    func updateSec(_ str: String) {
        secLabel.text = str
    }

    func updateButton(_ str: String, _ color: UIColor) {
        switchButton.setTitle(str, for: .normal)
        switchButton.setTitleColor(color, for: .normal)
    }
}
