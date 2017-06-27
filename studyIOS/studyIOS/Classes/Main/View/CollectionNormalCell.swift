//
//  CollectionNormalCell.swift
//  studyIOS
//
//  Created by musou on 21/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {
    
    @IBOutlet weak var roomName: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor;
            
            roomName.text = anchor?.room_name;
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
