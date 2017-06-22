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
    
       
        topLine.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(2)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(0.5)
        }
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLine.snp.bottom)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(26)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(0.6)
            make.top.equalTo(self.button.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
