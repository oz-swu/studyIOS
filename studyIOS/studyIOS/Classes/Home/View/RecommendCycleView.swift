//
//  RecommendCycleView.swift
//  studyIOS
//
//  Created by musou on 28/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

private let kCycleCellId = "kCycleCellId";

class RecommendCycleView: UIView {
    
    var data : [CycleModel]? {
        didSet {
            collectionView.reloadData();
            pageControl.numberOfPages = data?.count ?? 0;
        }
    };
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        autoresizingMask = [];
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellId);
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size;
    }
}

extension RecommendCycleView {
    class func instance() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0;
//        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath);
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue;
        
        return cell
    }
}
