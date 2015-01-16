//
//  ViewController.swift
//  Using Maps
//
//  Created by Yosemite on 1/15/15.
//  Copyright (c) 2015 Yosemite. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Step1. Define map parameters
        // - 1.1 Define position
        var latitude:CLLocationDegrees = 40.748712
        var longitude:CLLocationDegrees = -73.985691
        // - 1.2 Define zoom level: bigger means more zoom out
        var latDelta:CLLocationDegrees = 0.01
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

