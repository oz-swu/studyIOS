//
//  Common.swift
//  studyIOS
//
//  Created by musou on 18/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

let kStatusBarH : CGFloat = 20;
let kNavigationBarH : CGFloat = 44;

let kScreenW = UIScreen.main.bounds.width;
let kScreenH = UIScreen.main.bounds.height;

public func arc4random_float(_ u: UInt32) -> CGFloat {
    return CGFloat(arc4random_uniform(u));
}
