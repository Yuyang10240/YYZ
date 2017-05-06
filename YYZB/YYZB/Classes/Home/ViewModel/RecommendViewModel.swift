//
//  RecommendViewModel.swift
//  YYZB
//
//  Created by unicorn on 2017/5/4.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit

class RecommendViewModel {

    // MARK:- 懒加载属性
     lazy var anchorGroups:[AnchorGroup]=[AnchorGroup]()
    lazy var cycleModels:[CycleModel]=[CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    // 请求推荐数据
    func requestData(_ finishCallback :  @escaping () -> ()){
        //1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        //2.创建group
        let dGroup=DispatchGroup()
        
        //3.请求第一部分推荐数据
        dGroup.enter()

        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":Date.getCurrentTime()]){
            (result)in
            
            //1.将result转成字典
            guard let resultDict=result as?[String :NSObject]else{return}
            //2.根据data的key获取数据
            guard let dataArray=resultDict["data"]as?[[String:NSObject]]else{return}
            //3.遍历字典，并且转换成模型对象
            self.bigDataGroup.tag_name="热门"
            self.bigDataGroup.icon_name="home_header_hot"
            for dict in dataArray{
                let anchor=AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
            
            
        }
        
        //4.请求第二部分颜值数据
        dGroup.enter()
        
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters){
            (result)in
            //1.将result转成字典
            guard let resultDict=result as?[String :NSObject]else{return}
            //2.根据data的key获取数据
            guard let dataArray=resultDict["data"]as?[[String:NSObject]]else{return}
            //3.遍历字典，并且转换成模型对象
            self.prettyGroup.tag_name="颜值"
            self.prettyGroup.icon_name="home_header_phone"
            for dict in dataArray{
                let anchor=AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
           
            
        }
        
        //5.请求2-12部分游戏数据
        dGroup.enter()
        
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters){
            (result)in
            
            //1.将result转成字典
            guard let resultDict=result as?[String :NSObject]else{return}
            //2.根据data的key获取数据
            guard let dataArray=resultDict["data"]as?[[String:NSObject]]else{return}
            //3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray{
                let group=AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            dGroup.leave()
            

        }
        // 6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    //请求无线轮播数据
    func requestCycleData(_ finishCallback :  @escaping () -> ()){
    NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.300"]){
    (result)in
        //1.将result转成字典
        guard let resultDict=result as?[String :NSObject]else{return}
        //2.根据data的key获取数据
        guard let dataArray=resultDict["data"]as?[[String:NSObject]]else{return}
        //3.遍历数组，获取字典，并且将字典转成模型对象
        for dict in dataArray{
            self.cycleModels.append(CycleModel(dict: dict))
        }

        
        finishCallback()
      }
    
    }
}
