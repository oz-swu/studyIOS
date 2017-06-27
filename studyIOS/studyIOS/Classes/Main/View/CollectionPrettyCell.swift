//
//  CollectionPrettyCell.swift
//  studyIOS
//
//  Created by musou on 23/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var anchorCity: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor;
            
            anchorCity.setTitle(anchor?.anchorCity, for: .normal);
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
