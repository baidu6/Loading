//
//  BaseDragerViewController.swift
//  Loading
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
fileprivate let KMargin:CGFloat = 5
fileprivate let KEdgeMargin:CGFloat = 60
fileprivate let KAnimaDuration:TimeInterval = 0.25
enum DragerStyle{
    case defaultStyle
    case left
    case right
    case same
}

class BaseDragerViewController: UIViewController {
    
    
    lazy var leftView:UIView = UIView()
    lazy var rightView:UIView = UIView()
    lazy var mainView:UIView = UIView()
    
    //<左滑至右边>
    var KTargetRight:CGFloat = UIScreen.main.bounds.width - KEdgeMargin
    //<右滑至左边>
    var KTargetLeft:CGFloat = UIScreen.main.bounds.width - KEdgeMargin
    
    //默认是左右滑动高度都变化
    var KDirection:DragerStyle = DragerStyle.left
    
    //默认是100
    var KMaxY:CGFloat = 100
    
    //默认是不允许右侧可以滑动的
    var isPanRightEnabled:Bool = true
    
    //默认是从左到右
    static var isDirection:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
    }
    
    func setupUI() -> Void {
        view.backgroundColor = UIColor.lightGray
        
        //添加leftView
        leftView.frame = view.bounds
        leftView.backgroundColor = UIColor.white
        view.addSubview(leftView)
        
        //添加rightView
        rightView.frame = view.bounds
        rightView.backgroundColor = UIColor.white
        view.addSubview(rightView)
        
        //添加mainView
        mainView.frame = view.bounds
        mainView.backgroundColor = UIColor.white
        view.addSubview(mainView)
        
        //给mainView添加投影
        mainView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        mainView.layer.shadowOffset = CGSize(width: -2, height: -1)
        mainView.layer.shadowOpacity = 0.7
        mainView.layer.shadowRadius = 2
    }
    
    func setupGesture() -> Void {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGes(pan:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGes(tap:)))
        mainView.addGestureRecognizer(panGesture)
        mainView.addGestureRecognizer(tapGesture)
    }
 
}

extension BaseDragerViewController{
    
    //MARK:外面点击左滑按钮调用
    func leftPanClick(btn:UIButton) -> Void {
        enableSubViews(isEnabled: false)
        btn.isSelected = !btn.isSelected
        if mainView.frame.origin.x >= 0{
            rightView.isHidden = true
            leftView.isHidden = false
            changeStatusWithLeft()
        }
    }
    
    //MARK:panGesture
    func panGes(pan:UIPanGestureRecognizer) -> Void {
        setupFrameOffset(panGes: pan)
    }
    
    //MARK:点击手势<点击的时候mainView恢复到原来的位置>
    func tapGes(tap:UITapGestureRecognizer) -> Void {
        enableSubViews(isEnabled: true)
        UIView.animate(withDuration: KAnimaDuration) {
           self.mainView.frame = self.view.bounds
        }
    }
    
    //MARK:滑动偏移量
    fileprivate func setupFrameOffset(panGes:UIPanGestureRecognizer) -> Void{
        //如果tranPoint.x > 0，说明是向右滑动的，反之，则是向左滑动的
        let tranPoint = panGes.translation(in: mainView)
        if tranPoint.x > 0{
            BaseDragerViewController.isDirection = false
        }else if tranPoint.x < 0{
            BaseDragerViewController.isDirection = true
        }
        
        if isPanRightEnabled == false,tranPoint.x < 0{
            if mainView.frame.origin.x == 0{
                mainView.frame = frameWithOffsetX(offsetX: 0)
            }else{
                mainView.frame.origin.x += tranPoint.x
                if mainView.frame.origin.x <= 0{
                    mainView.frame.origin.x = 0
                }
                let maxOffsetY:CGFloat = changeStyleWithDirection(type: KDirection)
                mainView.frame.origin.y = fabs(mainView.frame.origin.x * maxOffsetY / UIScreen.main.bounds.width)
                mainView.frame.size.height = UIScreen.main.bounds.height - 2 * mainView.frame.origin.y
            }
            panGes.setTranslation(CGPoint.zero, in: mainView)
            return
        }
        
        mainView.frame = frameWithOffsetX(offsetX: tranPoint.x)
        if mainView.frame.origin.x > 0{
            rightView.isHidden = true
            mainView.layer.shadowOffset = CGSize(width: -3, height: -1)
        }
        
        if mainView.frame.origin.x == 0{
            enableSubViews(isEnabled: true)
        }else{
            enableSubViews(isEnabled: false)
        }
        
        if mainView.frame.origin.x < 0{
            rightView.isHidden = false
            mainView.layer.shadowOffset = CGSize(width: 3, height: 1)
        }
        
        let velocity = panGes.velocity(in: mainView)
        if panGes.state == .ended {
            var target : CGFloat = 0
            if mainView.frame.origin.x > 0 {
                if velocity.x >= 0 {
                    if mainView.frame.origin.x > 5 {
                        target = KTargetRight
                    }
                }else {
                    enableSubViews(isEnabled: false)
                    if mainView.frame.origin.x < UIScreen.main.bounds.width - KMargin {
                        target = 0
                    }
                }
            }
            
            if mainView.frame.origin.x < 0 {
                if BaseDragerViewController.isDirection {
                    if mainView.frame.maxX < UIScreen.main.bounds.width  - KMargin {
                        target = -fabs(KTargetLeft)
                    }
                }
            }
            
            let offset : CGFloat = target - mainView.frame.origin.x
            UIView.animate(withDuration: KAnimaDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2, options: [], animations: {
                self.mainView.frame = self.frameWithOffsetX(offsetX: offset)
            }, completion: { (_) in
            })
        }
        if mainView.frame.origin.x > KTargetRight {
            mainView.frame.origin.x = KTargetRight
        }
        panGes.setTranslation(CGPoint.zero, in: mainView)
    }
    
    fileprivate func frameWithOffsetX(offsetX:CGFloat) -> CGRect{
        mainView.frame.origin.x += offsetX
        let maxOffsetY:CGFloat = changeStyleWithDirection(type: KDirection)
        mainView.frame.origin.y = fabs(mainView.frame.origin.x * maxOffsetY / UIScreen.main.bounds.width)
        mainView.frame.size.height = UIScreen.main.bounds.height - 2 * mainView.frame.origin.y
        return mainView.frame
    }
    
    fileprivate func changeStyleWithDirection(type:DragerStyle) -> CGFloat{
        var maxOffsetY:CGFloat = KMaxY
        if mainView.frame.origin.x > 0{//说明是向右滑动的
            switch type {
            case .left,.same:
                maxOffsetY = 0
            default:
                maxOffsetY = KMaxY
            }
        }else if mainView.frame.origin.x < 0{//说明是向左滑动的
            switch type {
            case .right,.same:
                maxOffsetY = 0
            default:
                maxOffsetY = KMaxY
            }
        }
        return maxOffsetY
    }
    
    //MARK:设置mainView中的子view是否可用
    fileprivate func enableSubViews(isEnabled:Bool) -> Void{
        for childView in mainView.subviews{
            childView.isUserInteractionEnabled = isEnabled
        }
    }
    
    //MARK:changeStatus
    fileprivate func changeStatusWithLeft() {
        var offset : CGFloat = 0
        if mainView.frame.origin.x == 0 {
            offset = KTargetRight
            
        }else {
            offset = -fabs(KTargetLeft)
        }
        UIView.animate(withDuration: KAnimaDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: [], animations: {
            self.mainView.frame = self.frameWithOffsetX(offsetX: offset)
        }, completion: { (_) in
            
        })
    }
}
