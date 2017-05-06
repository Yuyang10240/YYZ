//
//  RecommendViewController.swift
//  YYZB
//
//  Created by unicorn on 17/4/23.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat=10
private let kItemW=(kScreenW-3*kItemMargin)/2
private let kNormalItemH=kItemW*3/4
private let kPrettyItemH=kItemW*4/3
private let kHeaderViewH:CGFloat=50

private let kCycleViewH=kScreenW*3/8
private let kGameViewH:CGFloat=90

private let kNormalCellID="kNormalCellID"
private let kHeaderViewID="kHeaderViewID"
private let kPrettyCellID="kPrettyCellID"

class RecommendViewController: UIViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var cycleView:RecommendCycleView={
        let cycleView=RecommendCycleView.recommendCycleView()
        cycleView.frame=CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var recommedVM:RecommendViewModel=RecommendViewModel()
    fileprivate lazy var collectionView:UICollectionView={[unowned self]in
        //1.创建布局
        let layout=UICollectionViewFlowLayout()
        layout.itemSize=CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing=0
        layout.minimumInteritemSpacing=kItemMargin
        layout.headerReferenceSize=CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset=UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2.创建UICollectionView
        let collectionView=UICollectionView(frame: self.view.bounds,collectionViewLayout:layout)
        collectionView.backgroundColor=UIColor.white
        collectionView.dataSource=self
        collectionView.delegate=self
        collectionView.autoresizingMask=[.flexibleWidth,.flexibleHeight]
     collectionView.register(UINib(nibName:"CollectionViewNormalCell",bundle:nil), forCellWithReuseIdentifier: kNormalCellID)
    collectionView.register(UINib(nibName:"CollectionPrettyCell",bundle:nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        

        return collectionView
    }()
    
    fileprivate lazy var gameView:RecommendGameView={
        let gameView=RecommendGameView.recommendGameView()
        gameView.frame=CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
        
       
        
        
    }
}

// MARK:- 设置UI界面内容
extension RecommendViewController{
    fileprivate func setupUI(){
        //1.将UICollectionView添加到控制器View中
        view.addSubview(collectionView)
        //2.将CycleView添加到UICollectView中
        collectionView.addSubview(cycleView)
        //3.将gameView添加到UICollectView中
        collectionView.addSubview(gameView)
        //4.设置collectionView的内边距
        collectionView.contentInset=UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
    }
}


// MARK:- 请求数据
extension RecommendViewController{
    fileprivate func loadData(){
        //请求推荐数据
        //1.展示推荐数据
        recommedVM.requestData() {
            self.collectionView.reloadData()
        //2.将数据传递给GameView
        self.gameView.groups=self.recommedVM.anchorGroups
            
            
        
        }
        //请求轮播数据
        recommedVM.requestCycleData {
            self.cycleView.cycleModels=self.recommedVM.cycleModels
        }
    }
}
// MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommedVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group=recommedVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出模型
        let group=recommedVM.anchorGroups[indexPath.section]
        let anchor=group.anchors[indexPath.item]
        //2.定义cell
        var cell:CollectionBaseCell!
        //3.获取cell
        if indexPath.section==1{
             cell=collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)as!CollectionPrettyCell
           
        }else{
             cell=collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)as!CollectionViewNormalCell
            
        }
        //4.将模型赋值给cell
        cell.anchor=anchor
        return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)as!CollectionHeaderView
        //2.取出模型
        headerView.group=recommedVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section==1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
