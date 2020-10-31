/*
 *	LocationServiceManager.swift
 *	WAW
 *
 *	Created by Adham Alkhateeb on 20/09/2020.
 *	Copyright 2020 . All rights reserved.
 */

import CoreLocation

final class LocationServiceManager: NSObject {
    
    // MARK: - Type
    typealias PermissionDenied = () -> Void
    typealias LocationRetrieved = (CLLocation) -> Void
    
    
    // MARK: - Properties
    private let locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var permissionDenied: PermissionDenied?
    private var locationRetrieved: LocationRetrieved?
    
    
    // MARK: - Constructors
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
    }
    
    
    // MARK: - Exposed Methods
    func setup(permissionDenied: @escaping PermissionDenied, locationRetrieved: @escaping LocationRetrieved) {
        
        self.permissionDenied = permissionDenied
        self.locationRetrieved = locationRetrieved
        
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        requestLocationServiceWhenInUse()
        locationManager?.startUpdatingLocation()
    }
    
    // MARK: - Protected Methods
    private func requestLocationServiceWhenInUse() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager?.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            permissionDenied?()
            
        case .authorizedAlways, .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            
        @unknown default:
            break
        }
    }
    
    // MARK: - Overridden Methods
    
}

extension LocationServiceManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty {
            currentLocation = locations.first
            if let location = currentLocation {
                locationRetrieved?(location)
                locationManager?.stopUpdatingLocation()
            }
            
        } else {
            permissionDenied?()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if let location = currentLocation {
                locationRetrieved?(location)
                
            } else {
                locationManager?.startUpdatingLocation()
            }
        default:
            permissionDenied?()
        }
    }
}
