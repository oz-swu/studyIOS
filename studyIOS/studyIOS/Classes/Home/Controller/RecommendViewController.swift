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

private let kNormalCellId = "kNormalCellId";
private let kPrettyCellId = "kPrettyCellId";
private let kHeaderId = "kHeaderId";

class RecommendViewController: UIViewController {

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
        
        return collectionView;
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

// MARK: - setup UI
extension RecommendViewController {
    func setupUI() {
        view.addSubview(collectionView);
    }
}

// MRAK: - data source
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0) {
            return 8;
        } else {
            return 4;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderId, for: indexPath);
//        header.backgroundColor = UIColor.white;
        
        return header;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellId = kNormalCellId;
        if (indexPath.section == 1) {
            cellId = kPrettyCellId;
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath);
//        cell.backgroundColor = UIColor(r: arc4random_float(255), g: arc4random_float(255), b: arc4random_float(255));
        return cell;
    }
}

// MRA: - delegate flow layout
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 1) {
            return CGSize(width: kItemW, height: kPrettyItemH);
        }
        
        return CGSize(width: kItemW, height: kNormalItemH);
    }
}
