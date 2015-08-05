//
//  ViewManager.swift
//  Lomotif-IosTask
//
//  Created by Prasanna V on 05/08/15.
//  Copyright (c) 2015 swift. All rights reserved.
//

import Foundation
import UIKit

class ViewManager {
 
    lazy var AppConsts = AppConstants()
    // Produce a UIButton
    func giveMeAButton (cgrect:CGRect) -> UIButton {
      var btn =  UIButton(frame: cgrect)
        btn.backgroundColor = UIColor.blueColor()
        btn.setTitle("New !", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        return btn
    }
}