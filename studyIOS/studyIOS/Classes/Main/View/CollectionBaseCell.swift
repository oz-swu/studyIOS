//
//  CollectionBaseCell.swift
//  studyIOS
//
//  Created by musou on 27/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var roomImg: UIImageView!
    
    @IBOutlet weak var anchorName: UILabel!
    
    @IBOutlet weak var onlineNum: UIButton!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            
            anchorName.text = anchor.nickname;
            onlineNum.setTitle(anchor.online, for: .normal);
            
            let imgUrl : URL?;
            if (anchor.isVertical == "1") {
                imgUrl = URL(string: anchor.vertical_src);
            } else {
                imgUrl = URL(string: anchor.room_src)
            }
            
            roomImg.kf.setImage(with: imgUrl);
        }
    }

}
