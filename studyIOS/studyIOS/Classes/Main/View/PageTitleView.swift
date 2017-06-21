//
//  PageTitleView.swift
//  studyIOS
//
//  Created by musou on 18/06/2017.
//  Copyright © 2017 musou. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

private let kScrollLineH : CGFloat = 2;
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85);
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0);

class PageTitleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    weak var delegate : PageTitleViewDelegate?;
    open var doDelegate : Bool = true;
    
    open var currentIndex : Int = 0;
    
    open var titles : [String];
    
    open lazy var titleLabels : [UILabel] = [UILabel]();
    
    open lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView();
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        scrollView.bounces = false;
        return scrollView;
    }();
    
    open lazy var scrollLine : UIView = {
        let scrollLine = UIView();
        scrollLine.backgroundColor = UIColor.orange;
        return scrollLine;
    }();
    
    // MRAK:- customization init func
    init(frame: CGRect, titles: [String]) {
        self.titles = titles;
        
        super.init(frame: frame);
        
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: setup UI
extension PageTitleView {
    
    open func setupUI() {
        addSubview(scrollView);
        scrollView.frame = bounds;
        
        setupTitleLabels();
        
        setupBottomLineAndScrollLine();
    }
    
    private func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count);
        let labelH : CGFloat = frame.height - kScrollLineH;
        let labelY : CGFloat = 0;
        
        for (index, title) in titles.enumerated() {
            let label = UILabel();
            label.text = title;
            label.tag = index;
            label.font = UIFont.systemFont(ofSize: 16);
            label.textColor = UIColor.darkGray;
            label.textAlignment = .center;
            
            let labelX : CGFloat = labelW * CGFloat(index);
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH);
            
            scrollView.addSubview(label);
            titleLabels.append(label);
            
            label.isUserInteractionEnabled = true;
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)));
            label.addGestureRecognizer(tapGes);
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange;
        scrollView.addSubview(scrollLine);
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH);
        
        let bottomLine = UIView();
        bottomLine.backgroundColor = UIColor.lightGray;
        let lineH : CGFloat = 0.5;
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH);
        addSubview(bottomLine);
    }
}

// MARK: listening label click
extension PageTitleView {
    @objc open func titleLabelClick(tapGes: UITapGestureRecognizer) {
        if (doDelegate) {
            guard let tapLabel = tapGes.view as? UILabel else { return };
        
            if (tapLabel.tag == currentIndex) {
                return
            }
        
            let preLabel = titleLabels[currentIndex];
        
            currentIndex = tapLabel.tag;
        
            preLabel.textColor = UIColor.darkGray;
            tapLabel.textColor = UIColor.orange;
        
            let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width;
        
            UIView.animate(withDuration: 0.15, animations: {
                self.scrollLine.frame.origin.x = scrollLineX;
            })
        
            delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex);
        }
    }
}

// MARK: move scroll line
extension PageTitleView {
    func moveScrollLine(progress: CGFloat, source: Int, target: Int) {
        doDelegate = false;
        
        let sourceLabel = titleLabels[source];
        let targetLabel = titleLabels[target];
        
        let offsetX = (targetLabel.frame.origin.x - sourceLabel.frame.origin.x) * progress;
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + offsetX;
        
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2);
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress);
        
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress);
        
        currentIndex = target;
        
        doDelegate = true;
    }
}
