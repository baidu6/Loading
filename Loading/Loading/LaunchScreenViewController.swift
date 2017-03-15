//
//  LaunchScreenViewController.swift
//  Loading
//
//  Created by mac on 2017/2/7.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class LaunchScreenViewController: UIViewController {
    fileprivate var labels:[UILabel] = [UILabel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupLabels()
    }
    
    func setupLabels() -> Void {
        labels = generateLabels(text: "Loading...")
        layoutLabels(labels: labels)
    }
  
    //MAKR:根据文字多少创建label
    func generateLabels(text:String) -> [UILabel] {
        var labels:[UILabel] = [UILabel]()
        for c in text.characters{
            let label = creatLabel(text: String(c))
            labels.append(label)
        }
        return labels
    }
    
    //MARK:创建label
    func creatLabel(text:String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.bounds.size = CGSize(width: 25, height: 40)
        label.center.x = view.center.x
        label.center.y = view.center.y - 20
        label.text = text
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.alpha = 0
        view.addSubview(label)
        return label
    }
    
    //MARK:给label布局
    func layoutLabels(labels:[UILabel]) -> Void {
        let count:CGFloat = CGFloat(labels.count)
        let labelW:CGFloat = 25
        let spacing:CGFloat = 2
        let totalW:CGFloat = labelW * count + (count - 1) * spacing
        let originX:CGFloat = UIScreen.main.bounds.width * 0.5 - totalW * 0.5
        for (i,label) in labels.enumerated(){
            print(labels.enumerated())
            label.frame.origin.x = originX + (labelW + spacing) * CGFloat(i)
        }
        animateLabels(labels: labels)
    }
    
    //MARK:给label添加动画
    func animateLabels(labels:[UILabel]) -> Void {
        var delay:TimeInterval = 0
        
        for (i ,label) in labels.enumerated(){
            var offsetX:CGFloat = 50
            if i > labels.count / 2{
                offsetX = offsetX * -1
            }
            label.transform = CGAffineTransform(scaleX: 0.5, y: 0.5).translatedBy(x: offsetX, y: 50)
            let duration:TimeInterval = 1.0 + TimeInterval(labels.count - 1) * 0.04
            delay = delay + duration * 0.1
            
            //usingSpringWithDamping，范围是0-1，数值越小弹簧震动效果越明显
            //initialSpringVelocity,初始的速度，数值越大一开始移动越快
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
                label.transform = CGAffineTransform.identity
                label.alpha = 1
            }) { (_) in
                if i == labels.count - 1{
                   UIView.animate(withDuration: 0.5, delay: 0.7, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.view.alpha = 0
                   }, completion: { (_) in
                    self.view.removeFromSuperview()
                    self.removeFromParentViewController()
                   })
                }
            }
        }
    }
}
