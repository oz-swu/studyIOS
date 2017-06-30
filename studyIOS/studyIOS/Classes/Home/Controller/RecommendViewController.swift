//
//  RecommendViewController.swift
//  studyIOS
//
//  Created by musou on 21/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10;
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2;
private let kNormalItemH : CGFloat = kItemW * 3 / 4;
private let kPrettyItemH : CGFloat = kItemW * 4 / 3;
private let kHeaderH : CGFloat = 50;

private let kCycleViewH : CGFloat = kScreenW * 3 / 8;
private let kCategoryViewH : CGFloat = 90;

private let kNormalCellId = "kNormalCellId";
private let kPrettyCellId = "kPrettyCellId";
private let kHeaderId = "kHeaderId";

class RecommendViewController: UIViewController {

    lazy var recommendViewModel : RecommendViewModel = RecommendViewModel();
    
    lazy var collectionView : UICollectionView = {[weak self] in
        let viewLayout = UICollectionViewFlowLayout();
        viewLayout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH);
//        viewLayout.itemSize = CGSize(width: kItemW, height: kNormalItemH);
        viewLayout.minimumLineSpacing = 0;
        viewLayout.minimumInteritemSpacing = kItemMargin;
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin);
        
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: viewLayout);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth];
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId);
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId);
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderId)
        collectionView.backgroundColor = .white;
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kCategoryViewH, left: 0, bottom: 0, right: 0);
        
        return collectionView;
    }();
    
    lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.instance();
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH-kCategoryViewH, width: kScreenW, height: kCycleViewH);
        return cycleView;
    }();
    
    lazy var categoryView : RecommendCategoryView = {
        let categoryView = RecommendCategoryView.instance();
        categoryView.frame = CGRect(x: 0, y: -kCategoryViewH, width: kScreenW, height: kCategoryViewH)
        return categoryView;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI();

        loadData();
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

// MARK: - setup UI
extension RecommendViewController {
    func setupUI() {
        view.addSubview(collectionView);
        
        collectionView.addSubview(cycleView);
        collectionView.addSubview(categoryView);
    }
}

// MRAK: - load data
extension RecommendViewController {
    func loadData() {
        recommendViewModel.requestData {
            self.collectionView.reloadData();
            
            self.cycleView.data = self.recommendViewModel.cycleData;
        }

        recommendViewModel.requestCategory {
            self.categoryView.data = self.recommendViewModel.categoryData;
        }
    }
}

// MRAK: - data source
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroups.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendViewModel.anchorGroups[section].anchors.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderId, for: indexPath) as! CollectionHeaderView;

        header.group = recommendViewModel.anchorGroups[indexPath.section];
        
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommendViewModel.anchorGroups[indexPath.section];
        let anchor = group.anchors[indexPath.item];
        
        var cellId = kNormalCellId;
        if (anchor.isVertical == "1") {
            cellId = kPrettyCellId;
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionBaseCell;
        
        cell.anchor = anchor;
        
        return cell;
    }
}

// MRA: - delegate flow layout
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (recommendViewModel.anchorGroups[indexPath.section].anchors[indexPath.item].isVertical == "1") {
//        if (indexPath.section == 1) {
            return CGSize(width: kItemW, height: kPrettyItemH);
        }
        
        return CGSize(width: kItemW, height: kNormalItemH);
    }
}
