//
//  InsertDatasViewController.swift
//  Loading
//
//  Created by 王云 on 17/7/24.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit

class InsertDatasViewController: UIViewController {
    
    var tableView:UITableView!
    var dataSource:[String]?
    var tableViewLoadData = false
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        loadDatas()
    }
    
    func loadDatas() -> Void {
        dataSource = ["1","2","3","4","5","6","8","1","2","3","4","5","6","8","1","2","3","4","5","6","8","1","2","3","4","5","6","8","1","2","3","4","5","6","8","1","2","3","4","5","6","8"]

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.15) {
            var indexPaths:[IndexPath] = [IndexPath]()
            if let count = self.dataSource?.count{
                for i in 0..<count{
                    indexPaths.append(IndexPath(item: i, section: 0))
                }
                self.tableViewLoadData = true
                self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
            }
        }
        
    }
    
    func setupTableView() -> Void {
        tableView = UITableView(frame: self.view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "UITableViewCellID")
    }
}

extension InsertDatasViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewLoadData == true ? dataSource?.count ?? 0 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellID") as? ListTableViewCell
        cell?.titleL.text = "当前是第\(indexPath.row)"
        return cell!
    }
}


class ListTableViewCell: UITableViewCell {
    var titleL:UILabel!
    var descL:UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleL = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        descL = UILabel(frame: CGRect(x: 300, y: 0, width: 60, height: 44))
        self.contentView.addSubview(titleL)
        self.contentView.addSubview(descL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if isHighlighted {
            
            var frame = self.titleL.frame
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.15, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                frame.origin.x = 60
                self.titleL.frame = frame
            }, completion: { (_) in
                
            })
        }else{
            var frame = self.titleL.frame
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.15, initialSpringVelocity: 5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                frame.origin.x = 0
                self.titleL.frame = frame
            }, completion: { (_) in
                
            })
        }
    }
}
