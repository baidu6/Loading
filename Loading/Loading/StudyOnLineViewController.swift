//
//  StudyOnLineViewController.swift
//  Loading
//
//  Created by mac on 2017/2/23.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit
class StudyOnLineViewController: UIViewController {
    
    fileprivate let StudyCollectionViewCellID = "StudyCollectionViewCellID"
    fileprivate lazy var collectionView:UICollectionView = {
        let collectionV = UICollectionView(frame:CGRect(x: 0, y: 0, width: KWidth, height: KHeight), collectionViewLayout: StudyCollectionFlowLayout())
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = UIColor.white
        collectionV.contentSize = CGSize(width: KWidth, height: KHeight * 2)
        collectionV.register(StudyCollectionViewCell.self, forCellWithReuseIdentifier: self.StudyCollectionViewCellID)
        return collectionV
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }
}

extension StudyOnLineViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudyCollectionViewCellID, for: indexPath) as! StudyCollectionViewCell
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        if indexPath.row == 0{
//            return CGSize(width: 200, height: 200)
//        }
//        return CGSize(width: 100, height: 100)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
//        return 10
//    }
}

class StudyCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class StudyCollectionFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate lazy var attributesArray:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    override init() {
        super.init()
        scrollDirection = UICollectionViewScrollDirection.vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        let margin:CGFloat = 10
        let totalCol:CGFloat = 3
        sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        let basicItemSizeW:CGFloat = (KWidth - margin * (totalCol + 1)) / totalCol
        let basicItemSizeH:CGFloat = basicItemSizeW
        let bigItemSizeW:CGFloat = basicItemSizeW * 2 + margin
        let bigItemSizeH:CGFloat = bigItemSizeW
        let itemsCount = collectionView?.numberOfItems(inSection: 0)
        var itemX:CGFloat = margin
        var itemY:CGFloat = margin
        var itemW:CGFloat = basicItemSizeW
        var itemH:CGFloat = basicItemSizeH
        
        let groupHeight:CGFloat = margin * 3 + basicItemSizeH * 4
        
        if let itemsCount = itemsCount{
            for i in 0..<itemsCount{
                let index = i % 8
                let groupIndex:CGFloat = CGFloat(i / 8)
                print(groupIndex)
                switch index {
                case 0:
                    itemX = margin
                    itemY = margin + groupIndex * groupHeight
                    itemW = bigItemSizeW
                    itemH = bigItemSizeH
                case 1:
                    itemX = bigItemSizeW + margin * 2
                    itemY = margin + groupIndex * groupHeight
                    itemW = basicItemSizeW
                    itemH = basicItemSizeH
                case 2:
                    itemX = bigItemSizeW + margin * 2
                    itemY = margin * 2 + basicItemSizeH + groupIndex * groupHeight
                    itemW = basicItemSizeW
                    itemH = basicItemSizeH
                case 3:
                    itemX = margin
                    itemY = bigItemSizeH + margin * 2 + groupIndex * groupHeight
                    itemW = basicItemSizeW
                    itemH = basicItemSizeH
                case 4:
                    itemX = margin * 2 + basicItemSizeW
                    itemY = bigItemSizeH + margin * 2 + groupIndex * groupHeight
                    itemW = basicItemSizeW
                    itemH = basicItemSizeH
                case 5:
                    itemX = (basicItemSizeW + margin) * 2 + margin
                    itemY = bigItemSizeH + margin * 2 + groupIndex * groupHeight
                    itemW = basicItemSizeW
                    itemH = basicItemSizeH
                case 6:
                    itemX = margin
                    itemY = bigItemSizeH + basicItemSizeH + margin * 3 + groupIndex * groupHeight
                    itemW = basicItemSizeW
                    itemH = basicItemSizeH
                case 7:
                    itemX = margin * 2 + basicItemSizeW
                    itemY = bigItemSizeH + basicItemSizeH + margin * 3 + groupIndex * groupHeight
                    itemW = basicItemSizeW
                    itemH = basicItemSizeH
                default:
                    break
                }
                let attri = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: index, section: 0))
                attri.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                self.attributesArray.append(attri)
                }
            }
        }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
   
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attributesArray
    }

}
