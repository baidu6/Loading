//
//  MenuMainViewController.swift
//  Loading
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class MenuMainViewController: UIViewController {
    var images:[String] = ["egg","chicken","coffee","fish"]
    var selectedView:UIView?
    let transtionAnimation = MenuDetailTranstionAnimation()
    
    @IBOutlet weak var firstView: UIButton!
    @IBOutlet weak var secondView: UIButton!
    @IBOutlet weak var thirdView: UIButton!
    @IBOutlet weak var fourView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        //设置代理
        navigationController?.delegate = self
    }
    
    @IBAction func mainBtnClick(_ btn: UIButton) {
        
        switch btn.tag {
        case 100:
            selectedView = firstView
        case 101:
            selectedView = secondView
        case 102:
            selectedView = thirdView
        case 103:
            selectedView = fourView
        default:
            break
        }
        
        
        //push vc
        let detailVC = MenuDetailViewController(nibName: "MenuDetailViewController", bundle: nil)
        detailVC.imageName = images[btn.tag - 100]
        detailVC.modalPresentationStyle = .custom
        detailVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension MenuMainViewController:UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if self.selectedView != nil{
            transtionAnimation.selectedView = self.selectedView!
        }
        
        if fromVC is MenuMainViewController{
            transtionAnimation.isPush = true
        }else{
            transtionAnimation.isPush = false
        }
        
        return transtionAnimation
    }
}

class MenuDetailTranstionAnimation: NSObject, UIViewControllerAnimatedTransitioning{
    
    var isPush:Bool = true
    var selectedView:UIView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //from
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let fromView = fromVC?.view
        
        //to
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let toView = toVC?.view
        
        //containerView
        let containerView = transitionContext.containerView
        
        //默认是push状态
        if isPush == true{
            
            //add fromVC
            containerView.addSubview(fromView!)
            
            //set toView
            toView?.frame = selectedView.frame
            
            toView?.clipsToBounds = true
            
            //add toVC
            containerView.addSubview(toView!)
            
            //animation
            UIView.animate(withDuration: 0.25, animations: {
                toView?.frame = UIScreen.main.bounds
            }, completion: { (_) in
                fromView?.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }else{
            
            let maskView = UIView(frame: (fromView?.frame)!)
            maskView.backgroundColor = UIColor.black
            maskView.clipsToBounds = true
            
            containerView.addSubview(toView!)
            containerView.addSubview(maskView)
            containerView.addSubview(fromView!)
            
            fromView?.mask = maskView
            
            print(self.selectedView.frame)
            
            UIView.animate(withDuration: 0.2, animations: {
                maskView.frame = CGRect(x: KWidth * 0.5 - 56, y: KHeight * 0.5 - 56, width: 112, height: 112)
            }, completion: { finished in
                fromView?.removeFromSuperview()
                transitionContext.completeTransition(true)
//                maskView.removeFromSuperview()
            })
        }
    }
    
}
