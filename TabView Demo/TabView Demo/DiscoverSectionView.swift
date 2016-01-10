//
//  DiscoverSectionView.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-09.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class DiscoverSectionView: UIView {
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
}

extension DiscoverSectionView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        
    }

}
