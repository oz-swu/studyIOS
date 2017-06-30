//
//  RecommendViewModel.swift
//  studyIOS
//
//  Created by musou on 26/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

private let kShortName = "game";

class RecommendViewModel {

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]();
    
    lazy var cycleData : [CycleModel] = [CycleModel]();
    
    lazy var categoryData : [CategoryModel] = [CategoryModel]();
}

// MARK: - sent request
extension RecommendViewModel {
    func requestCategory(callback: @escaping () -> ()) {
        HttpTemplate.request(url: "https://m.douyu.com/category?type=", method: .get) { (result) in
//            print(result);
            
            var hotGameId : String = "hotGameId";
            
            guard result is [String : NSObject] else {
                print("no category data");
                return;
            }
            
            guard let cate1 = result["cate1Info"] as? [[String : NSObject]] else {
                print("no cate1 data");
                return;
            }
            
            guard let cate2 = result["cate2Info"] as? [[String : NSObject]] else {
                print("no cate2 data");
                return;
            }
            
            for cate in cate1 {
                guard let shortName = cate["shortName"] as? String else { return }
                if (shortName == kShortName) {
                    guard let cate1Id = cate["cate1Id"] as? String else { return }
                    hotGameId = cate1Id;
                }
            }
            
            for cate in cate2 {
                guard let cate1Id = cate["cate1Id"] as? String else { return }
                if (cate1Id == hotGameId) {
                    self.categoryData.append(CategoryModel(cate));
                }
            }
            
            callback();
        }
    }
    
    func requestData(callback: @escaping () -> ()) {
        HttpTemplate.request(url: "https://m.douyu.com/index/getHomeData", method: .get) { (result) in
//            print(result);
            
            guard result is [String : NSObject] else {
                print("no home data");
                return;
            }
            
            guard let cycleList = result["banner"] as? [[String : NSObject]] else {
                print("no banner data");
                return;
            }
            
            for cycle in cycleList {
                self.cycleData.append(CycleModel(cycle));
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
