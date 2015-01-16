//
//  ViewController.swift
//  Using Maps
//
//  Created by Yosemite on 1/15/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // +--- Determine User location by Core location ---+
        // +------------------------------------------------+
        
        // Step1. Manually create delegate for manager
        manager.delegate = self
        // Step2. Select accuracy
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // Step3. Request authorization: whenInUse or always
        manager.requestWhenInUseAuthorization()
        // Step4. Updating location
        manager.startUpdatingLocation()
        
        
        // +--- Show the region on map ---+
        // +------------------------------+
        
        // Step1. Define map parameters
        // - 1.1 Define position
        var latitude:CLLocationDegrees = 40.748712
        var longitude:CLLocationDegrees = -73.985691
        // - 1.2 Define zoom level: bigger means more zoom out
        var latDelta:CLLocationDegrees = 0.02
        var lonDelta:CLLocationDegrees = 0.01
        
        // Step2. Define the target region
        // - 2.1 Create a span
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        // - 2.2 Create a location
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        // - 2.3 Create a region with previus created location and span
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        // Step3. Show the region on the map
        mapView.setRegion(region, animated: true)
        

        // +--- Add annotation OBJECT to map ---+
        // +------------------------------------+
        
        // Step1. Create annotation for the location
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        // Step2. Set annotation properties
        annotation.title = "Empire State Building"
        annotation.subtitle = "Test for map usage"
        
        // Step3. Add annotation to the map
        mapView.addAnnotation(annotation)
        
        
        // +--- User add their own annotation by long pressing on the map ---+
        // +-----------------------------------------------------------------+
        
        // Step1. Construct target gesture - Long Pressed
        // ":" means func has parameters, w/o ":" means func has no parameters
        var longPressed = UILongPressGestureRecognizer(target: self, action: "userAction:")
        longPressed.minimumPressDuration = 2.0
        
        // Step3. Add target guesture to the map for recognition
        mapView.addGestureRecognizer(longPressed)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // +--- User add their own annotation by long pressing on the map ---+
    // +-----------------------------------------------------------------+

    // Step2. Create gesture calling function
    func userAction(gestureRecognizer:UIGestureRecognizer) {
        // 2.1 - Obtain touchpoint from the map
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        
        // 2.2 - Convert touchpoint to Coordinate/location
        var userCoordinate:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        // 2.3 - Create annotation for the location
        var userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = userCoordinate
        
        // 2.4 - Set annotation properties
        userAnnotation.title = "User touch here"
        userAnnotation.subtitle = "User..."
        
        // 2.5 - Add annotation to the map
        mapView.addAnnotation(userAnnotation)
    }
    
    // +--- Determine User location by Core location ---+
    // +------------------------------------------------+
    
    // Step4.1 - Function will run every time the location is updated
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation

        // Show the region on map
        var latDelta:CLLocationDegrees = 0.02
        var lonDelta:CLLocationDegrees = 0.02
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)

        var location:CLLocationCoordinate2D = userLocation.coordinate
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
    }
    
    // Step4.2 - Function will run if locaiton update failed such as user reject location request or no signal...
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }

}

