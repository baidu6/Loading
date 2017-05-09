//
//  YHAlertViewController.swift
//  Loading
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class YHAlertViewController: UIViewController {
    fileprivate lazy var clickBtn:UIButton = UIButton(frame: CGRect(x: (KWidth - 100) * 0.5, y: 100, width: 100, height: 44))
    fileprivate lazy var passwordV:TradePasswordView = TradePasswordView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        clickBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        clickBtn.setTitle("click me!", for: UIControlState.normal)
        clickBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        clickBtn.titleLabel?.textAlignment = NSTextAlignment.center
        clickBtn.backgroundColor = UIColor.orange
        clickBtn.addTarget(self, action: #selector(showTradePasswordView), for: UIControlEvents.touchUpInside)
        view.addSubview(clickBtn)
    }
    
    func showTradePasswordView() -> Void {

        TradePasswordView.show(detailStr: "新增中国银行_联通(尾号3205)定投银华永定礼券型证券投资基金（000287），金额686836586元")
        TradePasswordView.tradeVBtnClick = {[weak self]btn in
            print("点击了确定按钮")
        }
    }
}

class TradePasswordView: UIView,UITextFieldDelegate {
    
    //左右两边的间距
    fileprivate let margin:CGFloat = 8
    //总的宽度
    fileprivate let mainWidth:CGFloat = UIScreen.main.bounds.size.width - 40
    //上面的间距
    fileprivate let topMargin:CGFloat = 15
    //白色背景view
    fileprivate lazy var bgView:UIView = UIView()
    //标题
    fileprivate lazy var titleL:UILabel = UILabel()
    //详细内容
    fileprivate lazy var detailL:UILabel = UILabel()

    //密码框
    fileprivate lazy var passwordF:UITextField = UITextField()
    //分割线
    fileprivate lazy var sepeartorV:UIView = UIView()
    
    //遮盖btn
    fileprivate lazy var coverBtn:UIButton = UIButton()
    
    //显示到detailL上面的文字
    var detailTitle:String?
    
    //点击确定按钮将要做出的处理事件
    typealias tradeViewBtnDidClick = (_ btn:UIButton) -> Void
    static var tradeVBtnClick:tradeViewBtnDidClick?
    
    fileprivate lazy var cancelBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: UIControlState.normal)
        btn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    fileprivate lazy var sureBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("确定", for: UIControlState.normal)
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
        btn.isEnabled = false
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    func setupUI() -> Void {

        //遮盖btn
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.height)
        coverBtn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.height)
        coverBtn.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.addSubview(coverBtn)
        coverBtn.addSubview(bgView)
        
        //titleL
        titleL.frame.origin = CGPoint(x: self.margin, y: 15)
        titleL.frame.size = CGSize(width: self.mainWidth - self.margin * 2, height: self.caculateLabelSize(str: "请输入交易密码", fontSize: 15).height)
        titleL.text = "请输入交易密码"
        titleL.textColor = UIColor.darkGray
        titleL.font = UIFont.systemFont(ofSize: 15)
        titleL.textAlignment = NSTextAlignment.center
        bgView.addSubview(titleL)
        
        let detailStr = (self.detailTitle != nil) ? self.detailTitle! : ""
        detailL.frame.origin = CGPoint(x: self.margin, y: titleL.frame.maxY + self.topMargin)
        let width = self.caculateLabelSize(str:detailStr , fontSize: 13).width
        detailL.frame.size = CGSize(width: width < mainWidth - 2 * margin ? mainWidth - 2 * margin : width, height: self.caculateLabelSize(str: detailStr, fontSize: 13).height)
        detailL.textAlignment = NSTextAlignment.center
        detailL.textColor = UIColor.darkGray
        detailL.numberOfLines = 0
        detailL.text = detailStr
        detailL.font = UIFont.systemFont(ofSize: 13)
        bgView.addSubview(detailL)
        
        passwordF.frame = CGRect(x: self.margin, y: detailL.frame.maxY + self.topMargin, width: self.mainWidth - self.margin * 2, height: 25)
        passwordF.layer.cornerRadius = 5
        passwordF.layer.masksToBounds = true
        passwordF.placeholder = "请输入6位数字交易密码"
        passwordF.layer.borderWidth = 1
        passwordF.font = UIFont.systemFont(ofSize: 13)
        passwordF.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        passwordF.backgroundColor = UIColor.white
        let leftV = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 25))
        passwordF.leftView = leftV
        passwordF.leftViewMode = UITextFieldViewMode.always
        passwordF.delegate = self
        bgView.addSubview(passwordF)
        
        sepeartorV.frame = CGRect(x: 0, y: passwordF.frame.maxY + self.topMargin, width: self.mainWidth, height: 1)
        sepeartorV.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        bgView.addSubview(sepeartorV)
        
        cancelBtn.frame = CGRect(x: 0, y: sepeartorV.frame.maxY, width: self.mainWidth * 0.5, height: 35)
        cancelBtn.addTarget(self, action: #selector(btnDidClick(btn:)), for: UIControlEvents.touchUpInside)
        cancelBtn.tag = 4
        bgView.addSubview(cancelBtn)
        
        let view = UIView(frame: CGRect(x: self.mainWidth * 0.5, y: sepeartorV.frame.maxY, width: 1, height: 35))
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        bgView.addSubview(view)
        
        sureBtn.frame = CGRect(x: self.mainWidth * 0.5, y: sepeartorV.frame.maxY, width: self.mainWidth * 0.5, height: 35)
        sureBtn.tag = 5
        sureBtn.addTarget(self, action: #selector(btnDidClick(btn:)), for: UIControlEvents.touchUpInside)
        bgView.addSubview(sureBtn)
        
        
        bgView.frame = CGRect(x: (UIScreen.main.bounds.width - self.mainWidth) * 0.5, y: (UIScreen.main.bounds.height - sureBtn.frame.maxY) * 0.5, width: self.mainWidth, height: sureBtn.frame.maxY)
        bgView.layer.cornerRadius = 6
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        bgView.alpha = 0
    }
   
    //MARK:点击取消或者是确定按钮
    func btnDidClick(btn:UIButton) -> Void {
        
        if btn.tag == 4 {//取消
            self.dismissTradeView()
        }else if btn.tag == 5{//确定
            TradePasswordView.tradeVBtnClick?(btn)
            self.dismissTradeView()
        }
    }
    
    //MARK:显示
     func showTradeView(detailStr:String?){
            self.detailTitle = detailStr
        setupUI()
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.alpha = 1
        }) { (_) in
            
        }
    }
    
    //MARK:消失
     func dismissTradeView() -> Void {
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    //MARK:显示 外部调用
    class func show(detailStr:String) -> Void {
        let window = UIApplication.shared.delegate?.window
        if let window = window{
            let tradeV = TradePasswordView()
            window?.addSubview(tradeV)
            tradeV.showTradeView(detailStr: detailStr)
        }
    }
    
    //MARK:计算label的宽度
    func caculateLabelSize(str:String,fontSize:CGFloat) -> CGSize {
        
        let maxSize = CGSize(width: self.mainWidth - self.margin * 2, height:self.frame.size.height)
        return (str as NSString).boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.characters.count >= 6{
            self.sureBtn.isEnabled = true
        }else{
            self.sureBtn.isEnabled = false
        }
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
