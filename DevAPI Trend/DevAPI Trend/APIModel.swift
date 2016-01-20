//
//  APIModel.swift
//  DevAPI Trend
//
//  Created by Chang Tong Xue on 2016-01-19.
//  Copyright © 2016 DX. All rights reserved.
//

import Foundation

class APIModel {
    
    let title: String
    let detail: String
    let url: String
    let star: Int
    
    init(title: String, detail: String, url: String, star: Int) {
        self.title  = title
        self.detail = detail
        self.url    = url
        self.star   = star
    }
    
    func describe() {
        print("Title: \(self.title), Star: \(star), Detail: \(detail), GitHub: \(url)")
    }
}
