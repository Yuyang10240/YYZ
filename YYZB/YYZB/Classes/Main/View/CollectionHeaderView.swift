//
//  CollectionHeaderView.swift
//  YYZB
//
//  Created by unicorn on 2017/5/3.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var iconImageView: UIImageView!
    
    var group:AnchorGroup?{
        didSet{
            titleLabel.text=group?.tag_name
            iconImageView.image=UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
}
