//
//  ClassHeaderView.swift
//  Loading
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class ClassHeaderView: UIView {
    
    fileprivate lazy var titleLabel:UILabel = {
        let titleL = UILabel()
        titleL.textAlignment = NSTextAlignment.center
        titleL.textColor = UIColor.black
        titleL.font = UIFont.systemFont(ofSize: 15)
        return titleL
    }()
    
    fileprivate lazy var button:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        return btn
    }()
    
    fileprivate lazy var iconImageV:UIImageView = {
        let imageV = UIImageView(image: UIImage(named: ""))
        return imageV
    }()
    
    fileprivate lazy var topLine:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        return line
    }()
    
    fileprivate lazy var bottomLine:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    //MARK:setupUI
    func setupUI() -> Void {
        self.addSubview(topLine)
        self.addSubview(button)
        self.addSubview(bottomLine)
        self.addSubview(titleLabel)
        self.addSubview(iconImageV)
        
        topLine.mas_makeConstraints { (make) in
            _ = make?.top.mas_equalTo()(self.mas_top)?.offset()(2)
            _ = make?.left.mas_equalTo()(self.mas_left)
            _ = make?.right.mas_equalTo()(self.mas_right)
            _ = make?.height.mas_equalTo()(0.5)
        }
        button.mas_makeConstraints { (make) in
            _ = make?.top.mas_equalTo()(self.topLine.mas_bottom)
            _ = make?.left.mas_equalTo()(self.mas_left)
            _ = make?.right.mas_equalTo()(self.mas_right)
            _ = make?.height.mas_equalTo()(26)
        }
        bottomLine.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.mas_left)
            _ = make?.right.mas_equalTo()(self.mas_right)
            _ = make?.height.mas_equalTo()(0.6)
            _ = make?.top.mas_equalTo()(self.button.mas_bottom)
        }
        
        titleLabel.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.mas_left)?.offset()(10)
            _ = make?.centerY.mas_equalTo()(self.mas_centerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
