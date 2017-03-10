//
//  CircleSpreadViewController.swift
//  Loading
//
//  Created by mac on 2017/2/16.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class CircleSpreadViewController: UIViewController {
    
    lazy var button:UIButton = UIButton(frame:CGRect(x: (KWidth - 50) * 0.5, y: (KHeight - 50) * 0.5, width: 50, height: 50))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        button.setTitle("点我哦", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        view.addSubview(button)
        button.addTarget(self, action: #selector(presentVC), for: UIControlEvents.touchUpInside)
    }

    func presentVC() -> Void {
        self.present(CircleSpreadPresentedViewController(), animated: true, completion: nil)
    }
}

