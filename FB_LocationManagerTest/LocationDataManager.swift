//
//  LocationDataManager.swift
//  LocationManagerTest
//
//  Created by Axel Le Pennec on 09/10/2022.
//

import CoreLocation
import Foundation

class LocationDataManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        locationManager.activityType = .automotiveNavigation // controlled by the Picker
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // controlled by the Picker
        locationManager.pausesLocationUpdatesAutomatically = false // controlled by the Toggle
        locationManager.distanceFilter = kCLDistanceFilterNone // controlled by the Picker
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        
        super.init()
        locationManager.delegate = self
    }
    
    @Published public var pausesLocationUpdatesAutomatically: Bool = false {
        didSet {
            locationManager.pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically
        }
    }
    
    @Published public var activityType: CLActivityType = .automotiveNavigation {
        didSet {
            locationManager.activityType = activityType
        }
    }
    
    @Published public var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBestForNavigation {
        didSet {
            locationManager.desiredAccuracy = desiredAccuracy
        }
    }
    
    @Published public var distanceFilter: CLLocationDistance = kCLDistanceFilterNone {
        didSet {
            locationManager.distanceFilter = distanceFilter
        }
    }
    
    @Published public var allLocations: [CLLocation] = []
    @Published public var messages: [String] = []
    
    @Published public var isUpdating: Bool = false
    func start() {
        locationManager.requestWhenInUseAuthorization()
        
        allLocations = []
        messages = []
        locationManager.startUpdatingLocation()
        isUpdating = true
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
        isUpdating = false
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(manager.authorizationStatus.rawValue)
        print(manager.accuracyAuthorization.rawValue)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let last = locations.last {
            if allLocations.count == 20 {
                allLocations.removeLast()
            }
            
            allLocations.insert(last, at: 0)
        }
    }
    
    public func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        let message: String = "\(Date.now.formatted(date: .numeric, time: .standard)) \(#function)."
        messages.insert(message, at: 0)
    }
    
    public func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        let message: String = "\(Date.now.formatted(date: .numeric, time: .standard)) \(#function)."
        messages.insert(message, at: 0)
    }
}
