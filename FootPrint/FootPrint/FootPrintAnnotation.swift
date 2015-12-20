//
//  FootPrintAnnotation.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-19.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit
import MapKit

class FootPrintAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
