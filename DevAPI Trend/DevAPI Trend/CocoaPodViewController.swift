//
//  CocoaPodViewController.swift
//  DevAPI Trend
//
//  Created by Chang Tong Xue on 2016-01-19.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit
import Alamofire

class CocoaPodViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewList = [APIModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CocoaPods"
        initViewList()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
    }
    
    func initViewList() {
        fetchHTML()
        parseHTML()
    }
    
    func fetchHTML() -> String {
        
        return ""
    }
    
    func parseHTML() {
        
    }
    
    

}

extension CocoaPodViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! APICell
        cell.title.text = "Title: \(indexPath.row)"
        cell.detail.text = "Description of the APICell."
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected: \(indexPath.row)")
    }
}


