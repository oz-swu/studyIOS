//
//  CollectionCategoryCell.swift
//  studyIOS
//
//  Created by musou on 30/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class CollectionCategoryCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var data : CategoryModel? {
        didSet {
            guard let data = data else { return }
            
            image.kf.setImage(with: URL(string: data.icon));
            label.text = data.cate2Name;
        }
    }
}
