//
//  TableViewTapAnimationController.swift
//  Loading
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class TableViewTapAnimationController:UIViewController{
    fileprivate var tapModelsArray:[TapAnimationModel] = [TapAnimationModel]()
    fileprivate let TapAnimationCellID = "TapAnimationCellID"
    fileprivate lazy var tableView:UITableView = {
        let tableV = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight))
        tableV.delegate = self
        tableV.dataSource = self
        return tableV
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        appendModesl()
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.register(TapAnimationCell.self, forCellReuseIdentifier: TapAnimationCellID)
    }
    func appendModesl() -> Void {
        tapModelsArray.append(TapAnimationModel(name: "YouXianMing", selected: false))
        tapModelsArray.append(TapAnimationModel(name: "Animations", selected: false))
        tapModelsArray.append(TapAnimationModel(name: "YoCelsius", selected: false))
        tapModelsArray.append(TapAnimationModel(name: "iOS-Progrommer", selected: false))
        tapModelsArray.append(TapAnimationModel(name: "Design-Patterns", selected: false))
        tapModelsArray.append(TapAnimationModel(name: "Arabia-Terra", selected: false))
        tapModelsArray.append(TapAnimationModel(name: "Swift", selected: false))
    }
}

extension TableViewTapAnimationController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tapModelsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TapAnimationCellID) as! TapAnimationCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TapAnimationCell
        cell.selectedEvent()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
