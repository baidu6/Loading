//
//  CircleSpreadPresentedViewController.swift
//  Loading
//
//  Created by mac on 2017/2/16.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
enum CircleSpreadTransitionType {
    case present
    case dismiss
}

class CircleSpreadPresentedViewController: UIViewController {
    lazy var button:UIButton = UIButton(frame:CGRect(x: (KWidth - 50) * 0.5, y: (KHeight - 50) * 0.5, width: 50, height: 50))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        
        
        view.backgroundColor = UIColor.purple
      
        button.setTitle("点我返回", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        view.addSubview(button)
        button.addTarget(self, action: #selector(dismissVC), for: UIControlEvents.touchUpInside)
    }
    
    func dismissVC() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("CircleSpreadPresentedViewController---销毁了")
    }
}

extension CircleSpreadPresentedViewController:UIViewControllerTransitioningDelegate{
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleSpreadTransition.circleSpreadTransition(type: CircleSpreadTransitionType.dismiss)
 
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleSpreadTransition.circleSpreadTransition(type: CircleSpreadTransitionType.present)
    }
}

class CircleSpreadTransition: NSObject,UIViewControllerAnimatedTransitioning{
   
    
    static var transitionType:CircleSpreadTransitionType!
    
    override init() {
        super.init()
    }
    
    class func circleSpreadTransition(type:CircleSpreadTransitionType) -> CircleSpreadTransition{
        self.transitionType = type
        return CircleSpreadTransition()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if CircleSpreadTransition.transitionType == CircleSpreadTransitionType.present{
            print("present")
            self.presentAnimation(transitionContext: transitionContext)

        }else if CircleSpreadTransition.transitionType == CircleSpreadTransitionType.dismiss{
            print("dismiss")
            self.dismissAnimation(transitionContext: transitionContext)
        }
    }
    
    func presentAnimation(transitionContext:UIViewControllerContextTransitioning) -> Void {
        // UITransitionContextToViewControllerKey
        // UITransitionContextFromViewControllerKey.
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CircleSpreadViewController
        let containerView = transitionContext.containerView
        if let fromVC = fromVC{
            if let toVC = toVC{
                containerView.addSubview(toVC.view)
            }
       
            //如果rect是正方形，是内切圆，如果rect是长方形，是内切椭圆
            let startPath = UIBezierPath(ovalIn: fromVC.button.frame)
            let x:CGFloat = max(fromVC.button.frame.origin.x, containerView.frame.width - fromVC.button.frame.origin.x)
            let y:CGFloat = max(fromVC.button.frame.origin.y, containerView.frame.height - fromVC.button.frame.origin.y)
            let radius:CGFloat = sqrt(pow(x, 2) + pow(y, 2))
            let endPath = UIBezierPath(arcCenter: containerView.center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = endPath.cgPath
            //将maskLayer作为toVC.View的遮盖
            toVC?.view.layer.mask = shapeLayer
            
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = self.transitionDuration(using: transitionContext)
            animation.fromValue = startPath.cgPath
            animation.toValue = endPath.cgPath
            animation.delegate = self
            animation.setValue(transitionContext, forKey: "transitionContext")
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            shapeLayer.add(animation, forKey: "path")
        }
    }
    
    func dismissAnimation(transitionContext:UIViewControllerContextTransitioning) -> Void {
        
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CircleSpreadViewController
//        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        if let toVC = toVC{
            
            //如果rect是正方形，是内切圆，如果rect是长方形，是内切椭圆
            let endPath = UIBezierPath(ovalIn: toVC.button.frame)
            let radius:CGFloat = sqrt(containerView.frame.size.width * containerView.frame.size.width + containerView.frame.size.height * containerView.frame.height) * 0.5
            let startPath = UIBezierPath(arcCenter: containerView.center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)

            let shapeLayer = CAShapeLayer()
            //将maskLayer作为fromVC.View的遮盖
            fromView?.layer.mask = shapeLayer
            
            //创建路径动画
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = self.transitionDuration(using: transitionContext)
            animation.fromValue = startPath.cgPath
            animation.toValue = endPath.cgPath
            animation.delegate = self
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.setValue(transitionContext, forKey: "transitionContext")
            shapeLayer.add(animation, forKey: "path")
        }
    }
}

//MARK:动画的代理方法
extension CircleSpreadTransition:CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if CircleSpreadTransition.transitionType == CircleSpreadTransitionType.present{
            let transitionContext = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning
            transitionContext.completeTransition(true)
        }else if CircleSpreadTransition.transitionType == CircleSpreadTransitionType.dismiss{
            let transitionContext = anim.value(forKey: "transitionContext") as! UIViewControllerContextTransitioning
            transitionContext.completeTransition(!(transitionContext.transitionWasCancelled))
            if transitionContext.transitionWasCancelled == true{
                let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
                fromView?.layer.mask = nil
            }
        }
    }
}










