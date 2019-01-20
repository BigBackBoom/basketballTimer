//
//  PossArrowView.swift
//  Sefo Timer
//
//  Created by 菊池広大 on 2019/01/13.
//  Copyright © 2019 bigbackboom. All rights reserved.
//

import UIKit

class PossArrowView: UIView {

    @IBOutlet weak var RightArrowLabel: UILabel!
    @IBOutlet weak var LeftArrowLabel: UILabel!
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    func loadNib(){
        let view = Bundle.main.loadNibNamed("PossArrow", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func onLeftArrowClicked(_ sender: Any) {
        print("left")
    }
    
    @IBAction func onRightArrowClicked(_ sender: Any) {
        print("right")
    }
}
