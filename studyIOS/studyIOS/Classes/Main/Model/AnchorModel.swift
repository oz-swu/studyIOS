//
//  AnchorModel.swift
//  studyIOS
//
//  Created by musou on 26/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    var room_id : String = "";
    
    var room_name : String = "";
    
    var nickname : String = "";
    
    var isVertical : String = "";
    
    var room_src : String = "";
    
    var vertical_src : String = "";
    
    var online : String = "";
    
    var anchorCity : String = "";
    
    init(_ dict : [String : NSObject]) {
        super.init();
        
        setValuesForKeys(dict);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override func setValue(_ value: Any?, forKey key: String) {
        if (key == "online") {
            online = stringConvertor(value);
        } else if (key == "room_id") {
            room_id = stringConvertor(value);
        } else {
            super.setValue(value, forKey: key);
        }
    }
}
