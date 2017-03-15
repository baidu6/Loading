//
//  LeftViewController.swift
//  Loading
//
//  Created by mac on 2017/3/14.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class LeftViewController: UIViewController {
    fileprivate lazy var tableView:UITableView = UITableView()
    fileprivate let LeftTableViewCellID:String = "LeftTableViewCellID"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupTable()
    }
    
    fileprivate func setupTable() -> Void{
        tableView.frame = CGRect(x: 0, y: 0, width: KWidth, height: KHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: LeftTableViewCellID)
        view.addSubview(tableView)
    }
}

extension LeftViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftTableViewCellID)! as UITableViewCell
        return cell
    }
}
