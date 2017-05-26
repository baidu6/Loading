//
//  Swift实现简单的加载动画.swift
//  Loading
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class BasicLoadingAnimationViewController: UIViewController {
    
    let animationDuration:CFTimeInterval = 1
    var loadingView:UIView = UIView(frame: CGRect(x: (KWidth - 100) * 0.5, y: 100, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(loadingView)
        
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0, 0.12, 0.24, 0.36, 0.48, 0.6, 0.72, 0.84]
        let animation = creatAnimation()
        
        for i in 0..<8{
            let layer = creatCircle(angle: CGFloat(CGFloat(M_PI_4) * CGFloat(i)), size:CGSize(width: 16, height: 16) , origin: CGPoint(x: 50, y: 50), containerSize: CGSize(width:100,height:100), color: UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1))
            animation.beginTime = beginTime + beginTimes[i]
            layer.add(animation, forKey: "animation")
            loadingView.layer.addSublayer(layer)
        }
    }
    
    func creatAnimation() -> CAAnimationGroup {
        //透明度变化
        let opacityAni = CAKeyframeAnimation(keyPath: "opacity")
        opacityAni.keyTimes = [0,0.5,1]
        opacityAni.values = [1,0.3,1]
        opacityAni.duration = animationDuration

        
        //大小变化
        let scaleAni = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAni.keyTimes = [0,0.5,1]
        scaleAni.values = [1,0.3,1]
        scaleAni.duration = animationDuration

        //组动画
        let animation = CAAnimationGroup()
        animation.animations = [opacityAni,scaleAni]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = animationDuration
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
    //MARK:创建圈圈
    func creatCircle(angle:CGFloat,size:CGSize,origin:CGPoint,containerSize:CGSize,color:UIColor) -> CAShapeLayer {
        let radius = containerSize.width * 0.5
        let layer = creatLayer(size: size, color: color)
        let frame = CGRect(x:origin.x + radius * cos(angle + 1) - size.width * 0.5, y: origin.y + radius * sin(angle + 1) - size.width * 0.5, width: size.width, height: size.height)
        layer.frame = frame
        return layer
    }
    
    //MARK:创建小圆点
    func creatLayer(size:CGSize,color:UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath(arcCenter:  CGPoint(x: size.width * 0.5, y: size.height * 0.5), radius: size.width * 0.5, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        layer.path = path.cgPath
        layer.lineWidth = 2
        layer.fillColor = color.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
        return layer
    }
}
