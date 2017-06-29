//
//  CycleModel.swift
//  studyIOS
//
//  Created by musou on 28/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    var id : Int = 0;
    var title : String = "";
    var pic_url : String = "";
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(room);
        }
    };
    var anchor : AnchorModel?
    
    init(_ dict : [String : NSObject]) {
        super.init();
        
        setValuesForKeys(dict);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
