//
//  FoldTableViewCell.swift
//  Loading
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class FoldTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    //MARK:setupUI
    func setupUI() -> Void {
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
