//
//  MenuDetailViewController.swift
//  Loading
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class MenuDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var imageName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        if let name = imageName{
            imageView.image = UIImage(named: name)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

