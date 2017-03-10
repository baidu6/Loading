//
//  DetailHeaderView.swift
//  Loading
//
//  Created by mac on 2017/3/7.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class DetailHeaderView: UIView {
    @IBOutlet weak var contractButton: UIButton!
    class func headerView() -> DetailHeaderView{
        return Bundle.main.loadNibNamed("DetailHeaderView", owner: nil, options: nil)?.last as! DetailHeaderView
    }
    
    override func awakeFromNib() {
        contractButton.layer.cornerRadius = 20
        contractButton.layer.masksToBounds = true
        contractButton.layer.borderWidth = 1
        contractButton.layer.borderColor = UIColor.red.cgColor
    }
    
    //MARK:提供一个展示数据的方法
    func displayData() -> Void {
        
    }
}
