//
//  ViewController.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-18.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class MainViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var selectedFootPrint: FootPrint?
    
    let kDistanceMeters: CLLocationDistance = 640
    var locationManager = CLLocationManager()
    var userLocated = false
    var lastAnnotation: MKAnnotation?
    
    func centerToUsersLocation() {
        let center = mapView.userLocation.coordinate
        zoomIn(center, distance: kDistanceMeters)
    }
    
    func zoomIn(center: CLLocationCoordinate2D, distance: CLLocationDistance) {
        let zoomRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(center, distance, distance)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    func addNewPin() {
        if let last = lastAnnotation {
            mapView.removeAnnotation(last)
        }
        let annotation = FootPrintAnnotation(coordinate: mapView.centerCoordinate, title: "Untitled", subtitle: "Uncategorized")
        mapView.addAnnotation(annotation)
        lastAnnotation = annotation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
        populateMap()
    }
    

    @IBAction func dropPin(sender: AnyObject) {
        addNewPin()
    }

    

    @IBAction func zoomLoc(sender: AnyObject) {
        centerToUsersLocation()
    }
    
    func populateMap() {
        mapView.removeAnnotations(mapView.annotations)
        let res = try! Realm().objects(FootPrint)
        
        for footprint in res {
            let coord = CLLocationCoordinate2D(latitude: footprint.latitude, longitude: footprint.longitude)
            let annotation = FootPrintAnnotation(coordinate: coord, title: footprint.name,
                                                 subtitle: footprint.category.name, footPrint: footprint)
            mapView.addAnnotation(annotation)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "entry") {
            let controller = segue.destinationViewController as! EntryViewController
            let annotation = sender as! FootPrintAnnotation
            controller.selectedAnnotation = annotation
        }
    }
    
    @IBAction func unwindFromEntryView(segue: UIStoryboardSegue) {
        if let last = lastAnnotation {
            mapView.removeAnnotation(last)
            lastAnnotation = nil
        }
        
        if segue.identifier! == "saveEntry" {
            let entryController = segue.sourceViewController as! EntryViewController
            if let footprint = entryController.selectedFootPrint {
                let coord = CLLocationCoordinate2D(latitude: footprint.latitude, longitude: footprint.longitude)
                let annotation = FootPrintAnnotation(coordinate: coord, title: footprint.name,
                    subtitle: footprint.category.name, footPrint: footprint)
                mapView.addAnnotation(annotation)
                selectedFootPrint = footprint
            }
        }
    }
    
    @IBAction func unwindFromLogView(segue: UIStoryboardSegue) {
        if let last = lastAnnotation {
            mapView.removeAnnotation(last)
            lastAnnotation = nil
        }
        
        if let footprint = selectedFootPrint {
            let center = CLLocationCoordinate2D(latitude: footprint.latitude, longitude: footprint.longitude)
            zoomIn(center, distance: 120)
        }
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
                
                let imageName = getIconImage(subtitle)
                
                annotationView.image = UIImage(named: imageName)
                annotationView.enabled = true
                annotationView.canShowCallout = true
                let detailDisclosure = UIButton(type: UIButtonType.DetailDisclosure)
                detailDisclosure.tintColor = UIColor(red:0, green:0.36, blue:0.66, alpha:1)
                annotationView.rightCalloutAccessoryView = detailDisclosure
                
                if currentAnnotation.title == "Untitled" {
                    annotationView.draggable = true
                }
                //annotationView.draggable = true
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
            lastAnnotation = annotation
            performSegueWithIdentifier("entry", sender: annotation)
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == .Ending {
            view.dragState = .None
        }
    }
}


