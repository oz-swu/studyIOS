//
//  AnchorGroup.swift
//  studyIOS
//
//  Created by musou on 26/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {

    var data : [[String : NSObject]]? {
        didSet {
            guard let data = data else { return }
            
            for dict in data {
                anchors.append(AnchorModel(dict));
            }
        }
    };
    
    var tabName : String = "";
    
    var icon : String = "home_header_normal";
    
    lazy var anchors : [AnchorModel] = [AnchorModel]();
    
    init(tabName: String, icon: String? = nil) {
        super.init();
        
        self.tabName = tabName;
        
        if (icon != nil) {
            self.icon = icon!;
        }
    }
    
    init(dict : [String : NSObject]) {
        super.init();
        
        setValuesForKeys(dict);
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if (key == "data") {
            guard let data = value as? [[String : NSObject]] else {
                return;
            }
            
            for dict in data {
                anchors.append(AnchorModel(dict));
            }
        }
    }
    */
}

extension AnchorGroup {
    open func appendData(data: AnchorModel) {
        self.anchors.append(data);
    }
}
