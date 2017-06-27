//
//  RecommendViewModel.swift
//  studyIOS
//
//  Created by musou on 26/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class RecommendViewModel {

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]();
    
}

// MARK: - sent request
extension RecommendViewModel {
    func requestData(callback: @escaping () -> ()) {
        HttpTemplate.request(url: "https://m.douyu.com/index/getHomeData", method: .get) { (result) in
//            print(result);
            
            guard result is [String : NSObject] else {
                print("no home data");
                return;
            }
            
            guard let hotGroups = result["hotList"] as? [[String : NSObject]] else {
                print("no hotList data");
                return;
            };
            
            guard let liveList = result["liveList"] as? [[String : NSObject]] else {
                print("no liveList data");
                return;
            };
            
            guard let yzList = result["yzList"] as? [[String : NSObject]] else {
                print("no yzList data");
                return;
            };
            
            guard let mixGroups = result["mixList"] as? [[String : NSObject]] else {
                print("no mixList data");
                return;
            };
            
            for hot in hotGroups {
                self.anchorGroups.append(AnchorGroup(dict: hot));
            }
            
            let liveGroup = AnchorGroup(tabName: "正在直播", icon: "home_header_normal");
            for live in liveList {
                liveGroup.appendData(data: AnchorModel(live));
            }
            self.anchorGroups.append(liveGroup);
            
            let yzGroup = AnchorGroup(tabName: "颜值", icon: "home_header_phone");
            for yz in yzList {
                yzGroup.appendData(data: AnchorModel(yz));
            }
            self.anchorGroups.append(yzGroup);
            
            for mix in mixGroups {
                self.anchorGroups.append(AnchorGroup(dict: mix));
            }
            
//            for group in anchorGroups {
//                print(group.tabName);
//                for anchor in group.anchors {
//                    print(anchor.nickname, anchor.room_name, anchor.anchorCity, anchor.online)
//                }
//            }
            
            callback();
        }
    }
}
