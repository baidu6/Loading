//
//  PieChatViewController.swift
//  Loading
//
//  Created by mac on 2017/2/24.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class PieChatViewController: UIViewController {
    let pieV:MyPieView = MyPieView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(pieV)
        pieV.displayDatas(percentArray: [0.1,0.3,0.1,0.1,0.4], colorsArray: [UIColor.red.withAlphaComponent(0.1),UIColor.red.withAlphaComponent(0.3),UIColor.red.withAlphaComponent(0.1),UIColor.red.withAlphaComponent(0.3),UIColor.red.withAlphaComponent(0.2)])
    }
}

class MyPieView: UIView {
//    var percentArray:[CGFloat]!
    var layersArray:[MyShapeLayer] = [MyShapeLayer]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        
//        temperLayer = MyShapeLayer(centerPoint: CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5), radius: self.frame.width * 0.5 - 20, startAngle: 0, endAngle: CGFloat(M_PI * 0.5),filledColor:UIColor.red)
//        self.layer.addSublayer(temperLayer)
    }
    
    //MARK:显示那些个扇形
    func displayDatas(percentArray:[CGFloat],colorsArray:[UIColor]) -> Void {
        var startAngle:CGFloat = 0
        var endAngle:CGFloat = 0
        for i in 0..<percentArray.count{
            let percent = percentArray[i]
            let angle = percent * CGFloat(M_PI * 2)
            endAngle = startAngle + angle
            let layer = MyShapeLayer(centerPoint: CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5), radius: self.frame.width * 0.5 - 20, startAngle: startAngle, endAngle: endAngle, filledColor: colorsArray[i])
            self.layer.addSublayer(layer)
            layersArray.append(layer)
            startAngle = endAngle
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for layer in self.layersArray{
            if let touch = touches.first{
                let point = touch.location(in: self)
                if layer.path?.contains(point) == true{
                    layer.selectedAnimation()
                }else{
                    layer.backAnimation()
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyShapeLayer: CAShapeLayer {
    //开始的角度
   fileprivate var startAngle:CGFloat!
    //结束的角度
   fileprivate var endAngle:CGFloat!
    //半径
   fileprivate var radius:CGFloat!
    //原点
   fileprivate var centerPoint:CGPoint!
    //是否被选中
   fileprivate var isSelected:Bool = false
    //填充的颜色
   fileprivate var filledColor:UIColor!
    //tag值，为了点击事件考虑
   fileprivate var tag:NSInteger!
    
    init(centerPoint:CGPoint,radius:CGFloat,startAngle:CGFloat,endAngle:CGFloat,filledColor:UIColor){
        super.init()
        self.centerPoint = centerPoint
        self.radius = radius
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.filledColor = filledColor
        creatLayer()
    }
    
    //MARK:创建layer画出扇形
    func creatLayer() -> Void{
        let path = UIBezierPath()
        path.move(to: self.centerPoint)
        path.addArc(withCenter: self.centerPoint, radius: self.radius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)
        //画完了，记得关闭
        path.close()
        self.path = path.cgPath
        self.fillColor = filledColor.cgColor
        self.strokeColor = UIColor.white.cgColor
        
    }
    
    //MARK:当前layer选中状态时候的动画效果
    func selectedAnimation() -> Void {
        if self.isSelected == true{
            backAnimation()
            return
        }
        moveAnimation()
    }
    
    //MARK:点击移动动画
    func moveAnimation() -> Void {
        self.isSelected = true
        let path = UIBezierPath()
        //定义一个移动的距离
        let length:CGFloat = 20
        let newCenterPoint:CGPoint = CGPoint(x: self.centerPoint.x + cos((self.startAngle + self.endAngle) * 0.5) * length, y: self.centerPoint.y + sin((self.startAngle + self.endAngle) * 0.5) * length)
        path.move(to:newCenterPoint)
        path.addArc(withCenter: newCenterPoint, radius: self.radius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)
        path.close()
        self.path = path.cgPath
        
        //添加动画
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.toValue = path
        basicAnimation.duration = 0.5
        self.add(basicAnimation, forKey: "animation")
    }
    
    //MARK:返回动画
    func backAnimation() -> Void {
        self.isSelected = false
        let path = UIBezierPath()
        path.move(to: self.centerPoint)
        path.addArc(withCenter: self.centerPoint, radius: self.radius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)
        //画完了，记得关闭
        path.close()
        self.path = path.cgPath
        
        //添加动画
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.toValue = path
        basicAnimation.duration = 0.5
        self.add(basicAnimation, forKey: "animation")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
