//
//  LoginTextFieldAnimationViewController.swift
//  Loading
//
//  Created by mac on 2017/2/9.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class LoginTextFieldAnimationViewController: UIViewController {
    
    lazy var usernameTextF:LoginTextField = LoginTextField(frame:CGRect(x: 30, y: 260, width:UIScreen.main.bounds.width - 60, height: 44))
    lazy var loginView:LoginButtonWithLoading = LoginButtonWithLoading(frame: CGRect(x:30, y: 350, width: UIScreen.main.bounds.width - 60, height: 44))
    
    fileprivate lazy var temperButton:UIButton = UIButton(frame:CGRect(x: 30, y: 450, width: UIScreen.main.bounds.width - 60, height: 44))
    
    fileprivate lazy var temperLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.opacity = 0
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
    
        layer.position = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: 450 + 22)
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x:0, y:0), radius: 21, startAngle: CGFloat(M_PI * 0.5), endAngle: CGFloat(M_PI), clockwise: false)
        layer.path = path.cgPath
        layer.lineWidth = 2
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        setupUI()
    }
    
    //MARK:setupUI
    func setupUI() -> Void {
        view.addSubview(usernameTextF)
        view.addSubview(loginView)
        
        temperButton.layer.cornerRadius = 22
        temperButton.layer.masksToBounds = true
        temperButton.backgroundColor = UIColor.white
        temperButton.setTitle("OK", for: UIControlState.normal)
        temperButton.setTitleColor(UIColor.red, for: UIControlState.normal)
        temperButton.addTarget(self, action: #selector(temperButtonDidClick), for: UIControlEvents.touchUpInside)
        view.addSubview(temperButton)
    }
    
    func temperButtonDidClick() -> Void {
        let rect = CGRect(x: UIScreen.main.bounds.width * 0.5 - 22, y: 450, width: self.temperButton.frame.height, height: self.temperButton.frame.height)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.temperButton.frame = rect
        }) { (_) in
            self.view.layer.addSublayer(self.temperLayer)
            self.temperLayer.opacity = 1
            self.temperLayerAnimation()
        }
    }
    
    func temperLayerAnimation() -> Void {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 0.5
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: M_PI * 2)
        animation.repeatCount = MAXFLOAT
        temperLayer.add(animation, forKey: "temperLayerAnimation")
    }
}


//MARK:登录加载按钮
class LoginButtonWithLoading: UIView {
    
    fileprivate lazy var loginButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("SIGN IN", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(loginBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    fileprivate lazy var shapeLayer:CAShapeLayer = CAShapeLayer()
    fileprivate lazy var circleLayer = CAShapeLayer()
    fileprivate lazy var loadingLayer = CAShapeLayer()
    

    fileprivate lazy var maskLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.opacity = 0
        layer.fillColor = UIColor.white.cgColor
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5), radius: self.frame.height * 0.5, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
        return layer
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loginButton.frame = self.bounds
        self.addSubview(loginButton)
        
        shapeLayer.frame = self.bounds
        shapeLayer.path = self.drawBezierPath().cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2
        self.layer.addSublayer(shapeLayer)
    }
    
    //MARK:点击登录按钮
    func loginBtnClick() -> Void{
        startAnimation()
    }
    
    //MARK:开始动画
    func startAnimation() -> Void {
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        circleLayer.path = self.creatCirclePath(radius: 0).cgPath
        self.layer.addSublayer(circleLayer)
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.15
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.toValue = self.creatCirclePath(radius: (self.frame.height - 20) * 0.5).cgPath
        circleLayer.add(animation, forKey: "path")
        
        self.perform(#selector(clickNextAnimation), with: self, afterDelay: 0.15)
    }
    
    func clickNextAnimation() -> Void {
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 10
        let animationGroup = CAAnimationGroup()
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.duration = 0.15
        pathAnimation.toValue = self.creatCirclePath(radius: (self.frame.height - 10) * 0.5).cgPath
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = kCAFillModeForwards
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.beginTime = 0.15
        opacityAnimation.duration = 0.15
        opacityAnimation.fromValue = NSNumber(value: 1.0)
        opacityAnimation.toValue = NSNumber(value: 0)
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.fillMode = kCAFillModeForwards
        
        animationGroup.animations = [pathAnimation,opacityAnimation]
        animationGroup.duration = 3.0
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = kCAFillModeForwards
        circleLayer.add(animationGroup, forKey: "group")
        
        self.perform(#selector(startMaskAnimation), with: self, afterDelay: 0.3)
    }
    
    func startMaskAnimation() -> Void {
        maskLayer.opacity = 0.15
        let animation = CABasicAnimation(keyPath: "path")
        let path = UIBezierPath()
        path.addArc(withCenter:CGPoint(x: self.frame.width - self.frame.height * 0.5, y: self.frame.height * 0.5) , radius: self.frame.height * 0.5, startAngle: CGFloat(-M_PI * 0.5), endAngle: CGFloat(M_PI * 0.5), clockwise: true)
        path.addArc(withCenter: CGPoint(x:self.frame.height * 0.5, y: self.frame.height * 0.5) , radius: self.frame.height * 0.5, startAngle: CGFloat(M_PI * 0.5), endAngle:CGFloat(-M_PI * 0.5), clockwise: true)
        path.close()
        animation.toValue = path.cgPath
        animation.duration = 0.25
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        maskLayer.add(animation, forKey: "path")
        self.perform(#selector(dismissAnimation), with: self, afterDelay: 0.3)
    }
    
    func dismissAnimation() -> Void {
        removeSubviews()
        let animationGroup = CAAnimationGroup()
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.duration = 0.15
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5), radius: self.frame.height * 0.5, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        pathAnimation.toValue = path.cgPath
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = kCAFillModeForwards
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = 0.15
        opacityAnimation.toValue = NSNumber(value: 0)
        opacityAnimation.beginTime = 0.1
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.fillMode = kCAFillModeForwards
        
        animationGroup.animations = [pathAnimation,opacityAnimation]
        animationGroup.duration = 0.3
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = kCAFillModeForwards
        shapeLayer.add(animationGroup, forKey: "dismissGroup")
        self.perform(#selector(loadingAnimations), with: self, afterDelay: 0.3)
    }
    
    func loadingAnimations() -> Void {
        loadingLayer.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5)
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x:0, y: 0), radius: self.frame.size.height * 0.5, startAngle: CGFloat(M_PI * 0.5), endAngle: CGFloat(M_PI), clockwise: false)
        loadingLayer.lineWidth = 2
        loadingLayer.fillColor = UIColor.clear.cgColor
        loadingLayer.strokeColor = UIColor.white.cgColor
        self.layer.addSublayer(loadingLayer)
        loadingLayer.path = path.cgPath
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = NSNumber(value:0)
        animation.toValue = NSNumber(value: 2 * M_PI)
        animation.duration = 0.5
        animation.repeatCount = MAXFLOAT
        loadingLayer.add(animation, forKey: "loadingAnimation")
    }
    
