//
//  LocationManager.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/8/23.
//

import CoreLocation

class LocationManager : NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    static let shared = LocationManager()
    
    override init(){
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation()
        
    }
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("NOT DETERMINED")
        case .restricted:
            print("RESTRICTED")
        case .denied:
            print("DENIED")
        case .authorizedAlways:
            print("AUTH ALWAYS")
        case .authorizedWhenInUse:
            print("auth when in use")
        @unknown default:
            break
        }
        
        
    }
    func locationManager(_ manager : CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location
    }
}
