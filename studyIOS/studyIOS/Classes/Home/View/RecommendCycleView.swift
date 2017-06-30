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
    
    var cycleTimer : Timer?;
    
    var data : [CycleModel]? {
        didSet {
            collectionView.reloadData();
            dataCount = data?.count ?? 0;
            pageControl.numberOfPages = dataCount;
            let indexPath = IndexPath(item: dataCount * Int(5000 / dataCount), section: 0);
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false);
            
            removeCycleTimer();
            addCycleTimer();
        }
    };
    var dataCount : Int = 0;
    
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
        return (dataCount == 0) ? 0 : (dataCount + 10000);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cycleModel = data![indexPath.item % dataCount];
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CollectionCycleCell;
        
        cell.imageView.kf.setImage(with: URL(string: cycleModel.pic_url));
        
        return cell
    }
}

extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x + scrollView.bounds.width * 0.5;
        pageControl.currentPage = Int(x / scrollView.bounds.width) % (dataCount);
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer();
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer();
    }
}

extension RecommendCycleView {
    func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true);
        RunLoop.main.add(cycleTimer!, forMode: .commonModes);
    }
    
    func removeCycleTimer() {
        cycleTimer?.invalidate();
        cycleTimer = nil;
    }
    
    @objc private func scrollToNext() {
        let currentX = collectionView.contentOffset.x;
        let nextX = currentX + collectionView.bounds.width;
        
        collectionView.setContentOffset(CGPoint(x: nextX, y: 0), animated: true);
    }
}
