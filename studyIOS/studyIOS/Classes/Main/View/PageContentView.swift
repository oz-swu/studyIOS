//
//  PageContentView.swift
//  studyIOS
//
//  Created by musou on 18/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        
        return collectionView;
    }();
    
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

extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width;
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false);
    }
}
