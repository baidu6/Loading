//
//  ADViewController.swift
//  Loading
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
import SDWebImage

class ADViewController : UIViewController{
    
    let skipButtonWidth:CGFloat = 50
    let skipButtonHeight:CGFloat = 50
    var leftTime = 3
    var skipShapeLayer:CAShapeLayer!
    
    //是否显示页面
    var visiable = true
    
    typealias ADCompleteBlock = () -> Void
    var complete:ADCompleteBlock?
    
    fileprivate var timer:Timer!
    
    fileprivate lazy var bgImageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(imageView)
        self.view.bringSubview(toFront: self.skipButton)
        return imageView
    }()
    
    fileprivate lazy var skipButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("跳过\(self.leftTime)s", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = UIColor.black
        btn.titleLabel?.textAlignment = NSTextAlignment.center
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        if visiable == false {
            self.complete?()
            return
        }
        setupUI()
        loadImage()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        bgImageView.isUserInteractionEnabled = true
        bgImageView.addGestureRecognizer(tapGesture)
  
    }
    
    func setupUI() -> Void {
        skipButton.frame = CGRect(x: self.view.frame.size.width - skipButtonWidth - 16, y: 30, width: skipButtonWidth, height: skipButtonHeight)
        skipButton.backgroundColor = UIColor.black
        skipButton.addTarget(self, action: #selector(skip), for: UIControlEvents.touchUpInside)
        skipButton.layer.cornerRadius = skipButtonWidth * 0.5
        skipButton.layer.masksToBounds = true
        self.view.addSubview(skipButton)
        
        let strokeAnimate = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimate.fromValue = NSNumber(value: 0)
        strokeAnimate.toValue = NSNumber(value: 1)
        strokeAnimate.duration = 3
        strokeAnimate.autoreverses = false
        strokeAnimate.setValue("strokeAnimate", forKey: "name")
        strokeAnimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        skipShapeLayer = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: skipButtonWidth, height: skipButtonWidth))
        skipShapeLayer.path = path.cgPath
        skipShapeLayer.fillColor = UIColor.clear.cgColor
        skipShapeLayer.strokeColor = UIColor.white.cgColor
        skipShapeLayer.lineWidth = 2
        skipShapeLayer.add(strokeAnimate, forKey: "strokeEndAnim")
        skipButton.layer.addSublayer(skipShapeLayer)
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
        }
    }
    
    //MARK:加载图片
    func loadImage() -> Void {
        let url = URL(string: "http://img.zcool.cn/community/01fe1757112d2d6ac72513436f2e6f.jpg")
        bgImageView.sd_setImage(with: url) { (_, _, _, _) in
            self.timer.fireDate = Date()
        }
    }
    
    //MARK:定时器
    func time() -> Void {
        skipButton.setTitle("跳过\(leftTime)s", for: UIControlState.normal)
        if leftTime == 0 {
            self.skip()
        }
        leftTime -= 1
    }
    
    //MARK:跳过
    func skip() -> Void {
        timer.fireDate = Date.distantFuture
        timer.invalidate()
        timer = nil
        self.complete?()
    }
    
    //MARK:点击背景图片
    func tap() -> Void {
        print("点击背景图片")
    }
    
    deinit {
        print("adViewController---deinit")
    }
}

