//
//  ApplauseViewController.swift
//  Loading
//
//  Created by mac on 2017/2/14.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit

let KWidth:CGFloat = UIScreen.main.bounds.width
let KHeight:CGFloat = UIScreen.main.bounds.height
class ApplauseViewController: UIViewController {
    
    fileprivate lazy var applauseButton:UIButton = UIButton(frame: CGRect(x: KWidth - 30 - 60, y: KHeight - 80 - 60, width: 60, height: 60))
    
    fileprivate lazy var countLabel:UILabel = UILabel(frame: CGRect(x:0, y:45, width: 60, height: 15))
    
    fileprivate var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() -> Void {
        applauseButton.setImage(UIImage(named:"applause"), for: UIControlState.normal)
        applauseButton.addTarget(self, action: #selector(applauseButtonDidClick), for: UIControlEvents.touchUpInside)
        applauseButton.adjustsImageWhenHighlighted = false
        view.addSubview(applauseButton)
        
        countLabel.textAlignment = NSTextAlignment.center
        countLabel.textColor = UIColor.white
        countLabel.font = UIFont.systemFont(ofSize: 14)
        countLabel.text = "\(0)"
        applauseButton.addSubview(countLabel)
    }
    
    //MARK:点击鼓掌按钮
    func applauseButtonDidClick() -> Void {
        count += 1
        countLabel.text = "\(count)"
        showApplauseAnimation()
    }
    
    //MARK:显示动画
    func showApplauseAnimation() -> Void {
        let index = arc4random()%7
        let imageView = UIImageView(image: UIImage(named: "applause_\(index)"))
        imageView.frame = CGRect(x: KWidth - 30 - 50, y: KHeight - 150, width: 40, height: 40)
        view.insertSubview(imageView, belowSubview: applauseButton)
        
        imageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        imageView.alpha = 0
        
        //弹出动画
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseOut, animations: {
            imageView.transform = CGAffineTransform.identity
            imageView.alpha = 0.9
        }) { (_) in
        }
        
        //1代表右边，-1代表左边
        let a = arc4random()%2
        var direction:CGFloat = 1
        if a == 0{
            direction = 1
        }else{
            direction = -1
        }
        let centerX:CGFloat = applauseButton.center.x
        let centerY:CGFloat = applauseButton.center.y
        let endPoint:CGPoint = CGPoint(x: centerX + direction * 10, y: 150)
        let controlPoint1:CGPoint = CGPoint(x: centerX + direction * CGFloat((arc4random()%20) + 50), y: centerY - 60 + CGFloat(arc4random()%50))
        let controlPoint2:CGPoint = CGPoint(x: centerX - direction * CGFloat((arc4random()%20) + 50), y: centerY - 90 + CGFloat(arc4random()%50))
        let path = UIBezierPath()
        path.move(to: imageView.center)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        keyframeAnimation.path = path.cgPath
        keyframeAnimation.duration = 3.0
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        imageView.layer.add(keyframeAnimation, forKey: "positionAnimation")
        
        UIView.animate(withDuration: 3.0, animations: {
            imageView.alpha = 0
        }) { (_) in
            imageView.removeFromSuperview()
        }
    }
}
