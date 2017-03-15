//
//  PopPresentedViewControoler.swift
//  Loading
//
//  Created by mac on 2017/2/17.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit

enum PopPresentTransitionType {
    case present
    case dismiss
}
class PopPresentedViewControoler: UIViewController {
    fileprivate lazy var button:UIButton = UIButton(frame: CGRect(x: (KWidth - 100) * 0.5, y: 150, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.custom
        view.backgroundColor = UIColor.green
        
        button.backgroundColor = UIColor.lightGray
        button.setTitle("点我消失", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 50
        button.addTarget(self, action: #selector(dismissVC), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
    }
    
    //MARK:消失
    func dismissVC() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PopPresentedViewControoler:UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PopPresentTransition.poTransition(type: PopPresentTransitionType.present)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopPresentTransition.poTransition(type: PopPresentTransitionType.dismiss)
    }
}

class PopPresentTransition: NSObject,UIViewControllerAnimatedTransitioning {
    static var transitionType:PopPresentTransitionType!
    
    override init() {
        super.init()
    }
    
    class func poTransition(type:PopPresentTransitionType) -> PopPresentTransition{
        self.transitionType = type
        return PopPresentTransition()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if PopPresentTransition.transitionType == PopPresentTransitionType.present{
            print("present")
            self.presentAnimation(transitionContext: transitionContext)
            
        }else if PopPresentTransition.transitionType == PopPresentTransitionType.dismiss{
            print("dismiss")
            self.dismissAnimation(transitionContext: transitionContext)
        }
        
    }
    
    func presentAnimation(transitionContext:UIViewControllerContextTransitioning) -> Void {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
       
        var temperView:UIView!
        if let fromVC = fromVC{
            temperView = fromVC.view.snapshotView(afterScreenUpdates: false)
            temperView.frame = fromVC.view.frame
            //因为对截图做动画，所以就对fromvc隐藏了
            fromVC.view.isHidden = true
            transitionContext.containerView.addSubview(temperView)
        }
        if let toVC = toVC{
            transitionContext.containerView.addSubview(toVC.view)
            //设置tovc的frame。因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
            toVC.view.frame = CGRect(x: 0, y: transitionContext.containerView.frame.height, width: transitionContext.containerView.frame.width, height: 400)
        }
        
        //开始动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            //让vc2向上移动
            toVC?.view.transform = CGAffineTransform(translationX: 0, y: -400)
            //让vc1整体比例缩小
            temperView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { (_) in
            //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在，会出现无法交互的情况，切记
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

            //转场失败后的处理
            if transitionContext.transitionWasCancelled == true{
                temperView.removeFromSuperview()
                fromVC?.view.isHidden = false
            }
        }
    }
    
    func dismissAnimation(transitionContext:UIViewControllerContextTransitioning) -> Void {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
        let subviews = transitionContext.containerView.subviews
        let temperView = subviews[min(subviews.count, max(0, subviews.count - 2))]
        
        //开始动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.55, options: UIViewAnimationOptions.curveEaseInOut, animations: {

            //让动画消失即可
            fromVC?.view.transform = CGAffineTransform.identity
            temperView.transform = CGAffineTransform.identity
        }) { (_) in
            if transitionContext.transitionWasCancelled == true{
                transitionContext.completeTransition(false)
            }else{
                transitionContext.completeTransition(true)
                toVC?.view.isHidden = false
                temperView.removeFromSuperview()
            }
        }
    }
}
