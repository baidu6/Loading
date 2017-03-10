//
//  SignViewController.swift
//  Loading
//
//  Created by mac on 2017/2/10.
//  Copyright © 2017年 czj. All rights reserved.
//

/*
 //发射源状态
 public let kCAEmitterLayerPoint: String        点
 
 public let kCAEmitterLayerLine: String     直线
 
 public let kCAEmitterLayerRectangle: String        矩形
 
 public let kCAEmitterLayerCuboid: String       3D立方形
 
 public let kCAEmitterLayerCircle: String       圆形
 
 public let kCAEmitterLayerSphere: String       3D球
 */


/*
 //发射模式
 public let kCAEmitterLayerPoints: String       顶点
 
 public let kCAEmitterLayerOutline: String      轮廓，即边上
 
 public let kCAEmitterLayerSurface: String      表面，即圆形的面积内
 
 public let kCAEmitterLayerVolume: String       容积，即3D图形的体积内
 */


import UIKit
class  SignViewController:UIViewController{
    fileprivate lazy var signV:SignInView = SignInView(frame:CGRect(x: 30, y: 150, width: UIScreen.main.bounds.width - 60, height: 300))
    fileprivate lazy var clickBtn:UIButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 0.5 - 20 * 0.5, y: 500, width: 20, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }
    func setupUI() -> Void {
        signV.backgroundColor = UIColor.white
        view.addSubview(signV)
        
        clickBtn.backgroundColor = UIColor.black
        clickBtn.layer.cornerRadius = 10
//        clickBtn.layer.masksToBounds = true
        clickBtn.addTarget(self, action: #selector(boomAnimation), for: UIControlEvents.touchUpInside)
        view.addSubview(clickBtn)
    }
    
    //MARK:点击button有爆炸效果
    func boomAnimation() -> Void {
        let emitter = CAEmitterLayer()
        let btnW:CGFloat = 20
        emitter.emitterSize = CGSize(width: btnW, height: btnW)
        emitter.emitterPosition = CGPoint(x: btnW * 0.5, y: btnW * 0.5)
        emitter.emitterShape = kCAEmitterLayerCircle
        emitter.emitterMode = kCAEmitterLayerOutline;
        clickBtn.layer.addSublayer(emitter)
        
        let cell = CAEmitterCell()
        cell.name = "zanShape"
        cell.contents = self.creatImageWithColor(color: UIColor.black)?.cgImage
//        cell.contents = UIImage(named: "coin")
        cell.birthRate = 0
        cell.lifetime = 0.4
        cell.alphaSpeed = -2
        cell.velocity = 20
        cell.velocityRange = 20
        cell.emitterCells = [cell]
        
        let ffectLayerAnimation = CABasicAnimation(keyPath: "emitterCells.zanShape.birthRate")
        ffectLayerAnimation.fromValue = NSNumber(value: 1500)
        ffectLayerAnimation.toValue = NSNumber(value: 0)
        ffectLayerAnimation.duration = 2.0
        ffectLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        emitter.add(ffectLayerAnimation, forKey: "ZanCount")
    }
    
    //MARK:根据颜色生成一张图片UIImage
    func creatImageWithColor(color:UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return self.circleImage(image: newImage)
    }
    
    func circleImage(image:UIImage?) -> UIImage? {
        if let image = image{
            UIGraphicsBeginImageContext(image.size)
            let context = UIGraphicsGetCurrentContext()
            context?.setLineWidth(2)
            context?.setStrokeColor(UIColor.green.cgColor)
            let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            context?.addEllipse(in: rect)
            context?.clip()
            image.draw(in: rect)
            context?.addEllipse(in: rect)
            let circleImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return circleImage
        }
        return nil
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let temperV = UIView(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
//        view.addSubview(temperV)
//        let emitter = CAEmitterLayer()
//        emitter.frame = temperV.bounds
//        emitter.emitterPosition = CGPoint(x: 45, y: 45)
//        emitter.emitterZPosition = 3.0
//        emitter.emitterShape = kCAEmitterLayerCircle
//        emitter.emitterMode = kCAEmitterLayerVolume
//        emitter.preservesDepth = true
//        emitter.emitterDepth = 2.0
//        //粒子的旋转角度
//        emitter.spin = 50
//        view.layer.addSublayer(emitter)
//        emitter.renderMode = kCAEmitterLayerAdditive
//        
//        let cell = CAEmitterCell()
//        cell.contents = UIImage(named: "coin")?.cgImage
//        cell.birthRate = 15.0
//        cell.lifetime = 5.0
//        cell.isEnabled = true//是否打开粒子的渲染效果
//        cell.alphaSpeed = -0.4
//        cell.velocity = 50//粒子速度
//        cell.velocityRange = 70//粒子速度范围
//        cell.emissionRange = CGFloat(M_PI * 2)
//        
//        let cell2 = CAEmitterCell()
//        cell2.contents = UIImage(named: "pass")
//        cell2.birthRate = 15.0;
//        cell2.lifetime = 5.0;
//        cell2.color = UIColor.init(colorLiteralRed: 1, green: 0.5, blue: 0.1, alpha: 1.0).cgColor
//        cell2.alphaSpeed = -0.4
//        cell2.velocity = 50
//        cell2.velocityRange = 50
//        cell2.emissionRange = CGFloat(M_PI * 2.0)
//        emitter.emitterCells = [cell,cell2]
//    }
    
}

class SignInView: UIView {
    
    fileprivate lazy var titleLabel:UILabel = UILabel()
    fileprivate lazy var signDayLabel:UILabel = UILabel()
    fileprivate lazy var signButton:UIButton = UIButton()
    fileprivate lazy var descLabel:UILabel = UILabel()
    let rotationAni = CABasicAnimation(keyPath: "transform.rotation")
    let emitterLayer = CAEmitterLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        initEmitter()
    }
    
    func setupUI() -> Void {
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 50)
        titleLabel.text = "每日签到领金币"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.backgroundColor = UIColor.blue
        titleLabel.textColor = UIColor.white
        self.addSubview(titleLabel)
        
        signDayLabel.frame = CGRect(x: 0, y: self.frame.height - 50, width: self.frame.width, height: 50)
        signDayLabel.backgroundColor = UIColor.red
        signDayLabel.font = UIFont.systemFont(ofSize: 15)
        signDayLabel.textColor = UIColor.white
        signDayLabel.textAlignment = NSTextAlignment.center
        signDayLabel.text = "连续签到0天"
        self.addSubview(signDayLabel)
        
        signButton.frame = CGRect(x: self.frame.width * 0.5 - 80 * 0.5, y: titleLabel.frame.maxY + 20, width: 80, height: 80)
        signButton.setImage(UIImage(named:"signCircle"), for: UIControlState.normal)
        signButton.addTarget(self, action: #selector(sign), for: UIControlEvents.touchUpInside)
        self.addSubview(signButton)
        
        descLabel.frame = CGRect(x: self.frame.width * 0.5 - 100 * 0.5, y: signButton.frame.maxY + 20, width: 100, height: 50)
        descLabel.text = "点击这里签到\n赚取金币"
        descLabel.numberOfLines = 0
        descLabel.textAlignment = NSTextAlignment.center
        descLabel.textColor = UIColor.black
        descLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(descLabel)
    }

    
    
    //MARK:签到
    func sign() -> Void {
        
        //开始旋转
        startRotationAnimation()
    }
    
    //MARK:开始旋转动画
    func startRotationAnimation() -> Void {
        rotationAni.fromValue = NSNumber(value: -M_PI * 0.5)
        rotationAni.toValue = NSNumber(value: M_PI * 1.5)
        rotationAni.duration = 1.0
        rotationAni.repeatCount = 2
        rotationAni.delegate = self
        signButton.layer.add(rotationAni, forKey: "rotationAnim")
    }
    
    //MARK:粒子动画
    func emitterAnimation() -> Void {
        let emitterAni = CABasicAnimation(keyPath: "emitterCells.zanShape.birthRate")
        emitterAni.fromValue = NSNumber(value: 30)
        emitterAni.toValue = NSNumber(value: 0)
        emitterAni.duration = 2.0
        emitterAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        emitterLayer.add(emitterAni, forKey: "zanCount")
    }
    
    //MARK:初始化粒子
    func initEmitter() -> Void {
        emitterLayer.frame = CGRect(x: 0, y: 0, width: signButton.frame.width, height: signButton.frame.height)
        signButton.layer.addSublayer(emitterLayer)
        
        //发射位置
        emitterLayer.emitterPosition = CGPoint(x: self.signButton.frame.width * 0.5, y: self.signButton.frame.height * 0.5)
        
        //发射源尺寸大小
        emitterLayer.emitterSize = CGSize(width: 20, height: 20)
        
     
        //发射源状态
        emitterLayer.emitterShape = kCAEmitterLayerCircle
        
        //发射模式
        emitterLayer.emitterMode = kCAEmitterLayerOutline
        
        //渲染模式
        emitterLayer.renderMode = kCAEmitterLayerAdditive
        
        
        //从发射源发射出的粒子
        let cell = CAEmitterCell()
        cell.name = "zanShape"
        cell.contents = UIImage(named: "coin")?.cgImage
        //粒子透明度在生命周期中的改变
        cell.alphaSpeed = -0.5
        //生命周期
        cell.lifetime = 3.0
        //粒子产生系数（粒子的速度乘以因子，粒子的产生系数乘以产生率 = 每秒粒子的创建个数）
        cell.birthRate = 0
        //粒子速度
        cell.velocity = 400
        //速度范围
        cell.velocityRange = 100
        //周围发射角度
        cell.emissionRange = CGFloat(M_PI * 0.125)
        //发射z轴方向的角度
        cell.emissionLatitude = -(CGFloat)(M_PI)
        //x-y平面的发射方向
        cell.emissionLongitude = CGFloat(-M_PI * 0.5)
        //粒子y方向的加速度分量
        cell.yAcceleration = 250
        
        emitterLayer.emitterCells = [cell]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInView:CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        emitterAnimation()
    }
}
