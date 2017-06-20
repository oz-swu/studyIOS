//
//  MainViewController.swift
//  studyIOS
//
//  Created by musou on 16/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addTabbarItems(storyName: "Home");
        addTabbarItems(storyName: "Live");
        addTabbarItems(storyName: "Follow");
        addTabbarItems(storyName: "Profile");
        
    }

    private func addTabbarItems(storyName: String) {
        let vc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!;
        
        addChildViewController(vc);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
