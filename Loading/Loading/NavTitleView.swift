//
//  NavTitleView.swift
//  Loading
//
//  Created by mac on 2017/3/6.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class NavTitleView: UIView {
    
    fileprivate var titlesArr:[String] = ["投资组合","资金产品","高端理财"]
    fileprivate var btnsArr:[UIButton] = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupUI()
    }
    func setupUI() -> Void {
        self.layer.cornerRadius = self.frame.height * 0.5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        
        //添加button
        let totalCount:Int = 3
        let btnW:CGFloat = 90
        let btnH:CGFloat = 30
        for i in 0..<totalCount{
            let btn = UIButton(frame: CGRect(x: CGFloat(i) * btnW, y: 0, width: btnW, height: btnH))
            btn.setTitle(titlesArr[i], for: UIControlState.normal)
            btn.backgroundColor = UIColor.clear
            btn.layer.cornerRadius = btnH * 0.5
            btn.layer.masksToBounds = true
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.titleLabel?.textAlignment = NSTextAlignment.center
            btn.setTitleColor(UIColor.white, for: UIControlState.normal)
            btn.setTitleColor(UIColor(red: 255/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0), for: UIControlState.selected)
            btn.addTarget(self, action: #selector(titleBtnClick(selBtn:)), for: UIControlEvents.touchUpInside)
            self.addSubview(btn)
            btnsArr.append(btn)
            
            if i == 2{
                btn.isSelected = true
                btn.backgroundColor = UIColor.white
            }
        }
    }
    
    //MARK:titleBtnClick
    func titleBtnClick(selBtn:UIButton) -> Void {
        if selBtn.isSelected == true{
            return
        }
        
        for btn in btnsArr{
            btn.isSelected = false
            btn.backgroundColor = UIColor.clear
        }
        selBtn.isSelected = true
        selBtn.backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
