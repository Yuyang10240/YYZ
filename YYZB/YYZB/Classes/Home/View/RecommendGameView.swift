//
//  RecommendGameView.swift
//  YYZB
//
//  Created by unicorn on 2017/5/6.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {
    // MARK: 定义数据的属性
    var groups:[AnchorGroup]?{
        didSet{
            //移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            //添加更多组
            let moreGroup=AnchorGroup()
            moreGroup.tag_name="更多"
            groups?.append(moreGroup)
            //刷新表格
            collectionView.reloadData()
        }
    }
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        // 注册Cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }


    

}

// MARK:- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        //cell.baseGame = groups![(indexPath as NSIndexPath).item]
        //cell.backgroundColor=indexPath.item%2==0 ? UIColor.red:UIColor.blue
        cell.group=groups![indexPath.item]
        return cell
    }
}


