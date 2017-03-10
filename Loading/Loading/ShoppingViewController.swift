//
//  ShoppingViewCntroller.swift
//  Loading
//
//  Created by mac on 2017/2/9.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class ShoppingViewController: UIViewController {
    fileprivate var shopImageView:UIImageView = UIImageView(image: UIImage(named: "shop"))
    fileprivate var purchaseBtn:UIButton = UIButton()
    fileprivate var shopCarImageV:UIImageView = UIImageView(image: UIImage(named: "shopCar"))
    fileprivate var countLabel:UILabel = UILabel()
    fileprivate var count:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    //MARK:转场动画
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        /*
         type：过渡动画的类型
         
         type的enum值如下：
         kCATransitionFade 渐变
         kCATransitionMoveIn 覆盖,新视图移到旧视图上面
         kCATransitionPush 推出，新视图把旧视图推出去
         kCATransitionReveal 揭开，将旧视图移开，显示下面的新视图
         */
        
        /*
         subtype： 过渡动画的方向
         subtype的enum值如下：
         kCATransitionFromRight 从右边
         kCATransitionFromLeft 从左边
         kCATransitionFromTop 从顶部
         kCATransitionFromBottom 从底部
         */
        
        let transitionAni = CATransition()
        transitionAni.type = kCATransitionMoveIn
        transitionAni.subtype = kCATransitionFromBottom
        transitionAni.duration = 1.5
        shopCarImageV.layer.add(transitionAni, forKey: "transitionAni")
    }
    
    func setupUI() -> Void {
        
        //商品
        shopImageView.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
        shopImageView.layer.cornerRadius = 25
        shopImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shopImageView.layer.masksToBounds = true
        shopImageView.isHidden = true
        view.addSubview(shopImageView)
        
        //立即抢购
        purchaseBtn.frame = CGRect(x: 50, y: 400, width: 120, height: 44)
        purchaseBtn.backgroundColor = UIColor.red
        purchaseBtn.layer.cornerRadius = 8
        purchaseBtn.layer.masksToBounds = true
        purchaseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        purchaseBtn.setTitle("立即抢购", for: UIControlState.normal)
        purchaseBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        view.addSubview(purchaseBtn)
        purchaseBtn.addTarget(self, action: #selector(startAnimation), for: UIControlEvents.touchUpInside)
        
        //购物车
        shopCarImageV.frame = CGRect(x: view.bounds.width * 0.5 + 100, y: 300, width: 50, height: 50)
        view.addSubview(shopCarImageV)
        
        //添加购物数量
        countLabel.frame = CGRect(x: view.bounds.width * 0.5 + 100 + 50 - 10, y: 300, width: 20, height: 20)
        countLabel.layer.cornerRadius = 10
        countLabel.layer.masksToBounds = true
        countLabel.backgroundColor = UIColor.white
        countLabel.layer.borderColor = UIColor.red.cgColor
        countLabel.layer.borderWidth = 1
        countLabel.textAlignment = NSTextAlignment.center
        countLabel.font = UIFont.systemFont(ofSize: 15)
        countLabel.isHidden = true
        view.addSubview(countLabel)
    }
    
    //MARK:开始动画
    func startAnimation() -> Void {
        
        shopImageView.isHidden = false
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 50, y: 100))
        path.addQuadCurve(to: CGPoint(x: view.bounds.width * 0.5 + 100 + 25, y: 300 + 25), controlPoint: CGPoint(x: 150, y: 50))
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = path.cgPath
        positionAnimation.rotationMode = kCAAnimationRotateAuto
        
        let bigScaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        bigScaleAnimation.fromValue = NSNumber(value: 1)
        bigScaleAnimation.toValue = NSNumber(value: 2)
        bigScaleAnimation.duration = 0.5
        
        let smallScaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        smallScaleAnimation.fromValue = NSNumber(value: 2)
        smallScaleAnimation.toValue = NSNumber(value: 0.5)
        smallScaleAnimation.duration = 1.5
        smallScaleAnimation.beginTime = 0.5
        
        let groupAni = CAAnimationGroup()
        groupAni.delegate = self
        groupAni.animations = [positionAnimation,bigScaleAnimation,smallScaleAnimation]
        groupAni.duration = 2.0
        groupAni.fillMode = kCAFillModeForwards
        groupAni.isRemovedOnCompletion = false
        groupAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.shopImageView.layer.add(groupAni, forKey: "group")
    }
}

extension ShoppingViewController:CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if anim == shopImageView.layer.animation(forKey: "group"){
            count += 1
            countLabel.isHidden = false
            countLabel.text = "\(count)"
            shopImageView.isHidden = true
            
            let shakeAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            shakeAnimation.duration = 0.25
            shakeAnimation.fromValue = NSNumber(value: -5)
            shakeAnimation.toValue = NSNumber(value: 5)
            //autoreverses是否执行逆动画
            shakeAnimation.autoreverses = true
            shopCarImageV.layer.add(shakeAnimation, forKey: "shake")
        }
    }
}
