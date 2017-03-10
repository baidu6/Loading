
//
//  HighManagerDetailViewController.swift
//  Loading
//
//  Created by mac on 2017/3/7.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class HighManagerDetailViewController: UIViewController {
    
    fileprivate lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight))
        scroll.backgroundColor = UIColor.white
        return scroll
    }()
    
    fileprivate lazy var headerView:DetailHeaderView = DetailHeaderView.headerView()
    fileprivate lazy var detailView:UIView = UIView()
    fileprivate lazy var descLabel:UILabel = {
        let descL = UILabel()
        descL.textAlignment = NSTextAlignment.center
        descL.textColor = UIColor(red: 79/255.0, green: 79/255.0, blue: 79/255.0, alpha: 1.0)
        descL.numberOfLines = 0
        descL.font = UIFont.systemFont(ofSize: 15)
        let desc = "首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;首行缩进根据字体大小自动调整,间隔可自定根据需求随意改变;"
        let paraStyle = NSMutableParagraphStyle()
        //对齐方式
        paraStyle.alignment = NSTextAlignment.left
        //行首缩进
        paraStyle.headIndent = 0.0
        //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
        let emptylen = descL.font.pointSize * 2
        //首行缩进
        paraStyle.firstLineHeadIndent = emptylen
        //行尾缩进
        paraStyle.tailIndent = 0.0
        //行间距
        paraStyle.lineSpacing = 2.0
        let attriText = NSAttributedString(string: desc, attributes: [NSParagraphStyleAttributeName:paraStyle])
        descL.attributedText = attriText
        return descL
    }()
    
    fileprivate lazy var purchaseButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("立即购买", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.titleLabel?.textAlignment = NSTextAlignment.center
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor(red: 255/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        btn.addTarget(self, action: #selector(purshase), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        setupNav()
        setupUI()
    }
    
    //MARK:设置导航
    func setupNav() -> Void {
        self.title = "高端产品详情"
    }
    
    //MARK:setupUI
    func setupUI() -> Void {
        view.addSubview(scrollView)
        view.addSubview(purchaseButton)
        scrollView.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.view.mas_left)
            _ = make?.top.mas_equalTo()(self.view.mas_top)
            _ = make?.width.mas_equalTo()(KWidth)
            _ = make?.height.mas_equalTo()(KHeight - 50)
        }
        purchaseButton.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.view.mas_left)?.offset()(16)
            _ = make?.right.mas_equalTo()(self.view.mas_right)?.offset()(-16)
            _ = make?.bottom.mas_equalTo()(self.view.mas_bottom)?.offset()(-10)
            _ = make?.height.mas_equalTo()(30)
        }
        
        scrollView.addSubview(headerView)
        scrollView.addSubview(detailView)
        
        //添加投影
//        headerView.layer.shadowColor = UIColor.black.cgColor
//        headerView.layer.shadowOffset = CGSize(width: 0, height: 5)
//        headerView.layer.shadowRadius = 10
//        headerView.layer.shadowOpacity = 0.3
        
        headerView.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.scrollView.mas_left)
            _ = make?.width.mas_equalTo()(KWidth)
            _ = make?.top.mas_equalTo()(self.scrollView.mas_top)
            _ = make?.height.mas_equalTo()(230)
        }
   
        detailView.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.scrollView.mas_left)
            _ = make?.width.mas_equalTo()(KWidth)
            _ = make?.top.mas_equalTo()(self.headerView.mas_bottom)
            _ = make?.bottom.mas_equalTo()(self.scrollView.mas_bottom)
        }
        setupDetailView()
    }
  
    //MARK:产品介绍的View
    func setupDetailView() -> Void {
        
        //title
        let titleLabel = UILabel()
        titleLabel.text = "产品介绍"
        titleLabel.textColor = UIColor(red: 79/255.0, green: 79/255.0, blue: 79/255.0, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = NSTextAlignment.left
        
        //seperator
        let seperatorV = UIView()
        seperatorV.backgroundColor = UIColor(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 0.6)
        
        detailView.addSubview(titleLabel)
        detailView.addSubview(seperatorV)
        detailView.addSubview(descLabel)
        
        titleLabel.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.detailView.mas_left)?.offset()(50)
            _ = make?.top.mas_equalTo()(self.detailView.mas_top)
            _ = make?.right.mas_equalTo()(self.detailView.mas_right)
            _ = make?.height.mas_equalTo()(40)
        }
        seperatorV.mas_makeConstraints { (make) in
            _ = make?.top.mas_equalTo()(titleLabel.mas_bottom)
            _ = make?.left.mas_equalTo()(self.detailView.mas_left)
            _ = make?.right.mas_equalTo()(self.detailView.mas_right)
            _ = make?.height.mas_equalTo()(1)
        }
        descLabel.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.detailView.mas_left)?.offset()(30)
            _ = make?.top.mas_equalTo()(seperatorV.mas_bottom)?.offset()(20)
            _ = make?.right.mas_equalTo()(self.detailView.mas_right)?.offset()(-30)
            _ = make?.bottom.mas_equalTo()(self.detailView.mas_bottom)
        }
    }
    
    func purshase() -> Void{
        
    }
}
