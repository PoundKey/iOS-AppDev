//
//  PhotoViewController.swift
//  CarbonKit Demo
//
//  Created by Chang Tong Xue on 2016-01-08.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var refresh: CarbonSwipeRefresh = CarbonSwipeRefresh()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh = CarbonSwipeRefresh(scrollView: self.collectionView)
        
        refresh.setMarginTop(0)
        refresh.colors = [UIColor.blueColor(), UIColor.redColor(), UIColor.orangeColor(), UIColor.greenColor()]
        self.view.addSubview(refresh)
        refresh.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
    }
    
    func refresh(sender: AnyObject) {
        NSLog("REFRESH")
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.refresh.endRefreshing()
        }
    }
    
    func endRefreshing() {
        refresh.endRefreshing()
    }
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }
    
}