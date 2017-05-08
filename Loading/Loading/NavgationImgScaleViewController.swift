//
//  NavgationImgScaleViewController.swift
//  Loading
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class NavgationImgScaleViewController:UIViewController{
    
    fileprivate let maxTitleImageW:CGFloat = 70
    fileprivate let minTitleImageW:CGFloat = 30
    fileprivate let maxTitleImageCenterY:CGFloat = 44
    fileprivate let minTitleImageCenterY:CGFloat = 22

    fileprivate let NavgationImgScaleCellID = "NavgationImgScaleCellID"
    fileprivate lazy var titleImageView:UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "1"))
        
        return imageV
    }()
    fileprivate lazy var tableView:UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupNav()
        setupUI()
    }
    
    func setupNav() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        
        titleImageView.frame = CGRect(x: 0, y: 0, width: maxTitleImageW, height: maxTitleImageW)
       
        titleImageView.layer.masksToBounds = true
        self.navigationController?.navigationBar.addSubview(titleImageView)
        self.navigationController?.navigationBar.barTintColor = UIColor.red
    }
    
    //MARK:返回
    func back() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:setupUI
    func setupUI() -> Void {
        tableView.backgroundColor = UIColor.orange
        tableView.frame = CGRect(x: 0, y: 0, width: KWidth, height: KHeight)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NavgationImgScaleCellID)
        view.addSubview(tableView)
    }
}

extension NavgationImgScaleViewController:UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NavgationImgScaleCellID)! as UITableViewCell
        cell.textLabel?.text = "wangyun ---(\(indexPath.row + 1))"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let delta = scrollView.contentOffset.y + 64
        let distance:CGFloat = 200.0
        print(delta)
        print(delta / distance)
        if delta >= 0 && delta <= distance{
            
            self.titleImageView.frame = CGRect(x: 0, y: 0, width: self.maxTitleImageW * (( 1 - delta / distance) > 0.5 ? ( 1 - delta / distance) : 0.5), height: self.maxTitleImageW * (( 1 - delta / distance) > 0.5 ? ( 1 - delta / distance) : 0.5))

        }else if delta < 0{
            
            self.titleImageView.frame = CGRect(x: 0, y: 0, width: self.maxTitleImageW * (( 1 + delta / distance) > 1.0 ? ( 1 + delta / distance) : 1), height: self.maxTitleImageW * (( 1 + delta / distance) > 1.0 ? ( 1 + delta / distance) : 1))
        }
        
        //set center point
        titleImageView.center = CGPoint(x: KWidth * 0.5, y:5 + titleImageView.frame.height * 0.5)
        titleImageView.layer.cornerRadius = titleImageView.frame.height * 0.5
    }
}
