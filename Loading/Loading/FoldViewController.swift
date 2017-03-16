//
//  FoldViewController.swift
//  Loading
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class FoldViewController: UIViewController {
    
    fileprivate let FoldTableViewCellID = "FoldTableViewCellID"
    
    fileprivate lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight))
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    //cell折叠状态下的高度
    fileprivate let KCloseCellHeight:CGFloat = 180
    
    //cell打开状态的高度
    fileprivate let KOpenCellHeight:CGFloat = 500
    
    //总共的行数
    fileprivate let KRowsCount:Int = 10
    
    //cell的高度数组
    var cellHeights:[CGFloat] = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupTableView()
    }
    
    func setupNav() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
    }
    
    //MARK:初始化tableView
    func setupTableView() -> Void {
        
        tableView.register(FoldTableViewCell.self, forCellReuseIdentifier: FoldTableViewCellID)
        view.addSubview(tableView)
        
        for _ in 0..<KRowsCount{
            cellHeights.append(KCloseCellHeight)
        }
    }
    
    func back() -> Void {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension FoldViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoldTableViewCellID) as! FoldTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
