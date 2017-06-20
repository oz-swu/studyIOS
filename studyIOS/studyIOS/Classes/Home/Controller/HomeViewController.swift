//
//  HomeViewController.swift
//  studyIOS
//
//  Created by musou on 16/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40;

class HomeViewController: UIViewController {

    open lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH);
        let titles = ["推荐", "游戏", "娱乐", "趣玩"];
        let titleView = PageTitleView(frame: titleFrame, titles: titles);
        titleView.delegate = self;
        
        return titleView;
    }();
    
    open lazy var pageContentView : PageContentView = {[weak self] in
        let contentY = kStatusBarH + kNavigationBarH + kTitleViewH;
        let contentFrame = CGRect(x: 0, y: contentY, width: kScreenW, height: kScreenH - contentY);
        
        var childVcs = [UIViewController]();
        for _ in 0..<4 {
            let vc = UIViewController();
            vc.view.backgroundColor = UIColor(r: arc4random_float(255), g: arc4random_float(255), b: arc4random_float(255));
            childVcs.append(vc);
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self);
        return contentView;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI();
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

// MARK: init UI
extension HomeViewController {
    
    open func setupUI() {
        automaticallyAdjustsScrollViewInsets = false;
        
        setupNavigationBar();
        
        view.addSubview(pageTitleView);
        
        view.addSubview(pageContentView);
    }
    
    private func setupNavigationBar() {
        // left item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo");
        
        // right items
        let size = CGSize(width: 40, height: 40);
        let historyItem = UIBarButtonItem(imageName: "image_history", highImageName: "image_history_click", size: size);
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size);
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size);
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem];
        
    }
}

extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index);
    }
}

