//
//  LoadingIndicatorViewController.swift
//  Loading
//
//  Created by mac on 2017/2/8.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class LoadingIndicatorViewController:UIViewController{
    
    fileprivate lazy var lineScaleV:LoadingScaleView = LoadingScaleView(frame: CGRect(x: 10, y: 150, width: UIScreen.main.bounds.width - 20, height: 30))
    fileprivate lazy var circleScaleV:LoadingCircleView = LoadingCircleView(frame: CGRect(x: (UIScreen.main.bounds.width - 200) * 0.5, y: 150, width:200, height: 200))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        lineScaleView()
        circleScaleView()
    }
    
    //MARK:线性进度条
    func lineScaleView() -> Void {
        lineScaleV.backgroundColor = UIColor.white
        lineScaleV.bgViewBgColor = UIColor.blue
        lineScaleV.scaleBgColor = UIColor.orange
        view.addSubview(lineScaleV)
    }
    
    func circleScaleView() -> Void {
        circleScaleV.backgroundColor = UIColor.white
        view.addSubview(circleScaleV)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        lineScaleV.changeScale(currentV: 900)
        circleScaleV.changeScale(currentV: 90)
    }
}

//MARK:线性进度view
class LoadingScaleView: UIView {
    //背景view的背景颜色
    var bgViewBgColor:UIColor?{
        didSet{
            bgView.backgroundColor = bgViewBgColor
        }
    }
    //显示比例的view的背景颜色
    var scaleBgColor:UIColor?{
        didSet{
            scaleView.backgroundColor = scaleBgColor
        }
    }
    
    //总的数值
    lazy var maxValue:CGFloat = 1000
    //当前数值
    lazy var currentValue:CGFloat = 300
    //背景view
    fileprivate lazy var bgView:UIView = UIView()
    //显示比例的view
    fileprivate lazy var scaleView:UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        bgView.layer.borderColor = UIColor.clear.cgColor
        bgView.layer.borderWidth = 0.5
        bgView.layer.cornerRadius = self.frame.height * 0.5
        bgView.layer.masksToBounds = true
        self.addSubview(bgView)
        
        scaleView.frame = CGRect(x: 0, y: 0, width: 0, height: self.frame.height)
        scaleView.layer.borderColor = UIColor.clear.cgColor
        scaleView.layer.borderWidth = 0.5
        scaleView.layer.cornerRadius = self.frame.height * 0.5
        scaleView.layer.masksToBounds = true
        self.addSubview(scaleView)
    }
    
    //MARK:改变比例
    func changeScale(currentV:CGFloat) -> Void {
        currentValue = currentV
        scaleAnimation()
    }
    
    //MARK:动画
    func scaleAnimation() -> Void {
        var frame = scaleView.frame
        UIView.animate(withDuration: 2.0) {
           frame.size.width = (self.currentValue / self.maxValue) * self.frame.size.width
            self.scaleView.frame = frame
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        scaleAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class LoadingCircleView: UIView {
    var maxValue:CGFloat = 100
    var currentValue:CGFloat = 50
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5), radius:self.frame.size.width * 0.5 - 10 * 0.5, startAngle: -(CGFloat)(M_PI_2), endAngle: CGFloat(M_PI * 1.5), clockwise: true)
        UIColor.blue.setStroke()
        path.lineWidth = 10
        path.stroke()
        
        circleAnimation()
    }
    
    func changeScale(currentV:CGFloat) -> Void {
        self.currentValue = currentV
        self.circleAnimation()
    }
    
    func circleAnimation() -> Void {
        //添加layer
        let layer = CAShapeLayer()
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5), radius:self.frame.size.width * 0.5 - 10 * 0.5, startAngle: -(CGFloat)(M_PI_2), endAngle: CGFloat(-M_PI_2) + currentValue / maxValue * CGFloat(M_PI) * 2, clockwise: true)
        layer.frame = self.bounds
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.orange.cgColor
        layer.lineWidth = 10
        layer.lineCap = kCALineCapRound
        self.layer.addSublayer(layer)
        
        //添加动画
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2.0
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: 1)
        layer.add(animation, forKey: "strokeEndAnimation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
