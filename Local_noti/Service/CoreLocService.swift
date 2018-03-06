//
//  CoreLocService.swift
//  Local_noti
//
//  Created by Tanin on 06/03/2018.
//  Copyright © 2018 landtanin. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocService: NSObject {
    
    // singleton
    private override init() {}
    static let instance = CoreLocService()
 
    let locationManager = CLLocationManager()
    var setRegionForFirstLoc = true
    
    func authorize() {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
    }
    
    func updateLocation() {
        setRegionForFirstLoc = true
        locationManager.startUpdatingLocation()
    }
    
}

extension CoreLocService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got location")
        
        // the way we will simulate this is to use the location simulation in the debugging area
        // to go to other city and then come back to the first location afterward to trigger the "when I return" notification
        guard let currentLocation = locations.first, setRegionForFirstLoc else { return }
        setRegionForFirstLoc = false
        
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        
        // when the location is updated, the region is started to being monitored
        manager.startMonitoring(for: region)
        
    }
    
    // we want to get notify when user enter the region
    // here, instead of using user notification like the time and date case, we're gonna use the internal notification centre instead
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("DID ENTER REGION VIA CoreLocation")
        
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
        
    }
    
    
    
}
