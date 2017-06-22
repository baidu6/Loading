//
//  ViewController.swift
//  Loading
//
//  Created by mac on 2017/2/7.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit

/*
 //rotation.x
 //rotation.y
 //rotation.z
 //rotation 旋轉
 //scale.x
 //scale.y
 //scale.z
 //scale 缩放
 //translation.x
 //translation.y
 //translation.z
 //translation 平移
 //CGPoint Key Paths : (example)position.x
 //x
 //y
 //CGRect Key Paths : (example)bounds.size.width
 //origin.x
 //origin.y
 //origin
 //size.width
 //size.height
 //size
 //opacity
 //backgroundColor
 //cornerRadius
 //borderWidth
 //contents
 //Shadow Key Path:
 //shadowColor
 //shadowOffset
 //shadowOpacity
 //shadowRadius
 
 timingFunctionName的enum值如下：
 kCAMediaTimingFunctionLinear 匀速
 kCAMediaTimingFunctionEaseIn 慢进
 kCAMediaTimingFunctionEaseOut 慢出
 kCAMediaTimingFunctionEaseInEaseOut 慢进慢出
 kCAMediaTimingFunctionDefault 默认值（慢进慢出）
 
 
 removedOnCompletion：动画执行完毕后是否从图层上移除，默认为YES（视图会恢复到动画前的状态），可设置为NO（图层保持动画执行后的状态，前提是fillMode设置为kCAFillModeForwards）
 */

class ViewController: UIViewController {
    let roataionAni:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    let scaleAni:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
    let translationAni:CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
    let positionAni:CABasicAnimation = CABasicAnimation(keyPath: "position")
    let boundsAni:CABasicAnimation = CABasicAnimation(keyPath: "bounds.size.width")
    let opacityAni:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
    let cornerAni:CABasicAnimation = CABasicAnimation(keyPath: "cornerRadius")
    let borderAni:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
    
    fileprivate lazy var imageView:UIImageView = UIImageView(image: UIImage(named: "5_05"))
    let rotationAni = CABasicAnimation(keyPath: "transform.rotation")
    
    
    fileprivate lazy var tableView:UITableView = UITableView(frame:  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
    
    fileprivate var titlesArr:[String] = ["登录捂眼动画","进度条动画","Loading动画","登录炫酷动画","加入购物车","签到动画","导航波纹","数字金额变化","鼓掌动画","手势密码解锁","转场动画--小圆点扩散","转场动画---弹性pop","网上学习布局方式练习","可以点击的饼图","导航波纹","IOS和H5手势交互","粒子点赞效果","仿UC头部下拉动画","数字上下滑动动画效果","高端理财","tableView点击状态的切换效果","牛逼的侧滑效果","长按移动标签","导航双波浪动画波纹","Menu动画","mask使用。渐变进度条","UILabel的缩放动画","导航头像缩放（随着滑动）","tableView的展开缩放动画","shining动画","点击tableView的cell的展开动画","searchBar的练习使用","YH弹窗的练习","swift简单的加载动画效果"]

    
    lazy var temperView:UIView = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        view.backgroundColor = UIColor.white
        setupTableView()
//        setupImageView()
    }
    
    func setupTableView() -> Void {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
    }
  
    func setupUI() -> Void {
        temperView.layer.borderColor = UIColor.orange.cgColor
        temperView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        temperView.backgroundColor = UIColor.red
        temperView.layer.shadowColor = UIColor.purple.cgColor
        temperView.layer.shadowRadius = 7
        view.addSubview(temperView)
    }
    
    func setupImageView() -> Void {
        imageView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 300, width: UIScreen.main.bounds.width, height: 300)
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        view.addSubview(imageView)
  
