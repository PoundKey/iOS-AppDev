//
//  ViewController.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-18.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let kDistanceMeters: CLLocationDistance = 500
    var locationManager = CLLocationManager()
    var userLocated = false
    var lastAnnotation: MKAnnotation!
    
    func centerToUsersLocation() {
        let center = mapView.userLocation.coordinate
        let zoomRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(center, kDistanceMeters, kDistanceMeters)

        mapView.setRegion(zoomRegion, animated: true)
   
    }
    
    func addNewPin() {
        if lastAnnotation != nil { mapView.removeAnnotation(lastAnnotation) }
        let footprint = FootPrintAnnotation(coordinate: mapView.centerCoordinate, title: "Untitled", subtitle: "Uncategorized")
        mapView.addAnnotation(footprint)
        lastAnnotation = footprint
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self;
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    

    @IBAction func dropPin(sender: AnyObject) {
        addNewPin()
    }

    

    @IBAction func zoomLoc(sender: AnyObject) {
        centerToUsersLocation()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "entry") {
            let controller = segue.destinationViewController as! EntryViewController
            let annotation = sender as! FootPrintAnnotation
            controller.selectedAnnotation = annotation
        }
    }
    
    @IBAction func unwindFromEntryView(segue: UIStoryboardSegue) {
        if let lastAnnotation = lastAnnotation {
            mapView.removeAnnotation(lastAnnotation)
        }
        
        lastAnnotation = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        status != .NotDetermined ? mapView.showsUserLocation = true : print("Authorization to use location data denied")
    }
}

extension MainViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let subtitle = annotation.subtitle! else { return nil }
        
        if (annotation is FootPrintAnnotation) {
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(subtitle) {
                return annotationView
            } else {
                
                let currentAnnotation = annotation as! FootPrintAnnotation
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: subtitle)
                
                let imageName: String!
                switch subtitle {
                case "Uncategorized":
                    imageName = "uncat"
                case "Visited":
                    imageName = "visit"
                case "Bus Stop":
                    imageName = "bus"
                case "Restaurant":
                    imageName = "restaurant"
                case "Public Library":
                    imageName = "library"
                case "Mall":
                    imageName = "mall"
                default:
                    imageName = "uncat"
                }
                
                annotationView.image = UIImage(named: imageName)
                annotationView.enabled = true
                annotationView.canShowCallout = true
                let detailDisclosure = UIButton(type: UIButtonType.DetailDisclosure)
                detailDisclosure.tintColor = UIColor(red:0, green:0.36, blue:0.66, alpha:1)
                annotationView.rightCalloutAccessoryView = detailDisclosure
                
                if currentAnnotation.title == "Untitled" {
                    annotationView.draggable = true
                }
                
                return annotationView
            }
        }
        return nil
        
    }
    
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        
        for annotationView in views {
            if (annotationView.annotation is FootPrintAnnotation) {
                annotationView.transform = CGAffineTransformMakeTranslation(0, -500)
                UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: {
                    annotationView.transform = CGAffineTransformMakeTranslation(0, 0)
                    }, completion: nil)
            }
        }
    }
    
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation =  annotationView.annotation as? FootPrintAnnotation {
            performSegueWithIdentifier("entry", sender: annotation)
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == .Ending {
            view.dragState = .None
        }
    }
}


