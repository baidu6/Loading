//
//  LoginViewController.swift
//  Loading
//
//  Created by mac on 2017/2/8.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
fileprivate let KScreenWidth:CGFloat = UIScreen.main.bounds.width
fileprivate let KScreenHeight:CGFloat = UIScreen.main.bounds.height

class LoginViewController: UIViewController {
    
    fileprivate let loginV:LoginView = LoginView(frame: CGRect(x: 0, y: 150, width: KScreenWidth, height: 300))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupLoginView()
    }
    
    //MARK:添加登录的view
    func setupLoginView() -> Void {
        loginV.backgroundColor = UIColor.white
        view.addSubview(loginV)
    }
}

class LoginView: UIView {
    
    enum LoginFieldClickType{
        case usernameF
        case passwordF
        case none
    }
    
    fileprivate lazy var headerImageV:UIImageView = UIImageView(image:UIImage(named: "header"))
    fileprivate lazy var leftHandImageV:UIImageView = UIImageView(image: UIImage(named: "hand"))
    fileprivate lazy var rightHandImageV:UIImageView = UIImageView(image: UIImage(named: "hand"))
    fileprivate lazy var leftArmImageV:UIImageView = UIImageView(image: UIImage(named: "left"))
    fileprivate lazy var rightArmImageV:UIImageView = UIImageView(image: UIImage(named: "right"))
    
    fileprivate lazy var loginView:UIView = UIView()
    fileprivate lazy var usernameTextF:UITextField = UITextField()
    fileprivate lazy var passwordTextF:UITextField = UITextField()
    
    fileprivate lazy var clickType:LoginFieldClickType = LoginFieldClickType.none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoginView()
        setupLoginTopView()
    }
    
    func setupLoginTopView() -> Void {
        
        headerImageV.frame = CGRect(x: KScreenWidth * 0.5 - 211 * 0.5, y: 0, width:211, height:108)
        self.addSubview(headerImageV)
     
        leftHandImageV.frame = CGRect(x: KScreenWidth * 0.5 - 100, y:headerImageV.frame.maxY - 30, width: 40, height: 40)
        self.addSubview(leftHandImageV)
        
        rightHandImageV.frame = CGRect(x: KScreenWidth * 0.5 + 60, y:headerImageV.frame.maxY - 30, width: 40, height: 40)
        self.addSubview(rightHandImageV)
        
        leftArmImageV.frame = CGRect(x: KScreenWidth * 0.5 - 100, y: headerImageV.frame.maxY, width: 40, height: 65)
        self.addSubview(leftArmImageV)
        
        rightArmImageV.frame = CGRect(x: KScreenWidth * 0.5 + 60, y: headerImageV.frame.maxY, width: 40, height: 65)
        self.addSubview(rightArmImageV)
        
        self.bringSubview(toFront: loginView)
        self.bringSubview(toFront: leftHandImageV)
        self.bringSubview(toFront: rightHandImageV)
    }
    
    func setupLoginView() -> Void {
        loginView.frame = CGRect(x: 20, y: rightHandImageV.center.y, width: KScreenWidth - 40, height: 160)
        loginView.backgroundColor = UIColor.white
        loginView.layer.borderWidth = 1
        loginView.layer.borderColor = UIColor.lightGray.cgColor
        loginView.layer.cornerRadius = 5
        loginView.layer.masksToBounds = true
        self.addSubview(loginView)
        
        //用户名
        usernameTextF.frame = CGRect(x: 20, y: 30, width: loginView.frame.width - 40, height: 44)
        loginView.addSubview(usernameTextF)
        usernameTextF.layer.borderWidth = 1
        usernameTextF.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextF.layer.cornerRadius = 5
        usernameTextF.layer.masksToBounds = true
        let userImageV = UIImageView(image: UIImage(named: "user"))
        let usernameLeftV = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        userImageV.frame = CGRect(x: 11, y: 11, width: 22, height: 22)
        usernameLeftV.addSubview(userImageV)
        usernameTextF.leftViewMode = UITextFieldViewMode.always
        usernameTextF.leftView = usernameLeftV
        usernameTextF.delegate = self
        
        //密码
        passwordTextF.frame = CGRect(x: 20, y:160 - 30 - 44 , width: loginView.frame.width - 40, height: 44)
        loginView.addSubview(passwordTextF)
        passwordTextF.layer.borderWidth = 1
        passwordTextF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextF.layer.cornerRadius = 8
        passwordTextF.layer.masksToBounds = true
        let passImageV = UIImageView(image: UIImage(named: "pass"))
        let passLeftV = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        passImageV.frame = CGRect(x: 11, y: 11, width: 22, height: 22)
        passLeftV.addSubview(passImageV)
        passwordTextF.leftViewMode = UITextFieldViewMode.always
        passwordTextF.leftView = passLeftV
        passwordTextF.delegate = self
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.usernameTextF{
            print("username")
            if self.clickType == LoginFieldClickType.usernameF{
                return
            }
            self.clickType = LoginFieldClickType.usernameF
            clickUsernameField()
        }else if textField == self.passwordTextF{
            print("password")
            if self.clickType == LoginFieldClickType.passwordF{
                return
            }
            self.clickType = LoginFieldClickType.passwordF
            clickPasswordField()
        }
    }
    
    //MAKR:点击密码框，改变左胳膊和右胳膊的frame
    func clickPasswordField() -> Void {

        UIView.animate(withDuration: 0.5) {
           
            self.leftArmImageV.frame = CGRect(x: self.leftHandImageV.frame.maxX + 15, y: 60, width: 40, height: 65)
            self.rightArmImageV.frame = CGRect(x: self.rightHandImageV.frame.minX - 10 - 40, y: 60, width: 40, height: 65)
            
            var leftHandFrame = self.leftHandImageV.frame
            leftHandFrame.origin.x += 70
            leftHandFrame.size = CGSize(width: 0, height: 0)
            self.leftHandImageV.frame = leftHandFrame
            
            var rightHandFrame = self.rightHandImageV.frame
            rightHandFrame.origin.x -= 30
            rightHandFrame.size = CGSize(width: 0, height: 0)
            self.rightHandImageV.frame = rightHandFrame
        }
    }
    
    //MARK:点击用户昵称框
    func clickUsernameField() -> Void {
        UIView.animate(withDuration: 0.5) {
            
            self.leftHandImageV.frame = CGRect(x: KScreenWidth * 0.5 - 100, y:self.headerImageV.frame.maxY - 30, width: 40, height: 40)
            
            self.rightHandImageV.frame = CGRect(x: KScreenWidth * 0.5 + 60, y:self.headerImageV.frame.maxY - 30, width: 40, height: 40)

            self.leftArmImageV.frame = CGRect(x: self.leftHandImageV.frame.origin.x, y: self.headerImageV.frame.maxY, width: 40, height: 65)
            
            self.rightArmImageV.frame = CGRect(x: self.rightHandImageV.frame.origin.x, y: self.headerImageV.frame.maxY, width: 40, height: 65)
        }
    }
}
