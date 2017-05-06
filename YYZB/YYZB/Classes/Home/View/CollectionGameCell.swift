//
//  CollectionGameCell.swift
//  YYZB
//
//  Created by unicorn on 2017/5/6.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group:AnchorGroup?{
        didSet{
            titleLabel.text=group?.tag_name
            let iconURL=URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL,placeholder:UIImage(named: "home_more_btn"))
            
        }
    }
    
    

}
