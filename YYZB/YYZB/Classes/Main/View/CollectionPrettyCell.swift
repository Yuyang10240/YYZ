//
//  CollectionPrettyCell.swift
//  YYZB
//
//  Created by unicorn on 2017/5/4.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor:AnchorModel?{
        didSet{
            super.anchor=anchor
            //.所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
            
            
        }
    }
}
