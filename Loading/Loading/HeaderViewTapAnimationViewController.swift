//
//  HeaderViewTapAnimationViewController.swift
//  Loading
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class HeaderViewTapAnimationViewController: UIViewController {
    
    fileprivate let ClassStudentsCellID = "ClassStudentsCellID"
    
    fileprivate lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight))
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupNav()
        setupTable()
    }
    
    func setupTable() -> Void {
        tableView.register(ClassStudentsCell.self, forCellReuseIdentifier: ClassStudentsCellID)
        view.addSubview(tableView)
    }
    
    func setupNav() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
    }
    
    func back() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HeaderViewTapAnimationViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassStudentsCellID) as! ClassStudentsCell
        return cell
    }
}