    func removeSubviews() -> Void {
        loginButton.removeFromSuperview()
        maskLayer.removeFromSuperlayer()
        circleLayer.removeFromSuperlayer()
        loadingLayer.removeFromSuperlayer()
    }
    
    func drawBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        let radius:CGFloat = self.frame.height * 0.5
        path.addArc(withCenter: CGPoint(x:self.frame.height * 0.5 , y:self.frame.height * 0.5), radius: radius, startAngle: CGFloat(M_PI_2), endAngle: -(CGFloat)(M_PI_2), clockwise: true)
        path.addArc(withCenter: CGPoint(x:self.frame.width  - self.frame.height * 0.5, y:self.frame.height * 0.5), radius: radius, startAngle: -(CGFloat)(M_PI_2), endAngle: CGFloat(M_PI_2), clockwise: true)
        path.close()
        return path
    }
    
    //MARK:创建圆形路径
    func creatCirclePath(radius:CGFloat) -> UIBezierPath {
       let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: 0, y: 0), radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        return path
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LoginTextField: UITextField {
    
    fileprivate var placeholderStr:String?
    fileprivate lazy var placeholderLabel:UILabel = UILabel()
    fileprivate lazy var underLine:UIView = UIView()
    fileprivate lazy var textField:UITextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name:NSNotification.Name.UITextFieldTextDidChange, object: textField)
    }
    
    //MARK:textField的文字发生改变
    func textFieldDidChange() -> Void {
        if textField.text?.characters.count == 0{
            backEndAnimation()
        }else{
            movebeginAnimation()
        }
    }
    
    //MARK:改变placeholderLabel的位置
    func movebeginAnimation() -> Void {
        var frame = placeholderLabel.frame
        frame.origin.y = -10
        frame.origin.x = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.placeholderLabel.font = UIFont.systemFont(ofSize: 10)
            self.placeholderLabel.frame = frame
        }) { (_) in
            
        }
        underLine.backgroundColor = UIColor.white
    }
    
    //MARK:还原placeholderLabel的位置
    func backEndAnimation() -> Void {
        var frame = placeholderLabel.frame
        frame.origin.y = self.frame.size.height * 0.5 - 20 * 0.5
        frame.origin.x = 5
        placeholderLabel.font = UIFont.systemFont(ofSize: 10)
        UIView.animate(withDuration: 0.25, animations: {
            self.placeholderLabel.frame = frame
            self.placeholderLabel.font = UIFont.systemFont(ofSize: 15)
        }) { (_) in
            
        }
        underLine.backgroundColor = UIColor.darkGray
    }
    
    //MARK:设置UI
    func setupUI() -> Void {
        textField.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.size.height)
        textField.backgroundColor = UIColor.blue
        textField.borderStyle = UITextBorderStyle.none
        textField.tintColor = UIColor.white
        textField.textColor = UIColor.white
        self.addSubview(textField)
        
        placeholderLabel.frame = CGRect(x: 5, y: self.frame.size.height * 0.5 - 20 * 0.5, width: self.frame.width - 5, height:20)
        placeholderLabel.font = UIFont.systemFont(ofSize: 15)
        placeholderLabel.textColor = UIColor.black
        placeholderLabel.textAlignment = NSTextAlignment.left
        placeholderLabel.text = "Username"
        self.addSubview(placeholderLabel)
        
        underLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        underLine.backgroundColor = UIColor.orange
        self.addSubview(underLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

