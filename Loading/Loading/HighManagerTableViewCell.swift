
//
//  HighManagerTableViewCell.swift
//  Loading
//
//  Created by mac on 2017/3/6.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit

class HighManagerTableViewCell: UITableViewCell {
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.text = "资本汇富3号(189977)"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 114/255.0, green: 114/255.0, blue: 114/255.0, alpha: 1.0)
        return label
    }()
    fileprivate lazy var centerDetailV:UIView = UIView()
    fileprivate lazy var purchaseBtn:UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textAlignment = NSTextAlignment.center
        btn.setTitle("购买", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor(red: 255/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()
    fileprivate lazy var percentLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 255/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "5%"
        return label
    }()
    fileprivate lazy var descLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "业绩比较基准"
        return label
    }()
    fileprivate lazy var seperatorV:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.alpha = 0.2
        return view
    }()
    fileprivate lazy var startingLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        label.text = "投资起点：100万"
        return label
    }()
    fileprivate lazy var timeLimitLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        label.text = "投资期限：30天"
        return label
    }()
    fileprivate lazy var leftAmountLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        
        //转换成小数点格式...
        let amount = 10007843478
        let format = NumberFormatter()
        format.numberStyle = NumberFormatter.Style.decimal
        let str = format.string(from: amount as NSNumber)
        if let str = str{
            label.text = "剩余额度：\(str)元"
        }
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //没有点击选中事件
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        self.addSubview(titleLabel)
        self.addSubview(centerDetailV)
        
        let leftMargin:CGFloat = 16
        let topMargin:CGFloat = 20
        
        titleLabel.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.mas_left)?.offset()(leftMargin)
            _ = make?.top.mas_equalTo()(self.mas_top)?.offset()(topMargin)
        }
        centerDetailV.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.mas_left)
            _ = make?.top.mas_equalTo()(self.titleLabel.mas_bottom)?.offset()(25)
            _ = make?.right.mas_equalTo()(self.mas_right)
            _ = make?.height.mas_equalTo()(55)
        }
        
        centerDetailV.backgroundColor = UIColor.red
        setupCenterDetailV()
    }
    
    func setupCenterDetailV() -> Void {
        let leftMargin:CGFloat = 16
        let left:CGFloat = 80
        centerDetailV.backgroundColor = UIColor.white
        centerDetailV.addSubview(descLabel)
        centerDetailV.addSubview(percentLabel)
        centerDetailV.addSubview(seperatorV)
        centerDetailV.addSubview(startingLabel)
        centerDetailV.addSubview(timeLimitLabel)
        centerDetailV.addSubview(leftAmountLabel)
        centerDetailV.addSubview(purchaseBtn)
        
        descLabel.mas_makeConstraints { (make) in
            _ = make?.bottom.mas_equalTo()(self.centerDetailV.mas_bottom)
            _ = make?.left.mas_equalTo()(self.centerDetailV.mas_left)?.offset()(leftMargin)
        }
        percentLabel.mas_makeConstraints { (make) in
            _ = make?.centerX.mas_equalTo()(self.descLabel.mas_centerX)
            _ = make?.bottom.mas_equalTo()(self.descLabel.mas_top)
        }
        seperatorV.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.centerDetailV.mas_left)?.offset()(left)
            _ = make?.top.mas_equalTo()(self.centerDetailV.mas_top)
            _ = make?.bottom.mas_equalTo()(self.centerDetailV.mas_bottom)
            _ = make?.width.mas_equalTo()(1)
        }
        startingLabel.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.seperatorV.mas_right)?.offset()(5)
            _ = make?.top.mas_equalTo()(self.seperatorV.mas_top)
        }
        timeLimitLabel.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.startingLabel.mas_left)
            _ = make?.centerY.mas_equalTo()(self.centerDetailV.mas_centerY)
        }
        leftAmountLabel.mas_makeConstraints { (make) in
            _ = make?.bottom.mas_equalTo()(self.centerDetailV.mas_bottom)
            _ = make?.left.mas_equalTo()(self.startingLabel.mas_left)
        }
        purchaseBtn.mas_makeConstraints { (make) in
            _ = make?.right.mas_equalTo()(self.centerDetailV.mas_right)?.offset()(-leftMargin)
            _ = make?.top.mas_equalTo()(self.centerDetailV.mas_top)
            _ = make?.height.mas_equalTo()(30)
            _ = make?.width.mas_equalTo()(80)
        }
    }
}
