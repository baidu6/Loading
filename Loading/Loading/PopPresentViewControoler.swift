//
//  PopPresentViewControoler.swift
//  Loading
//
//  Created by mac on 2017/2/17.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class PopPresentViewControoler: UIViewController {
    fileprivate lazy var button:UIButton = UIButton(frame: CGRect(x: (KWidth - 100) * 0.5, y: 150, width: 100, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        button.backgroundColor = UIColor.lightGray
        button.setTitle("点我哦", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 50
        button.addTarget(self, action: #selector(presentVC), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        
    }
    
    //MARK:切换控制器
    func presentVC() -> Void {
        self.present(PopPresentedViewControoler(), animated: true, completion: nil)
    }
}
