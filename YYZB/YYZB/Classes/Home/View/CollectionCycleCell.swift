//
//  CollectionCycleCell.swift
//  YYZB
//
//  Created by unicorn on 2017/5/6.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit
import  Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    // MARK: 定义模型属性
    var cycleModel : CycleModel?{
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }

    }
}
