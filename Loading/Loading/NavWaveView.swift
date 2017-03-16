//
//  NavWaveView.swift
//  Loading
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class NavWaveView: UIView {
    
    
    var RealFillColor = UIColor.orange.withAlphaComponent(0.8).cgColor
    var RealStrokeColor = UIColor.clear.cgColor
    
    var MaskFillColor = UIColor.white.cgColor
    var MaskStrokeColor = UIColor.clear.cgColor
    
    fileprivate lazy var displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(waveAnimation))
    
    //真实的浪
    fileprivate lazy var realWaveLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    //遮罩浪
    fileprivate lazy var maskWaveLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    //波浪速度
    var waveSpeed:Double = 1.5
    
    var offset:Double = 0
    
    //波浪高度
    var waveHeight:Double = 6
    
    //波浪弯曲度
    var waveCurvature:Double = 1.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor.orange.withAlphaComponent(0.6)
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    //MARK:setupUI
    func setupUI() -> Void {
        
        //添加layer
        realWaveLayer.fillColor = RealFillColor
        realWaveLayer.strokeColor = RealStrokeColor
        realWaveLayer.frame = CGRect(x: 0, y: self.frame.size.height - CGFloat(waveHeight), width: self.frame.size.width, height: CGFloat(waveHeight))
        self.layer.addSublayer(realWaveLayer)
        
        
        maskWaveLayer.fillColor = MaskFillColor
        maskWaveLayer.strokeColor = MaskStrokeColor
        maskWaveLayer.frame = CGRect(x: 0, y: self.frame.size.height - CGFloat(waveHeight), width: self.frame.size.width, height: CGFloat(waveHeight))
        self.layer.addSublayer(maskWaveLayer)
        
    }
    
    //MARK:波浪动画
    func waveAnimation() -> Void {
        
        offset += waveSpeed
        
        let height:Double = waveHeight
        let width:Int = Int(self.frame.size.width)
        
        let path = CGMutablePath()
        let maskPath = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height))
        maskPath.move(to: CGPoint(x: 0, y: height))

        var y:Double = 0.0
        
        for x in 0..<width{
            y = height * (Double(sinf(Float(Double(0.01 * waveCurvature * Double(x) + 0.045 * offset)))))
            path.addLine(to: CGPoint(x: Double(x), y: y))
            maskPath.addLine(to: CGPoint(x: Double(x), y: -y))
        }
        
        path.addLine(to: CGPoint(x: Double(width), y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        realWaveLayer.path = path
        realWaveLayer.fillColor = RealFillColor
        
        
        maskPath.addLine(to: CGPoint(x: Double(width), y: height))
        maskPath.addLine(to: CGPoint(x: 0, y: height))
        maskPath.closeSubpath()
        maskWaveLayer.path = maskPath
        maskWaveLayer.fillColor = MaskFillColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
