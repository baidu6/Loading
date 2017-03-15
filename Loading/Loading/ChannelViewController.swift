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
    fileprivate let ChannelCollectionHeaderViewID = "ChannelCollectionHeaderViewID"
    var selectedArr = ["推荐","河北","财经","娱乐","体育","社会","NBA","视频","汽车","图片","科技","军事","国际","数码","星座","电影","时尚","文化","游戏","教育","动漫","政务","纪录片","房产","佛学","股票","理财"]
    
    var recommendArr = ["有声","家居","电竞","美容","电视剧","搏击","健康","摄影","生活","旅游","韩流","探索","综艺","美食","育儿"]
    
    var headerArr = [["切换频道","点击添加更多频道"],["长按拖动排序","点击添加更多频道"]]
    var isEdite = false
    var indexPath:IndexPath?
    
    //移动到的目标indexPath
    var targetIndexPath:IndexPath?
    
    fileprivate lazy var collectionView:UICollectionView = {
        
        let collectionV = UICollectionView(frame: CGRect(x: 0, y: 0, width: KWidth, height: KHeight), collectionViewLayout: ChannelViewFlowLayout())
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()
    
    fileprivate lazy var dragingItem:ChannelCollectionViewCell = {
        let item = ChannelCollectionViewCell(frame: CGRect(x: 0, y: 0, width: itemW, height: itemW * 0.5))
        item.isHidden = true
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ChannelCollectionViewCell.self, forCellWithReuseIdentifier: ChannelCollectionViewCellID)
        collectionView.register(ChannelCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ChannelCollectionHeaderViewID)
        view.addSubview(collectionView)
        collectionView.addSubview(dragingItem)
        
        //添加长按手势
        let pressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressG:)))
        collectionView.addGestureRecognizer(pressGesture)
    }
    
    func longPress(longPressG:UILongPressGestureRecognizer) -> Void {
        if  isEdite == false{
            isEdite = !isEdite
            collectionView.reloadData()
            return
        }
        
        let point = longPressG.location(in: collectionView)
        switch longPressG.state {
        case UIGestureRecognizerState.began:
            drageBegin(point: point)
        case UIGestureRecognizerState.changed:
            drageChanged(point: point)
        case UIGestureRecognizerState.ended:
            drageEnded(point: point)
        case UIGestureRecognizerState.cancelled:
            drageEnded(point: point)
        default:
            break
        }
    }
    
    //MARK:开始长按
    func drageBegin(point:CGPoint) -> Void {
        indexPath = collectionView.indexPathForItem(at: point)
        if indexPath == nil || (indexPath?.section)! > 0{
            return
        }
        let item = collectionView.cellForItem(at: indexPath!) as? ChannelCollectionViewCell
        item?.isHidden = true
        dragingItem.isHidden = false
        dragingItem.frame = (item?.frame)!
        dragingItem.text = item?.text
        dragingItem.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    //MARK:长按过程
    func drageChanged(point:CGPoint) -> Void {
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0{
            return
        }
        dragingItem.center = point
        targetIndexPath = collectionView.indexPathForItem(at: point)
        
        if targetIndexPath == nil || (targetIndexPath?.section)! > 0 || indexPath == targetIndexPath || (targetIndexPath?.item)! == 0{
            return
        }
        //更新数据
        let text = selectedArr[indexPath!.item]
        selectedArr.remove(at:indexPath!.row)
        selectedArr.insert(text, at: targetIndexPath!.item)
        
        //交换位置
        collectionView.moveItem(at: indexPath!, to: targetIndexPath!)
        indexPath = targetIndexPath
    }
    
    //MARK:长按结束
    func drageEnded(point:CGPoint) -> Void {
        if indexPath == nil || (indexPath?.section)! > 0{
            return
        }
        let endCell = collectionView.cellForItem(at: indexPath!)
        UIView.animate(withDuration: 0.25, animations: {
            self.dragingItem.transform = CGAffineTransform.identity
            self.dragingItem.center = (endCell?.center)!
        }) { (_) in
            endCell?.isHidden = false
            self.dragingItem.isHidden = true
            self.indexPath = nil
        }
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
        cell.text = indexPath.section == 0 ? self.selectedArr[indexPath.row] : self.recommendArr[indexPath.row]
        cell.isEdite = isEdite
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if isEdite == true{
                if indexPath.item == 0{
                    return
                }
                let text = selectedArr[indexPath.row]
                recommendArr.insert(text, at: 0)
                selectedArr.remove(at: indexPath.row)
                collectionView.moveItem(at: indexPath, to: IndexPath(row: 0, section: 1))
            }else if isEdite == false{
                print("普通的点击事件，哈哈哈")
            }
        }else if indexPath.section == 1{
            
            let text = recommendArr[indexPath.row]
            recommendArr.remove(at: indexPath.row)
            selectedArr.append(text)
            collectionView.moveItem(at: indexPath, to: IndexPath(item: selectedArr.count - 1, section: 0))
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ChannelCollectionHeaderViewID, for: indexPath) as! ChannelCollectionHeaderView
        header.text = isEdite ? headerArr[1][indexPath.section] : headerArr[0][indexPath.section]
        header.button.isSelected = isEdite
        header.button.isHidden = indexPath.section > 0 ? true : false
        header.headerBtnClick = {[weak self] in
            self?.isEdite = !(self?.isEdite)!
            collectionView.reloadData()
        }
        return header
    }
}

class ChannelCollectionHeaderView:UICollectionReusableView{
    
    typealias HeaderButtonDidClick = () -> Void
    var headerBtnClick:HeaderButtonDidClick?
    
    var text:String?{
        didSet{
            titleLabel.text = text
        }
    }
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var button:UIButton = {
        let btn = UIButton()
        btn.setTitle("编辑", for: UIControlState.normal)
        btn.setTitle("完成", for: UIControlState.selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.titleLabel?.textAlignment = NSTextAlignment.right
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(button)
        
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        titleLabel.mas_makeConstraints { (make) in
            _ = make?.left.mas_equalTo()(self.mas_left)?.offset()(20)
            _ = make?.centerY.mas_equalTo()(self.mas_centerY)
        }
        button.mas_makeConstraints { (make) in
            _ = make?.right.mas_equalTo()(self.mas_right)?.offset()(-20)
            _ = make?.centerY.mas_equalTo()(self.mas_centerY)
            _ = make?.width.mas_equalTo()(50)
            _ = make?.height.mas_equalTo()(30)
        }
    }
  
    //MARK:buttonClick
    func buttonClick() -> Void {
        self.headerBtnClick!()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ChannelCollectionViewCell:UICollectionViewCell{
    
    var isEdite:Bool = true{
        didSet{
            closeImageV.isHidden = !isEdite
        }
    }
    
    var text:String?{
        didSet{
            label.text = text
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
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ChannelViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        headerReferenceSize = CGSize(width: KWidth, height: 40)
        itemSize = CGSize(width: itemW, height: itemW * 0.5)
        minimumLineSpacing = 15
        minimumInteritemSpacing = 20
        sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}
