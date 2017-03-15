//
//  ChannelViewController.swift
//  Loading
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
fileprivate let itemW:CGFloat = (KWidth - 100) * 0.25
class ChannelViewController:UIViewController{
    fileprivate let ChannelCollectionViewCellID = "ChannelCollectionViewCellID"
    var selectedArr = ["推荐","河北","财经","娱乐","体育","社会","NBA","视频","汽车","图片","科技","军事","国际","数码","星座","电影","时尚","文化","游戏","教育","动漫","政务","纪录片","房产","佛学","股票","理财"]
    
    var recommendArr = ["有声","家居","电竞","美容","电视剧","搏击","健康","摄影","生活","旅游","韩流","探索","综艺","美食","育儿"]
    
    fileprivate lazy var collectionView:UICollectionView = {
        
        let collectionV = UICollectionView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight), collectionViewLayout: ChannelViewFlowLayout())
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ChannelCollectionViewCell.self, forCellWithReuseIdentifier: ChannelCollectionViewCellID)
        view.addSubview(collectionView)
    }
}

extension ChannelViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? selectedArr.count : recommendArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCellID, for: indexPath) as! ChannelCollectionViewCell
        cell.displayDatas(text: indexPath.section == 0 ? self.selectedArr[indexPath.row] : self.recommendArr[indexPath.row])
        return cell
    }
}

class ChannelCollectionViewCell:UICollectionViewCell{
    
    var isEdite:Bool = true{
        didSet{
            closeImageV.isHidden = !isEdite
        }
    }
    
    fileprivate lazy var label:UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    fileprivate lazy var closeImageV:UIImageView = {
        let closeImage = UIImageView(image: UIImage(named: "close"))
        closeImage.isHidden = true
        return closeImage
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.addSubview(closeImageV)
        
        label.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.contentView.mas_left)
            _ = make?.right.mas_equalTo()(self.contentView.mas_right)
            _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)
        }
        closeImageV.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.contentView.mas_left)
            _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            _ = make?.width.mas_equalTo()(10)
            _ = make?.height.mas_equalTo()(10)
        }
    }
    
    //MARK:展示数据
    func displayDatas(text:String) -> Void {
        label.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ChannelViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
//        headerReferenceSize = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        itemSize = CGSize(width: itemW, height: itemW * 0.5)
        minimumLineSpacing = 15
        minimumInteritemSpacing = 20
        sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}
