//
//  CustomCell.swift
//  Loading
//
//  Created by mac on 2017/3/9.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class CustomCell:UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        buildSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell() -> Void {
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    func buildSubviews() -> Void {
        
    }
    func selectedEvent() -> Void {
        
    }
    func loadContent() -> Void {
        
    }
    class func HeightWithData(_ data:Any) -> CGFloat {
        return 0
    }
  
}
