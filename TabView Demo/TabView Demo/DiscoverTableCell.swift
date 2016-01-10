//
//  DiscoverTableCell.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-09.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class DiscoverTableCell: UITableViewCell {
    
    // tableView.registerNib(UINib(nibName: "DiscoverTableCell", bundle:nil), forCellReuseIdentifier: "dcell")
    @IBOutlet var discoverImage: UIImageView!
    
    @IBOutlet var discoverTitle: UILabel!
    
    @IBOutlet var discoverContents: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDiscoverTableCell(options: [String: String]){
        discoverImage.image = UIImage(named: options["Img"]!)
        discoverTitle.text = options["Title"]!
        discoverContents.text = options["Contents"]!
    }
}
