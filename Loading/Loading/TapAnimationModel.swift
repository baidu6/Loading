//
//  TapAnimationModel.swift
//  Loading
//
//  Created by mac on 2017/3/9.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class TapAnimationModel: NSObject {
    var name:String = ""
    var selected:Bool = false
    convenience init(name:String,selected:Bool){
        self.init()
        self.name = name
        self.selected = selected
    }
}
