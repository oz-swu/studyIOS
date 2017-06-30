//
//  RecommendCategoryView.swift
//  studyIOS
//
//  Created by musou on 30/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

private let kCategoryCellId : String = "kCategoryCellId";

class RecommendCategoryView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var data : [CategoryModel]? {
        didSet {
            collectionView.reloadData();
        }
    };
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        autoresizingMask = [];
        
        collectionView.register(UINib(nibName: "CollectionCategoryCell", bundle: nil), forCellWithReuseIdentifier: kCategoryCellId);
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    }
    
}

extension RecommendCategoryView {
    class func instance() -> RecommendCategoryView {
        return Bundle.main.loadNibNamed("RecommendCategoryView", owner: nil, options: nil)?.first as! RecommendCategoryView
    }
}

extension RecommendCategoryView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCategoryCellId, for: indexPath) as! CollectionCategoryCell;
        
        cell.data = data![indexPath.item];
        
        return cell;
    }
}

extension RecommendCategoryView : UICollectionViewDelegate {
    
}
