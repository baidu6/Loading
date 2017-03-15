//
//  TapAnimationCell.swift
//  Loading
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class TapAnimationCell: CustomCell {
    var model:TapAnimationModel?
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    fileprivate lazy var iconView:UIImageView = {
        let iconImageV = UIImageView(image: UIImage(named: "plane"))
        iconImageV.alpha = 0
        return iconImageV
    }()
    fileprivate lazy var rectView:UIView = {
        let rectV = UIView()
        rectV.layer.borderWidth = 1
        rectV.layer.borderColor = UIColor.black.cgColor
        return rectV
    }()
    fileprivate lazy var lineView:UIView = {
        let lineV = UIView()
        lineV.alpha = 0
        lineV.backgroundColor = UIColor.red
        return lineV
    }()
    override func buildSubviews() {
        titleLabel.frame = CGRect(x: 30, y: 10, width: 300, height: 60)
        iconView.frame = CGRect(x: KWidth - 62, y: 20, width: 40, height: 40)
        rectView.frame = CGRect(x: KWidth - 60, y: 23, width: 35, height: 35)
        lineView.frame = CGRect(x: 30, y: 70, width: 0, height: 2)
        self.addSubview(titleLabel)
        self.addSubview(iconView)
        self.addSubview(rectView)
        self.addSubview(lineView)
        
//        if let model = self.model{
//            titleLabel
//        }
    }
    
    override func selectedEvent() {
        
    }
  
}
