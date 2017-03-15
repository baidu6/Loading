//
//  GestureUnlockViewController.swift
//  Loading
//
//  Created by mac on 2017/2/15.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class GestureUnlockViewController:UIViewController{
    fileprivate lazy var lockV:LockView = LockView(frame: CGRect(x: 0, y: 150, width: KWidth, height: 300))
    
    fileprivate lazy var titleLabel:UILabel = UILabel()
    
    fileprivate lazy var shapeLayer:CAShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //手势解锁
        view.addSubview(lockV)
        view.backgroundColor = UIColor.darkGray
        
        //添加斜角的label
        setupLabel()
    }
    
    
    func setupLabel() -> Void {
        let title = "Love"
        titleLabel.frame = CGRect(x: (KWidth - 100) * 0.5, y: 50, width: title.labelWidth(fontSize: 15, height: 20), height: 20)
        titleLabel.text = title
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = UIColor.orange
        view.addSubview(titleLabel)
        
        let leftMargin:CGFloat = 5
        let path = UIBezierPath()
        path.move(to: CGPoint(x: leftMargin, y: 0))
        path.addLine(to: CGPoint(x: self.titleLabel.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.titleLabel.frame.width - leftMargin, y: self.titleLabel.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.titleLabel.frame.height))
        path.lineJoinStyle = CGLineJoin.round
        path.lineCapStyle = CGLineCap.round
        path.close()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 4
        shapeLayer.lineJoin = kCALineCapRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.fillColor = UIColor.orange.cgColor
        titleLabel.layer.addSublayer(shapeLayer)
    }
}

extension String{
    //根据高度计算宽度
    func labelWidth(fontSize:CGFloat,height:CGFloat) -> CGFloat {
        return labelWidth(font: UIFont.systemFont(ofSize: fontSize), height: height)
    }
    func labelWidth(font:UIFont,height:CGFloat) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude,height: height)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.width
    }
}

class LockView: UIView {
    
    //保存所有的按钮
    fileprivate var buttons:[UIButton] = [UIButton]()
    //保存所有选中的按钮
    fileprivate var selectedButtons:[UIButton] = [UIButton]()
    //线的颜色
    var lineColor:UIColor = UIColor.white
    //记录用户最后触摸的点
    var currentPoint:CGPoint = CGPoint.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        setupButtons()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:创建9个按钮
    func setupButtons() -> Void {
        let btnW:CGFloat = 74
        let btnH:CGFloat = 74
        let columns:CGFloat = 3
        let marginX:CGFloat = (self.frame.width - btnW * columns) / (columns + 1)
        let marginY:CGFloat = (self.frame.height - btnH * columns) / (columns + 1)
        
        for i in 0..<9{
            let btn = UIButton()
            let col:CGFloat = CGFloat(i % Int(columns))
            let row:CGFloat = CGFloat(i / Int(columns))
            btn.frame = CGRect(x: marginX + col * (marginX + btnW), y:row * (marginY + btnH), width: btnW, height: btnH)
           
            //利用button的tag值，用于验证输入的密码是否正确
            btn.tag = i + 1
            btn.isUserInteractionEnabled = false
            //按钮的背景颜色
            btn.setBackgroundImage(UIImage(named:"gesture_node_normal"), for: UIControlState.normal)
            btn.setBackgroundImage(UIImage(named:"gesture_node_highlighted"), for: UIControlState.selected)
            btn.setBackgroundImage(UIImage(named:"gesture_node_error"), for: UIControlState.disabled)
            
            self.addSubview(btn)
            self.buttons.append(btn)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            let point = touch.location(in: self)
            for button in self.buttons{
                if button.frame.contains(point){
                    if button.isSelected == false{
                        button.isSelected = true
                        self.selectedButtons.append(button)
                    }
                    else{
                        self.currentPoint = point
                    }
                }
            }
        }
        setNeedsDisplay()
    }
    
    //MARK:touchesMoved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取当前触摸的点
        if let touch = touches.first{
            let point = touch.location(in: self)
            for button in self.buttons{
                if button.frame.contains(point){
                    if button.isSelected == false{
                        button.isSelected = true
                        self.selectedButtons.append(button)
                    }else{
                        print("这究竟是什么鬼---why")
                        self.currentPoint = point
                    }
                  }
                }
            }
        
        //这是重新绘制图形
        setNeedsDisplay()
    }
    
    //MARK:touchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取用户绘制的密码
        var str:String = ""
        for button in self.selectedButtons{
            str += "\(button.tag)"
        }
        print(str)
    }
    
    //MARK:重新绘制
    override func draw(_ rect: CGRect) {
        //当没有选中的button的时候，直接返回
        if self.selectedButtons.count == 0{
            return
        }
        
        //获取每个按钮的中心点，然后连线
        let path = UIBezierPath()
        path.lineWidth = 8
        path.lineJoinStyle = CGLineJoin.round
        //设置线条颜色
        self.lineColor.set()
        
        for index in 0..<self.selectedButtons.count{
            
            let button = self.selectedButtons[index]
            //说明是第一个按钮，那么把这个按钮中心当做是初始点
            if index == 0{
                path.move(to:button.center)
            }else{
                path.addLine(to: button.center)
            }
        }
        path.addLine(to: self.currentPoint)
        //渲染
        path.stroke()
    }
   
}
