//
//  UCHeaderPullAnimationViewController.swift
//  Loading
//
//  Created by mac on 2017/3/1.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class UCHeaderPullAnimationViewController: UIViewController {
    
    fileprivate let UCHeaderPullCellID = "UCHeaderPullCellID"
    
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate lazy var tableHeader:UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 200))
        header.backgroundColor = UIColor.red
        return header
    }()
    
    fileprivate lazy var headerView:UCHeaderView = {
        let header = UCHeaderView(frame: CGRect(x: 0, y: 0, width: KWidth, height: 200))
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:设置UI
    func setupUI() -> Void {
        tableView.tableHeaderView = tableHeader
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UCHeaderPullCellID)
        view.addSubview(tableView)
        
        view.addSubview(headerView)
    }
}

extension UCHeaderPullAnimationViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UCHeaderPullCellID)
        cell?.textLabel?.text = "第\(indexPath.row)行"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        let offsetY = scrollView.contentOffset.y
        var frame = self.headerView.frame
        if offsetY < 0{
            frame.size.height = 200 - offsetY
            frame.origin.y = 0
        }else{
            frame.size.height = 200
            frame.origin.y = -offsetY
        }
        self.headerView.frame = frame
        self.headerView.setNeedsDisplay()
    }
}

class UCHeaderView: UIView {
    
    let borderLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        
        let basicHeight:CGFloat = 200
        let dealt:CGFloat = (self.frame.size.height - basicHeight) * 0.1
        let path = UIBezierPath()
        let rect = self.bounds
        path.move(to: rect.origin)
        path.addLine(to: CGPoint(x: rect.minX, y: basicHeight))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY), controlPoint: CGPoint(x: rect.width * 0.25, y: rect.maxY - dealt))
        path.addQuadCurve(to:CGPoint(x: rect.maxX, y: basicHeight), controlPoint: CGPoint(x: rect.width * 0.75, y: rect.maxY - dealt))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.close()
        
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.orange.cgColor
        borderLayer.strokeColor = UIColor.clear.cgColor
        self.layer.insertSublayer(borderLayer, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
