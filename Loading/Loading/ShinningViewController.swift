//
//  ShinningViewController.swift
//  Loading
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit

class ShinningViewController: UIViewController {
    
    
    fileprivate lazy var shiningView:ShiningLabelView = ShiningLabelView(frame: CGRect(x: (KWidth - 200) * 0.5, y: 150, width: 100, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        setupUI()
    }
    
    //MARK:setupUI
    func setupUI() -> Void {
        view.addSubview(shiningView)
    }
}

class ShiningLabelView: UIView {
    
    var percent:CGFloat = 0.0
    //闪烁宽度，默认是20
    var shimmerWidth:CGFloat = 20
    //闪烁半径，默认20
    var shimmerRadius:CGFloat = 20
    //文字多少大小
    var charSize:CGSize = CGSize.zero
    
    lazy var contentLabel:UILabel = {
         let contentL = UILabel(frame: self.bounds)
        contentL.text = "Hello World!"
        contentL.textColor = UIColor.darkGray
        contentL.font = UIFont.systemFont(ofSize: 17)
        contentL.textAlignment = NSTextAlignment.left
        return contentL
    }()
    
    lazy var maskLabel:UILabel = {
        let maskL = UILabel(frame: self.bounds)
        maskL.text = "Hello World!"
        maskL.textColor = UIColor.orange
        maskL.textAlignment = NSTextAlignment.left
        maskL.font = UIFont.systemFont(ofSize: 17)
        return maskL
    }()
    
    lazy var maskLayer:CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.backgroundColor = UIColor.white.cgColor
        self.maskLabel.layer.addSublayer(layer)
        return layer
    }()
    
    //MARK:开始动画
    func startAnimation() -> Void {
        
        if self.percent >= 1.0{
            self.percent = 0.0
        }
        
        maskLayer.frame = CGRect(x: self.frame.width * percent - 30, y: (self.frame.height - 20) * 0.5, width: 20, height: 20)
        self.maskLabel.layer.mask = maskLayer
        self.percent += 0.02
    }
    
    //MARK:刷新maskLayer的属性值
    func refreshMaskLayer() -> Void {
        self.maskLayer.startPoint = CGPoint(x: 0, y: 0.5)
        self.maskLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.maskLayer.colors = [UIColor.clear.cgColor,UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor,UIColor.clear.cgColor]
        
        var w:CGFloat = 1.0
        var sw:CGFloat = 1.0
        if self.charSize.width >= 1{
            w = self.shimmerWidth / self.charSize.width * CGFloat(0.5)
            sw = self.shimmerRadius / self.charSize.width
        }
        let a:CGFloat = 0.5 - w - sw
        
//        self.maskLayer.locations = [0.0, (0.5 - w - sw), (0.5 - w),(0.5 + w), (0.5 + w + sw), 1]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(contentLabel)
        self.addSubview(maskLabel)
        
        let timer = CADisplayLink(target: self, selector: #selector(startAnimation))
        timer.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
