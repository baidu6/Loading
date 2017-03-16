//
//  NavWaveViewController.swift
//  Loading
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class NavWaveViewController: UIViewController {
    
    fileprivate lazy var waveV:NavWaveView = NavWaveView(frame: CGRect(x: 0, y: 100, width: KWidth, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupUI()
    }
    
    //MARK:setupNav
    func setupNav() -> Void {
        
        self.navigationItem.title = "双波浪动画"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
    }
    
    //MARK:setupUI
    func setupUI() -> Void{
        view.backgroundColor = UIColor.white
        view.addSubview(waveV)
        
    }
    
    //MARK:back
    func back() -> Void {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
