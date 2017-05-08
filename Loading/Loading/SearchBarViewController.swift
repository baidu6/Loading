//
//  SearchBarViewController.swift
//  Loading
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class SearchBarViewController:UIViewController{
    
    fileprivate lazy var firstSearchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 74, width: KWidth - 20, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupFirstSearchBar()
    }
    
    //创建第一个输入框
    func setupFirstSearchBar() -> Void {
        firstSearchBar.placeholder = "请输入搜索的内容"
        firstSearchBar.backgroundColor = UIColor.orange
        firstSearchBar.tintColor = UIColor.lightGray
        firstSearchBar.barTintColor = UIColor.orange
        //default is NO
//        firstSearchBar.showsCancelButton = true
        
//        firstSearchBar.showsBookmarkButton = true
//        firstSearchBar.showsSearchResultsButton = true
        
//        let view = UIView(frame: CGRect(x: 0, y: 74, width: 20, height: 40))
//        view.backgroundColor = UIColor.red
//        firstSearchBar.inputAccessoryView = view
        view.addSubview(firstSearchBar)
        
        let searchField = firstSearchBar.value(forKey: "searchField") as? UITextField
        if let searchF = searchField{
            searchF.backgroundColor = UIColor.white
            searchF.layer.cornerRadius = 15
            searchF.layer.masksToBounds = true
            searchF.layer.borderWidth = 1
            searchF.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
