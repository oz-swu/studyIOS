//
//  CollectionHeaderView.swift
//  studyIOS
//
//  Created by musou on 21/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : AnchorGroup? {
        didSet {
            guard let group = group else { return }
            
            if (group.icon.contains("http")) {
                iconImg.kf.setImage(with: URL(string: group.icon));
            } else {
                iconImg.image = UIImage(named: group.icon);
            }
            
            titleLabel.text = group.tabName;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
