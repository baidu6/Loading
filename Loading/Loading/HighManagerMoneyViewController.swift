//
//  HighManagerMoneyViewController.swift
//  Loading
//
//  Created by mac on 2017/3/6.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
let K_FitHeight:CGFloat = UIScreen.main.bounds.size.height / 667
let K_FitWidth:CGFloat = UIScreen.main.bounds.size.width / 375

class HighManagerMoneyViewController: UIViewController {
    fileprivate let HighManagerTableViewCellID = "HighManagerTableViewCellID"
    fileprivate lazy var titleV:NavTitleView = NavTitleView(frame: CGRect(x: (KWidth - 270) * 0.5, y: 20, width: 270, height: 30))
    fileprivate lazy var headerV:HighManagerHeaderView = HighManagerHeaderView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 80))
    fileprivate lazy var tableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight - 30))
    fileprivate lazy var footerLabel:UILabel = {
        let label = UILabel()
        label.text = "业绩比较基准不同于预期收益率"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.white
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
      
        setupNav()
        setupTableView()
        setupFooterLabel()
    }
    
    //MARK:设置导航
    func setupNav() -> Void {
        self.navigationItem.titleView = titleV
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
    }
    
    //MARK:设置tableView
    func setupTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerV
        tableView.register(HighManagerTableViewCell.self, forCellReuseIdentifier: HighManagerTableViewCellID)
        view.addSubview(tableView)
    }
    
    func setupFooterLabel() -> Void {
        view.addSubview(footerLabel)
     
        footerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.height.equalTo(30)
        }
    }
}

//MARK:tableView的代理方法
extension HighManagerMoneyViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HighManagerTableViewCellID) as! HighManagerTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(HighManagerDetailViewController(), animated: true)
    }
    //给tableViw或者是collectionView的cell添加简单地动画
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let array = tableView.indexPathsForVisibleRows
        let firstIndex = array?[0]
        //设置anchorPoint
        cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        //为了防止cell视图移动重新把cell放回原来的位置
        cell.layer.position = CGPoint(x: 0, y: cell.layer.position.y)
        //设置cell按照Z轴旋转90度，注意是弧度
        if let index = firstIndex{
            if index.row < indexPath.row{
                cell.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1.0)
            }else{
                cell.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 0, 1.0)
            }
        }
        cell.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}

