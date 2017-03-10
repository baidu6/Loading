//
//  CountingViewController.swift
//  Loading
//
//  Created by mac on 2017/3/6.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class CountingViewController: UIViewController {
    fileprivate lazy var countingView:CountingView = CountingView(frame: CGRect(x: (KWidth - 100) * 0.5, y: 150, width: 100, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }
    func setupUI() -> Void {
        view.addSubview(countingView)
        
        //局部圆角问题
        let button = UIButton(frame: CGRect(x: 10, y: 300, width: 100, height: 40))
        button.backgroundColor = UIColor.orange
        view.addSubview(button)
        let path = UIBezierPath(roundedRect:CGRect(x: 0, y: 0, width: 100, height: 40) , byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 5, height: 5))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.frame = button.bounds
        button.layer.mask = shapeLayer
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        countingView.changeAnimation()
    }
}

class CountingView: UIView {
    fileprivate lazy var lastLabel:UILabel = UILabel()
    fileprivate lazy var currentLabel:UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() -> Void {
        
        let height:CGFloat = self.frame.size.height
        let width:CGFloat = self.frame.size.width
        
        currentLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
        currentLabel.textColor = UIColor.black
        currentLabel.font = UIFont.systemFont(ofSize: 15)
        currentLabel.textAlignment = NSTextAlignment.center
        currentLabel.text = "123456"
        
        lastLabel.frame = CGRect(x: 0, y: height, width: width, height: height)
        lastLabel.textColor = UIColor.black
        lastLabel.alpha = 0
        lastLabel.font = UIFont.systemFont(ofSize: 15)
        lastLabel.textAlignment = NSTextAlignment.center
        lastLabel.text = "123457"
        
        self.addSubview(lastLabel)
        self.addSubview(currentLabel)
        
        currentLabel.backgroundColor = UIColor.white
        lastLabel.backgroundColor = UIColor.white
    }
    func changeAnimation() -> Void {
        let height:CGFloat = self.frame.size.height
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.lastLabel.transform = CGAffineTransform(translationX: 0, y: -height)
            self.currentLabel.transform = CGAffineTransform(translationX: 0, y: height)
            self.currentLabel.alpha = 0
            self.lastLabel.alpha = 1
        }) { (_) in
            
//            let lastL = self.lastLabel
//            let currentL = self.currentLabel
//            self.lastLabel = currentL
//            self.currentLabel = lastL
        }
    }
}
