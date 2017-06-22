//
//  TapTableViewCell.swift
//  Loading
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 czj. All rights reserved.
//
import SnapKit
import UIKit
class TapTableViewCell: UITableViewCell {
    
    var model:TapCellModel!
    
    fileprivate lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.white
        return label
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(self.snp.height)
        }
    

    }
    
    func displayData(model:TapCellModel) -> Void {
        self.model = model
        self.contentLabel.text = model.inputString


        let maxSize = CGSize(width: KWidth - 20, height: CGFloat(MAXFLOAT))
        let size = (self.model.inputString as NSString).boundingRect(with: maxSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.truncatesLastVisibleLine,NSStringDrawingOptions.usesFontLeading], attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15)], context: nil).size
       
        let oneLineSize = ("好" as NSString).boundingRect(with: maxSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.truncatesLastVisibleLine,NSStringDrawingOptions.usesFontLeading], attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15)], context: nil).size
        
        self.model.selectedHeight = size.height
        
        //正常的展示3行的高度
        self.model.normalHeight = oneLineSize.height * 3 + 20
        
        if model.isSelected == true{

            self.model.cellHeight = self.model.selectedHeight
        }else{

            self.model.cellHeight = self.model.normalHeight
        }
    }
}
