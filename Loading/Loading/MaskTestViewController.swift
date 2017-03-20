//
//  MaskTestViewController.swift
//  Loading
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class MaskTestViewController: UIViewController {
    
    fileprivate lazy var gradientV:GradientLoadingView = GradientLoadingView(frame: CGRect(x: 50, y: 200, width: KWidth - 100, height: 30))
    fileprivate lazy var displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(startAnimation))
    var percent:CGFloat = 0
    
    fileprivate lazy var colorProgress:ColorProgressView = ColorProgressView(frame: CGRect(x: 30, y: 350, width: KWidth - 60, height: 30))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addColorsProgress()
        
        
        view.addSubview(gradientV)
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    func startAnimation() -> Void {
        percent += 0.01
        if percent >= 1.0{
            percent = 0.00
        }
        gradientV.loadingAnimation(percent: percent)
    }
    
    fileprivate func addColorsProgress(){
        view.addSubview(colorProgress)
    }
  
}

class GradientLoadingView: UIView {
    
    fileprivate lazy var backgroundLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        layer.cornerRadius = self.frame.height * 0.5
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        return layer
    }()
    
    fileprivate lazy var gradientLayer:CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        layer.cornerRadius = self.frame.size.height * 0.5
        layer.masksToBounds = true
        layer.colors = [UIColor.orange.cgColor,UIColor.yellow.cgColor,UIColor.green.cgColor,UIColor.blue.cgColor]
        layer.locations = [0.2,0.4,0.6,0.8]
        //渐变开始和结束的位置
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        return layer
    }()
    
    fileprivate lazy var maskLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height)
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() -> Void{
        self.layer.addSublayer(backgroundLayer)
        self.layer.addSublayer(gradientLayer)
        gradientLayer.mask = maskLayer
    }
    
    func loadingAnimation(percent:CGFloat) -> Void {
        let width = self.frame.size.width * percent
        maskLayer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ColorProgressView: UIView {
    
    fileprivate lazy var downView:UIView = UIView()
    fileprivate lazy var downLabel:UILabel = UILabel()
    fileprivate lazy var upView:UIView = UIView()
    fileprivate lazy var upLabel:UILabel = UILabel()
    fileprivate lazy var colorLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(changeColor))
    var i:CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        colorLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
       
    }
    
    //MARK:setupUI
    fileprivate func setupUI(){
        downView.frame = self.bounds
        downView.layer.cornerRadius = 5
        downView.layer.masksToBounds = true
        downView.backgroundColor = UIColor.white
        self.addSubview(downView)
        
        downLabel.frame = self.bounds
        downLabel.text = "WangYun - IOSProgrammer"
        downLabel.textColor = UIColor.red
        downLabel.textAlignment = NSTextAlignment.center
        downLabel.font = UIFont.systemFont(ofSize: 15)
        downLabel.layer.borderColor = UIColor.red.cgColor
        downLabel.layer.borderWidth = 0.5
        downView.addSubview(downLabel)
        
        upView.frame = CGRect(x: 0, y:0, width: 0, height: self.frame.height)
        upView.backgroundColor = UIColor.red
        upView.layer.masksToBounds = true
        upView.layer.cornerRadius = 5
        self.addSubview(upView)
        
        upLabel.frame = self.bounds
        upLabel.text = "WangYun - IOSProgrammer"
        upLabel.textColor = UIColor.white
        upLabel.textAlignment = NSTextAlignment.center
        upLabel.font = UIFont.systemFont(ofSize: 15)
        upLabel.layer.borderColor = UIColor.red.cgColor
        upLabel.layer.borderWidth = 0.5
        upView.addSubview(upLabel)
    }
    
    //MARK:改变颜色状态
    func changeColor() -> Void {
        i += 0.01
        if i >= 1.0{
            i = 0.00
        }
        var frame = upView.frame
        frame.size.width = i * self.frame.size.width
        upView.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


