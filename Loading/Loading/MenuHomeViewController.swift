//
//  MenuHomeViewController.swift
//  Loading
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class MenuHomeViewController:UIViewController{
    
    fileprivate lazy var temperView:UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        view.backgroundColor = UIColor.red
        return view
    }()
    
    fileprivate lazy var bottomView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 100, width: 200, height: 50))
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        menuButton.layer.cornerRadius = 20
    }
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(temperView)
        temperView.mask = bottomView
    }
    
    @IBAction func menuBtnDidClick(_ sender: UIButton) {
        
        let nav = UINavigationController(rootViewController: MenuMainViewController(nibName: "MenuMainViewController", bundle: nil))
        nav.navigationBar.isHidden = true
        /*
         case fullScreen
         case pageSheet
         case formSheet
         case currentContext
         case custom
         case overFullScreen
         case overCurrentContext
         case popover
         case none
         */
        nav.modalPresentationStyle = UIModalPresentationStyle.custom
        /*
         case coverVertical
         case flipHorizontal
         case crossDissolve
         case partialCurl
         从底部滑入，水平翻转，交叉溶解以及翻页
         }
         */
        nav.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(nav, animated: true, completion: nil)
    }
    
}
