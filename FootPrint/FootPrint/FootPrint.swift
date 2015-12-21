//
//  FootPrint.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-19.
//  Copyright © 2015 DX. All rights reserved.
//

import Foundation
import RealmSwift

class FootPrint: Object {
    dynamic var name = ""
    dynamic var detail = ""
    dynamic var latitude = 0.0
    dynamic var longitude = 0.0
    dynamic var created = NSDate()
    dynamic var category: Category!
}
