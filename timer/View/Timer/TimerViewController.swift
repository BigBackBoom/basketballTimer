//
//  TimerViewController.swift
//  timer
//
//  Created by 菊池広大 on 2018/11/30.
//  Copyright © 2018 bigbackboom. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var tenthMinLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var tenthSecLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!

    private var prevOrientation = UIInterfaceOrientationMask.landscapeLeft
    private var timerViewPresenter: TimerViewPresenter? = nil

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
            var min = UInt(label.text ?? "0") ?? 0
            min = min + 1
            label.text = String(min)
        }
    }

    @IBAction func onSwipeLabelDown(_ sender: UISwipeGestureRecognizer) {
        if sender.view is UILabel {
            let label = sender.view as! UILabel
            var min = UInt(label.text ?? "0") ?? 0
            min = min - 1
            label.text = String(min)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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

}
