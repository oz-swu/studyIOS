//
//  PageContentView.swift
//  studyIOS
//
//  Created by musou on 18/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, source: Int, target: Int);
}
private let ContentCellId = "ContentCellId";

class PageContentView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    open var childVcs : [UIViewController];
    open weak var parentViewController: UIViewController?;
    
    weak var delegate: PageContentViewDelegate?;
    open var doDelegate : Bool = true;
    
    open lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = (self?.bounds.size)!;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout);
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.isPagingEnabled = true;
        collectionView.bounces = false;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        
        return collectionView;
    }();
    
    open var startDragX : CGFloat = 0;
    
    // MRAK:- init
    init(frame: CGRect, childVcs: [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs;
        self.parentViewController = parentViewController;
        
        super.init(frame: frame);
        
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    
    open func setupUI() {
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc);
        }
        
        addSubview(collectionView);
        collectionView.frame = bounds;
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath);
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview();
        }
        
        let childVc = childVcs[indexPath.item];
     
        childVc.view.frame = cell.contentView.bounds;
        
        cell.contentView.addSubview(childVc.view);
        
        return cell;
    }
}

extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startDragX = scrollView.contentOffset.x;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (doDelegate) {
            var progress : CGFloat = 0;
            var sourceIndex : Int = 0;
            var targetIndex : Int = 0;
        
            let currentDragX = scrollView.contentOffset.x;
            let scrollViewW = scrollView.bounds.width;
        
            sourceIndex = Int(startDragX / scrollViewW);
        
            if (currentDragX > startDragX) {
                targetIndex = sourceIndex + 1;
                progress = currentDragX / scrollViewW - CGFloat(sourceIndex);
            } else if (currentDragX < startDragX) {
                targetIndex = sourceIndex - 1;
                progress = CGFloat(sourceIndex) - currentDragX / scrollViewW;
            } else {
                targetIndex = sourceIndex;
                progress = 0;
            }
        
            print("progress:", progress, " sourceIndex:", sourceIndex, " targetIndex:", targetIndex);
        
            delegate?.pageContentView(contentView: self, progress: progress, source: sourceIndex, target: targetIndex);
        }
    }
}

extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        doDelegate = false;
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width;
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false);
        doDelegate = true;
    }
}
