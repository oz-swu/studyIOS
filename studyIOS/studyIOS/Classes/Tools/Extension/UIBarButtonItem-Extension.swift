//
//  UIBarButtonItem-Extension.swift
//  studyIOS
//
//  Created by musou on 18/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton();
        btn.setImage(UIImage(named: imageName), for: .normal);
        btn.setImage(UIImage(named: highImageName), for: .highlighted);
        btn.frame = CGRect(origin: .zero, size: size);
        return UIBarButtonItem(customView: btn);
    }
    */
    
    convenience init(imageName: String, highImageName: String = "", size: CGSize = .zero) {
        let btn = UIButton();
        btn.setImage(UIImage(named: imageName), for: .normal);
        
        if (highImageName != "") {
            btn.setImage(UIImage(named: highImageName), for: .highlighted);
        }
        
        if (size == .zero) {
            btn.sizeToFit();
        } else {
            btn.frame = CGRect(origin: .zero, size: size);
        }
        
        self.init(customView: btn);
    }
    
}
