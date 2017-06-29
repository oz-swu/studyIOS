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
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId);
        
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
        
        print(indexPath.section, indexPath.row, indexPath.item);
        let cycleModel = data![indexPath.item];
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CollectionCycleCell;
        
        cell.imageView.kf.setImage(with: URL(string: cycleModel.pic_url));
        
        return cell
    }
}

extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x;
        pageControl.currentPage = Int(x / scrollView.bounds.width);
    }
}
