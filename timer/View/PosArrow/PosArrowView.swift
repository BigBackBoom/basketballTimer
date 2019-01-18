//
//  PosArrowView.swift
//  Sefo Timer
//
//  Created by 菊池広大 on 2019/01/13.
//  Copyright © 2019 bigbackboom. All rights reserved.
//

import UIKit

class PosArrowView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    func loadNib(){
        let view = Bundle.main.loadNibNamed("PosArrow", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

}
