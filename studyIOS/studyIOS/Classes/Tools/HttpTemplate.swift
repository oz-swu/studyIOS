//
//  HttpTemplate.swift
//  AlamofireTest
//
//  Created by musou on 26/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class HttpTemplate {
    
    class func request (url: String, method: MethodType, parameters: [String : NSString]? = nil, callback: @escaping (_ result: AnyObject) -> ()) {
        
        let method = (method == .get) ? HTTPMethod.get : HTTPMethod.post;
        
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            guard let resultData = response.result.value else {
                print(response.result.error!);
                return;
            }
            
            callback(resultData as AnyObject);
        }
    }
    
}
