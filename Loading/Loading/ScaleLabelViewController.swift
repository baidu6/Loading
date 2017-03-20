//
//  ScaleLabelViewController.swift
//  Loading
//
//  Created by mac on 2017/3/20.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class ScaleLabelViewController: UIViewController {
    fileprivate lazy var scaleLabelV:ScaleLabelView = ScaleLabelView(frame: CGRect(x: 30, y: 150, width: KWidth - 60, height: 30))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        
        view.backgroundColor = UIColor.black
        view.addSubview(scaleLabelV)
        scaleLabelV.startAnimation()
    }
    
    //MARK:设置导航
    func setupNav() -> Void {
        self.navigationItem.title = "UILabel的缩放动画"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
    }
    
    //MARK:返回
    func back() -> Void {
        dismiss(animated: true, completion: nil)
    }
}

class ScaleLabelView: UIView {
    
    var text:String = "Wangyun Nice Girl Beautiful"
    
    var font:UIFont = UIFont.systemFont(ofSize: 15)
    
    var startScale:CGFloat = 0.3
    
    var endScale:CGFloat = 2
    
    var backLabelColor:UIColor = UIColor.white
    
    var colorLabelColor:UIColor = UIColor.cyan
    
    fileprivate lazy var backLabel:UILabel = UILabel()
    
    fileprivate lazy var colorLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    fileprivate func setupUI() ->Void{
        backLabel.frame = self.bounds
        backLabel.text = text
        backLabel.font = font
        backLabel.alpha = 0
        backLabel.textColor = backLabelColor
        backLabel.textAlignment = NSTextAlignment.center
        backLabel.transform = CGAffineTransform(a: startScale, b: 0, c: 0, d: startScale, tx: 0, ty: 0)
        self.addSubview(backLabel)
        
        colorLabel.frame = self.bounds
        colorLabel.text = text
        colorLabel.font = font
        colorLabel.alpha = 0
        colorLabel.textColor = colorLabelColor
        colorLabel.textAlignment = NSTextAlignment.center
        colorLabel.transform = CGAffineTransform(a: startScale, b: 0, c: 0, d: startScale, tx: 0, ty: 0)
        self.addSubview(colorLabel)
    }
    
    //MARK:开始动画
    func startAnimation() -> Void {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 8, initialSpringVelocity: 4, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.backLabel.alpha = 1
            self.backLabel.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
            
            self.colorLabel.alpha = 1
            self.colorLabel.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
            
        }) { (_) in
            UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 8, initialSpringVelocity: 4, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.colorLabel.transform = CGAffineTransform(a: self.endScale, b: 0, c: 0, d: self.endScale, tx: 0, ty: 0)
                self.colorLabel.alpha = 0
            }, completion: { (_) in
                
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
