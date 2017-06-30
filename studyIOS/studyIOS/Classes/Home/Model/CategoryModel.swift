//
//  CategoryModel.swift
//  studyIOS
//
//  Created by musou on 30/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {

    var cate1Id : String = "";
    var cate2Id : String = "";
    var cate2Name : String = "";
    var shortName : String = "";
    var pic : String = "";
    var icon : String = "";
    var smallIcon : String = "";
    var count : Int = 0;
    
    init(_ dict : [String : NSObject]) {
        super.init();
        
        setValuesForKeys(dict);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