        setupRotationAnimation()
    }
    
    func setupRotationAnimation() -> Void {
        rotationAni.fromValue = NSNumber(value: 0)
        rotationAni.toValue = NSNumber(value: M_PI * 2)
        rotationAni.repeatCount = MAXFLOAT
        rotationAni.duration = 20.0
        imageView.layer.add(rotationAni, forKey: "rotation")
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titlesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        cell?.textLabel?.text = "当前是=======\(self.titlesArr[indexPath.row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.present(LoginViewController(), animated: true, completion: nil)
        }else if indexPath.row == 1{
            self.present(LoadingIndicatorViewController(), animated: true, completion: nil)
        }else if indexPath.row == 2{
            self.present(LaunchScreenViewController(), animated: true, completion: nil)
        }else if indexPath.row == 3{
            self.present(LoginTextFieldAnimationViewController(), animated: true, completion: nil)
        }else if indexPath.row == 4{
            self.present(ShoppingViewController(), animated: true, completion: nil)
        }else if indexPath.row == 5{
            self.present(SignViewController(), animated: true, completion:nil)
        }else if indexPath.row == 6{
            self.present(NavigationWavaViewController(), animated: true, completion: nil)
        }else if indexPath.row == 7{
            self.present(CountingViewController(), animated: true, completion: nil)
        }else if indexPath.row == 8{
            self.present(ApplauseViewController(), animated: true, completion: nil)
        }else if indexPath.row == 9{
            self.present(GestureUnlockViewController(), animated: true, completion: nil)
        }else if indexPath.row == 10{
            self.present(CircleSpreadViewController(), animated: true, completion: nil)
        }else if indexPath.row == 11{
            self.present(PopPresentViewControoler(), animated: true, completion: nil)
        }else if indexPath.row == 12{
            self.present(StudyOnLineViewController(), animated: true, completion: nil)
        }else if indexPath.row == 13{
            self.present(PieChatViewController(), animated: true, completion: nil)
        }else if indexPath.row == 14{
            let nav = UINavigationController(rootViewController: NavigationWavaViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 15{
            self.present(InteractionViewControoler(), animated: true, completion: nil)
        }else if indexPath.row == 16{
            self.present(EmitterViewController(), animated: true, completion: nil)
        }else if indexPath.row == 17{
            self.present(UCHeaderPullAnimationViewController(), animated: true, completion: nil)
        }else if indexPath.row == 18{
            self.present(CountingViewController(), animated: true, completion: nil)
        }else if indexPath.row == 19{
            let nav = UINavigationController(rootViewController: HighManagerMoneyViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 20{
            let nav = UINavigationController(rootViewController: TableViewTapAnimationController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 21{
            self.present(DragerViewController(), animated: true, completion: nil)
        }else if indexPath.row == 22{
            let nav = UINavigationController(rootViewController: ChannelViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 23{
            let nav = UINavigationController(rootViewController: NavWaveViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 24{
            self.present(MenuHomeViewController(), animated: true, completion: nil)
        }else if indexPath.row == 25{
            let nav = UINavigationController(rootViewController: MaskTestViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 26{
            let nav = UINavigationController(rootViewController: ScaleLabelViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 27{
            let nav = UINavigationController(rootViewController: NavgationImgScaleViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 28{
            let nav = UINavigationController(rootViewController: HeaderViewTapAnimationViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 29{
            let nav = UINavigationController(rootViewController: ShinningViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 30{
            let nav = UINavigationController(rootViewController: TapCellAnimationViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 31{
            let nav = UINavigationController(rootViewController: SearchBarViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 32{
            let nav = UINavigationController(rootViewController: YHAlertViewController())
            self.present(nav, animated: true, completion: nil)
        }else if indexPath.row == 33{
            let nav = UINavigationController(rootViewController: BasicLoadingAnimationViewController())
            self.present(nav, animated: true, completion: nil)
        }
    }
}

extension ViewController:CAAnimationDelegate{
    //MARK:动画组
    func groupAnimation() -> Void {
        let positionAni = CABasicAnimation(keyPath: "position")
        positionAni.toValue = NSValue(cgPoint: self.view.center)
        
        let opacityAni = CABasicAnimation(keyPath: "opacity")
        opacityAni.toValue = 0.5
        
        let boundsAni = CABasicAnimation(keyPath: "bounds.size")
        boundsAni.toValue = NSValue(cgSize: CGSize(width: 200, height: 200))
        
        let groupAni = CAAnimationGroup()
        groupAni.animations = [positionAni,opacityAni,boundsAni]
        groupAni.duration = 1.0
        groupAni.fillMode = kCAFillModeForwards
        groupAni.isRemovedOnCompletion = false
        groupAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.temperView.layer.add(groupAni, forKey: "group")
    }
    
    //MARK:弹簧动画(IOS9)
    func springAnimation() -> Void {
        
        /*
         CASpringAnimation是iOS9新加入动画类型，是CABasicAnimation的子类，用于实现弹簧动画。
         
         CASpringAnimation的重要属性：
         
         mass：质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大）
         
         stiffness：弹性系数（弹性系数越大，弹簧的运动越快）
         
         damping：阻尼系数（阻尼系数越大，弹簧的停止越快）
         
         initialVelocity：初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）
         
         settlingDuration：结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）
         */
        
        if #available(iOS 9.0, *) {
            let springAni = CASpringAnimation(keyPath: "transform.scale")
            springAni.mass = 10
            springAni.stiffness = 5000
            springAni.damping = 100
            springAni.autoreverses = false
            springAni.initialVelocity = 5
            springAni.duration = springAni.settlingDuration
            springAni.toValue = NSNumber(value: 1.5)
            springAni.isRemovedOnCompletion = true
            springAni.fillMode = kCAFillModeForwards
            springAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            self.temperView.layer.add(springAni, forKey: "springAnimation")
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK:转场动画
    func transitonAnimation() -> Void {
        /*
         type：过渡动画的类型
         
         type的enum值如下：
         kCATransitionFade 渐变
         kCATransitionMoveIn 覆盖
         kCATransitionPush 推出
         kCATransitionReveal 揭开
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
        transitionAni.type = kCATransitionPush
        transitionAni.subtype = kCATransitionFromTop
        transitionAni.duration = 1.5
        self.temperView.backgroundColor = UIColor.orange
        self.temperView.layer.add(transitionAni, forKey: "transition")
    }
    
    //MARK:关键帧动画
    func valueKeyframeAnimation() -> Void {
        self.temperView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        let keyframeAni = CAKeyframeAnimation(keyPath: "position")
        keyframeAni.duration = 3.0
        keyframeAni.isRemovedOnCompletion = true
        keyframeAni.fillMode = kCAFillModeForwards
        let value1 = NSValue(cgPoint: CGPoint(x: 100, y: 100))
        let value2 = NSValue(cgPoint: CGPoint(x: 200, y: 100))
        let value3 = NSValue(cgPoint: CGPoint(x: 200, y: 200))
        let value4 = NSValue(cgPoint: CGPoint(x: 100, y: 200))
        keyframeAni.values = [value1,value2,value3,value4]
        self.temperView.layer.add(keyframeAni, forKey: "keyframe")
    }
    
    //MARK:borderAnimation
    func borderAnimation() -> Void {
        borderAni.toValue = NSNumber(value: 8)
        borderAni.delegate = self
        borderAni.autoreverses = false
        borderAni.isRemovedOnCompletion = true
        borderAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        borderAni.duration = 2
        self.temperView.layer.add(borderAni, forKey: "border")
    }
    
    //MARK:圆角
    func cornerAnimation() -> Void {
        cornerAni.toValue = NSNumber(value: 8)
        cornerAni.delegate = self
        cornerAni.autoreverses = false
        cornerAni.isRemovedOnCompletion = true
        cornerAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        cornerAni.duration = 2
        self.temperView.layer.add(cornerAni, forKey: "corner")
    }
    
    //MARK:透明度
    func opacityAnimation() -> Void {
        opacityAni.toValue = NSNumber(value: 0.5)
        opacityAni.delegate = self
        opacityAni.autoreverses = false
        opacityAni.isRemovedOnCompletion = true
        opacityAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        opacityAni.fillMode = kCAFillModeForwards
        opacityAni.duration = 2
        self.temperView.layer.add(opacityAni, forKey: "opacity")
    }
    
    //MARK:改变bounds
    func boundsAnimation() -> Void {
        
        boundsAni.toValue = NSNumber(value: 300)
        boundsAni.delegate = self
        boundsAni.repeatCount = 2
        boundsAni.isRemovedOnCompletion = false
        boundsAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        boundsAni.fillMode = kCAFillModeForwards
        boundsAni.duration = 2
        self.temperView.layer.add(boundsAni, forKey: "bounds")
    }
    
    //MARK:旋转动画
    func rotationAnimation() -> Void {
        roataionAni.fromValue = NSNumber(value: -M_PI_2)
        roataionAni.toValue = NSNumber(value: M_PI)
        roataionAni.delegate = self
        roataionAni.repeatCount = 2
        roataionAni.isRemovedOnCompletion = false
        roataionAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        roataionAni.fillMode = kCAFillModeForwards
        roataionAni.duration = 2
        self.temperView.layer.add(roataionAni, forKey: "rotation")
    }
    
    //MARK:缩放动画
    func scaleAnimation() -> Void {
        
        scaleAni.toValue = NSNumber(value: 1.5)
        scaleAni.delegate = self
        scaleAni.repeatCount = 1
        scaleAni.autoreverses = true
        scaleAni.isRemovedOnCompletion = true
        scaleAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        scaleAni.fillMode = kCAFillModeForwards
        scaleAni.duration = 1
        self.temperView.layer.add(scaleAni, forKey: "scale")
    }
    
    //MARK:移动动画
    func translationAnimation() -> Void {
        translationAni.toValue = NSNumber(value: 200)
        translationAni.delegate = self
        translationAni.repeatCount = 1
        translationAni.autoreverses = true
        translationAni.isRemovedOnCompletion = true
        translationAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        translationAni.fillMode = kCAFillModeForwards
        translationAni.duration = 1
        self.temperView.layer.add(translationAni, forKey: "translation")
    }
    
    //MARK:位置动画
    func positionAnimation() -> Void{
        positionAni.toValue = CGPoint(x: 200, y: 200)
        positionAni.delegate = self
        positionAni.repeatCount = 1
        positionAni.autoreverses = true
        positionAni.isRemovedOnCompletion = true
        positionAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        positionAni.fillMode = kCAFillModeForwards
        positionAni.duration = 1
        self.temperView.layer.add(positionAni, forKey: "position")
    }

}

