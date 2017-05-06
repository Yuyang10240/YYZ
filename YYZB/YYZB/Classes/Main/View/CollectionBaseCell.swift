//
//  CollectionBaseCell.swift
//  YYZB
//
//  Created by unicorn on 2017/5/6.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchor:AnchorModel?{
        didSet{
            //0.检验模型是否有值
            guard let anchor=anchor else{return}
            //1.取出在线人数显示的文字
            var onlineStr:String=""
            if anchor.online>=10000{
                onlineStr="\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr="\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for:.normal)
            //2.昵称的显示
            nickNameLabel.text=anchor.nickname
            
            //3.设置封面图
            guard let iconURL=URL(string: anchor.vertical_src)else{return}
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
