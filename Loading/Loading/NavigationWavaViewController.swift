//
//  NavigationWavaViewController.swift
//  Loading
//
//  Created by mac on 2017/2/10.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class NavigationWavaViewController: UIViewController{
    fileprivate lazy var topView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 64, width: KWidth, height: 200))
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "我的世界"
        view.addSubview(topView)
        topView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
   
        let layer = creatLayer(offset: KWidth * 0.13,fillColor: UIColor.orange,stokeColor:UIColor.clear)
        topView.layer.insertSublayer(layer, at: 0)
        
        let layer2 = creatLayer(offset: KWidth * 0.1,fillColor: UIColor.red,stokeColor: UIColor.clear)
        topView.layer.insertSublayer(layer2, at: 0)
        
        let layer3 = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 300))
        path.addQuadCurve(to: CGPoint(x: 300, y: 400), controlPoint: CGPoint(x: 200, y: 200))
        layer3.path = path.cgPath
        layer3.fillColor = UIColor.red.cgColor
        layer3.strokeColor = UIColor.purple.cgColor
        self.view.layer.addSublayer(layer3)
    }
    
    func creatLayer(offset:CGFloat,fillColor:UIColor,stokeColor:UIColor) -> CAShapeLayer {
        let delta:CGFloat = 6
        let rect = topView.bounds
        let layer:CAShapeLayer = CAShapeLayer()
        layer.strokeColor = stokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        let path = UIBezierPath()
        layer.frame = rect
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - offset))
        path.addQuadCurve(to:  CGPoint(x: rect.midX, y: rect.maxY), controlPoint: CGPoint(x: rect.width * 0.25, y: rect.maxY - delta))
        path.addQuadCurve(to:  CGPoint(x: rect.maxX, y: rect.maxY - offset), controlPoint:  CGPoint(x: rect.width * 0.75, y: rect.maxY - delta))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.close()
        layer.path = path.cgPath
        return layer
    }
}
