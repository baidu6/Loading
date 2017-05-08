//
//  TapCellAnimationViewController.swift
//  Loading
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class TapCellAnimationViewController: UIViewController {
    
    let TapTableViewCellID:String = "TapTableViewCellID"
    var datasArray:[TapCellModel] = [TapCellModel]()
    
    fileprivate lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight))
        table.backgroundColor = UIColor.white
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupUI()
        
        
        let str1 = "1424"
        let str2 = "13450"
        if str1 < str2{
            print("str1小哈哈哈")
        }else{
            print("str1大哈哈哈")
        }
    }
    
    func setupNav() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
    }
    
    func setupUI() -> Void {
        
        //沉于多余的线条
        tableView.tableFooterView = UIView()
        tableView.register(TapTableViewCell.self, forCellReuseIdentifier: TapTableViewCellID)
        view.addSubview(tableView)
        
        let strings = [
        "AFNetworking is a delightful networking library for iOS and Mac OS X. It's built on top of the Foundation URL Loading System, extending the powerful high-level networking abstractions built into Cocoa. It has a modular architecture with well-designed, feature-rich APIs that are a joy to use. Perhaps the most important feature of all, however, is the amazing community of developers who use and contribute to AFNetworking every day. AFNetworking powers some of the most popular and critically-acclaimed apps on the iPhone, iPad, and Mac. Choose AFNetworking for your next project, or migrate over your existing projects—you'll be happy you did!",
        
        "黄色的树林里分出两条路，可惜我不能同时去涉足，我在那路口久久伫立，我向着一条路极目望去，直到它消失在丛林深处。但我却选了另外一条路，它荒草萋萋，十分幽寂，显得更诱人、更美丽，虽然在这两条小路上，都很少留下旅人的足迹，虽然那天清晨落叶满地，两条路都未经脚印污染。呵，留下一条路等改日再见！但我知道路径延绵无尽头，恐怕我难以再回返。也许多少年后在某个地方，我将轻声叹息把往事回顾，一片树林里分出两条路，而我选了人迹更少的一条，从此决定了我一生的道路。",
        
        "★タクシー代がなかったので、家まで歩いて帰った。★もし事故が発生した场所、このレバーを引いて列车を止めてください。（丁）为了清楚地表示出一个短语或句节，其后须标逗号。如：★この薬を、夜寝る前に一度、朝起きてからもう一度、饮んでください。★私は、空を飞ぶ鸟のように、自由に生きて行きたいと思った。*****为了清楚地表示词语与词语间的关系，须标逗号。标注位置不同，有时会使句子的意思发生变化。如：★その人は大きな音にびっくりして、横から飞び出した子供にぶつかった。★その人は、大きな音にびっくりして横から飞び出した子供に、ぶつかった。",
        
        "Two roads diverged in a yellow wood, And sorry I could not travel both And be one traveler, long I stood And looked down one as far as I could To where it bent in the undergrowth; Then took the other, as just as fair, And having perhaps the better claim, Because it was grassy and wanted wear; Though as for that the passing there Had worn them really about the same, And both that morning equally lay In leaves no step had trodden black. Oh, I kept the first for another day! Yet knowing how way leads on to way, I doubted if I should ever come back. I shall be telling this with a sigh Somewhere ages and ages hence: Two roads diverged in a wood, and I- I took the one less traveled by, And that has made all the difference. "]
        
        var indexPaths:[IndexPath] = [IndexPath]()
        for i in 0..<strings.count{
            let model = TapCellModel()
            model.inputString = strings[i]
            self.datasArray.append(model)
            indexPaths.append(IndexPath(item: i, section: 0))
        }
        
        let time: TimeInterval = 0.5
        Thread.sleep(forTimeInterval: time)
        self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.fade)
    }
   
    //MARK:返回
    func back() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TapCellAnimationViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TapTableViewCellID) as! TapTableViewCell
        cell.displayData(model: self.datasArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.datasArray[indexPath.row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.datasArray[indexPath.row]
        model.isSelected = !model.isSelected
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
}
