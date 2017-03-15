//
//  DragerViewController.swift
//  Loading
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class DragerViewController: BaseDragerViewController {
    
    fileprivate lazy var navView:NavgationView = NavgationView.navView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func setupUI() {
        super.setupUI()
        navView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        navView.clickMeBtn.addTarget(self, action: #selector(leftBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        mainView.addSubview(navView)
        
        let leftVC = LeftViewController()
        leftVC.view.frame = leftView.bounds
        leftView.addSubview(leftVC.view)
        self.addChildViewController(leftVC)
    }
    
    //MARK:点击导航栏左边按钮(点击侧滑功能)
    func leftBtnClick(btn:UIButton) -> Void {
        leftPanClick(btn: btn)
    }
}
