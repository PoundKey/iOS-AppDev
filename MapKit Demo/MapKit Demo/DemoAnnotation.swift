//
//  DemoAnnotation.swift
//  MapKit Demo
//
//  Created by Chang Tong Xue on 2015-12-18.
//  Copyright © 2015 DX. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class DemoAnnotation : NSObject, MKAnnotation {
    var title: String?
    var locationName: String?
    var discipline: String
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        super.init()
        
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey): self.subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    func pinColor() -> UIColor {
        switch discipline {
        case "Sculpture", "Plaque":
            return UIColor.purpleColor()
        case "Mural", "Monument":
            return UIColor.redColor()
        default:
            return UIColor.greenColor()
        }
    }
    
    class func fromJSON(json: [JSONValue]) -> DemoAnnotation? {
        var title: String
        if let titleOrNil = json[16].string {
            title = titleOrNil
        } else {
            title = ""
        }
        let locationName = json[12].string
        let discipline = json[15].string
        
        let latitude = (json[18].string! as NSString).doubleValue
        let longitude = (json[19].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        return DemoAnnotation(title: title, locationName: locationName!, discipline: discipline!, coordinate: coordinate)
    }
}
