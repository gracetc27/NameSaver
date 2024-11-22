//
//  LocationFetcher.swift
//  NameSaver
//
//  Created by Grace couch on 20/11/2024.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {

    static let shared = LocationFetcher()

    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    private override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
