//
//  CollectionViewNormalCell.swift
//  YYZB
//
//  Created by unicorn on 2017/5/3.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {
    //定义模型属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor:AnchorModel?{
        didSet{
            super.anchor=anchor
            
            //房间名称
            roomNameLabel.text=anchor?.room_name

        }
    }

}
