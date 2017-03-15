//
//  NavgationView.swift
//  Loading
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class NavgationView: UIView {
    
    @IBOutlet weak var clickMeBtn: UIButton!
    class func navView() -> NavgationView {
        return Bundle.main.loadNibNamed("NavgationView", owner: nil, options: nil)?.last as! NavgationView
    }
}
