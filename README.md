# Using-Maps
Show target region on the map
-----------------------------
* **Step 0. Add *"MKMapViewDelegate"* protocol**

        class ViewController: UIViewController, MKMapViewDelegate {...}
        
* **Step 1. Define map parameters**

        // Step1. Define map parameters
        // - 1.1 Define position
        var latitude:CLLocationDegrees = 40.748712
        var longitude:CLLocationDegrees = -73.985691
        // - 1.2 Define zoom level: bigger means more zoom out
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        
* **Step 2. Define target region**

        // Step2. Define the target region
        // - 2.1 Create a span
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        // - 2.2 Create a location
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        // - 2.3 Create a region with previus created location and span
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
* **Step 3. Show the region on the map**

        // Step3. Show the region on the map
        mapView.setRegion(region, animated: true)
        
Add/Select/Remove annotations on the map
--------------------------
* **Step 1. Create annotation for the location**

        // Step1. Create annotation for the location
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        
* **Step 2. Customize annotation properties**

        // Step2. Set annotation properties
        annotation.title = "Empire State Building"
        annotation.subtitle = "Test for map usage"
        
* **Step 3. Add annotation to the map**

        // Step3. Add annotation to the map
        mapView.addAnnotation(annotation)
        // Select annotation to show the popout
        myMap.selectAnnotation(annotation, animated: true)
        
* **Optional. Select/remove annotations on the map**

        var deselectedAnnotations = myMap.selectedAnnotations
        myMap.removeAnnotations(deselectedAnnotations)
        
Add guestures on the map
------------------------
Eg. Long press

* **Step 1. Construct target gesture**

        // Step1. Construct target gesture - Long Pressed
        // ":" means func has parameters, w/o ":" means func has no parameters
        var longPressed = UILongPressGestureRecognizer(target: self, action: "userAction:")
        longPressed.minimumPressDuration = 2.0
        
* **Step 2. Create gesture calling function**

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
        
* **Step 3. Add target guesture to the map for recognition**

        // Step3. Add target guesture to the map for recognition
        mapView.addGestureRecognizer(longPressed)
        
Track user current location
---------------------------
* **Step 0. Add necessary foundation work**

  1. Add *"CoreLocation.framework"*
  
  2. Add Key: *"NSLocationWhenInUseUsageDescription"*
  
  3. Add Key: *"NSLocationAlwaysUsageDescription"*
  
  4. Add *"CLLocationManagerDelegate"* protocal
  
          class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {...}  
  
* **Step 1. Mannual create delegate for locaiton manager**

        var manager = CLLocationManager()

        ...
        
        // Step1. Manually create delegate for manager
        manager.delegate = self
        
* **Step 2. Select location accuracy (wifi, LTE...)**

        // Step2. Select accuracy
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
* **Step 3. Select request authorization: whenInUse or always**

        // Step3. Request authorization: whenInUse or always
        manager.requestWhenInUseAuthorization()
        
* **Step 4. Update location (constantly updating by default)**

        // Step4. Updating location
        manager.startUpdatingLocation()
        // Optional to stop updating location once address is obtained
        manager.stopUpdatingLocation()
        
* **Step 5 Show user location on map by calling *"didUpdateLocations"*.** 

        // Step5.1 - Function will run every time the location is updated
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
        
        // Step5.2 - Function will run if locaiton update failed such as user reject location request or no signal...
        func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
            println(error)
        }
        
