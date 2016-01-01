//
//  DetailViewController.swift
//  UISearch Demo
//
//  Created by Chang Tong Xue on 2015-12-31.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    var selectedTeam: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = UIImage(named: selectedTeam.image)
        navigationItem.title = selectedTeam.name
    }
    
}
