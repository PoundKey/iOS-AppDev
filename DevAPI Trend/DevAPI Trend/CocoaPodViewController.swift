//
//  CocoaPodViewController.swift
//  DevAPI Trend
//
//  Created by Chang Tong Xue on 2016-01-19.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit
import Alamofire
import HTMLReader

class CocoaPodViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var trendDaily = [APIModel]()
    var trendOverall = [APIModel]()
   
    var responseString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CocoaPods"
        initViewList()
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
    
    func fetchHTML() {
        let url = "https://trendingcocoapods.github.io"
        Alamofire.request(.GET, url).responseString { res in
            switch res.result {
            case .Success(let value):
                 self.responseString = value
            case .Failure:
                print("No Internet Connection Error: DX21")
            }
        }
    }
    
    func parseHTML() {
        if let res = responseString {
            
        }
    }
    
    func refreshView() {
        
    }

}

extension CocoaPodViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return trendDaily.count
        case 1:
            return trendOverall.count
        default:
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! APICell
        
        let APIitem: APIModel
        switch indexPath.section {
        case 0:
            APIitem = trendDaily[indexPath.row]
        case 1:
            APIitem = trendOverall[indexPath.row]
        default:
            APIitem = APIModel(title: "nil", detail: "null", url: "undefined", star: 0)
        }
        cell.title.text = APIitem.title
        cell.detail.text = APIitem.detail
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("selected: \(indexPath.row)")
    }
}


