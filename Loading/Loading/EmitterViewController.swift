//
//  EmitterViewController.swift
//  Loading
//
//  Created by mac on 2017/3/1.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class EmitterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray
        
    }
}

class FireworkView: UIView {
    fileprivate lazy var explosionLayer = CAEmitterLayer()
    fileprivate lazy var chargeLayer = CAEmitterLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:setupUI
    func setupUI() -> Void {
        self.clipsToBounds = false
        self.isUserInteractionEnabled = false
        
        let explosionCell = CAEmitterCell()
        //粒子的名字
        explosionCell.name = "explosion"
        //一个粒子颜色alpha能改变的范围
        explosionCell.alphaRange = 0.2
        //粒子透明度在生命周期内的改变速度
        explosionCell.alphaSpeed = -1.0
        //生命周期
        explosionCell.lifetime = 0.7
        //生命周期范围
        explosionCell.lifetimeRange = 0.3
        //粒子产生系数
        explosionCell.birthRate = 0
        //速度
        explosionCell.velocity = 40.0
        //速度范围
        explosionCell.velocityRange = 10.0
        
        explosionLayer.name = "emitterLayer"
        //发射源形状
        explosionLayer.emitterShape = kCAEmitterLayerCircle
        //发射模式
        explosionLayer.emitterMode = kCAEmitterLayerOutline
        //发射源的尺寸大小
        explosionLayer.emitterSize = CGSize(width: 25, height: 0)
        //渲染模式
        explosionLayer.renderMode = kCAEmitterLayerOldestFirst
        explosionLayer.masksToBounds = false
        //用于初始化随机数产生的种子
        explosionLayer.seed = 1366128504
        //装着CAEmitterCell对象的数组，被用于把粒子投放到layer上
        explosionLayer.emitterCells = [explosionCell]
        self.layer.addSublayer(explosionLayer)
        
        let chargeCell = CAEmitterCell()
        chargeCell.name = "charge"
        chargeCell.alphaRange = 0.2
        chargeCell.alphaSpeed = -1.0
        chargeCell.lifetime = 0.3
        chargeCell.lifetimeRange = 0.1
        chargeCell.birthRate = 0
        chargeCell.velocity = -40
        chargeCell.velocityRange = 0.0
        
        chargeLayer.name = "emitterLayer"
        //发射源形状
        chargeLayer.emitterShape = kCAEmitterLayerCircle
        //发射模式
        chargeLayer.emitterMode = kCAEmitterLayerOutline
        //发射源的尺寸大小
        chargeLayer.emitterSize = CGSize(width: 25, height: 0)
        //渲染模式
        chargeLayer.renderMode = kCAEmitterLayerOldestFirst
        chargeLayer.masksToBounds = false
        //用于初始化随机数产生的种子
        chargeLayer.seed = 1366128504
        //装着CAEmitterCell对象的数组，被用于把粒子投放到layer上
        explosionLayer.emitterCells = [chargeCell]
        self.layer.addSublayer(chargeLayer)
    }
}
