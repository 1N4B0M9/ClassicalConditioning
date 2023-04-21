//
//  LocationManager.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/8/23.
//

import CoreLocation
import MapKit

/**
 A class that is used to get the user's location
 */
class LocationManager : NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var region = MKCoordinateRegion()
  //  @State private var region = MKCoordinateRegion(
        // center: CLLocationCoordinate2D(latitude: 37.334_900,
                                    //    longitude: -122.009_020),
       //  latitudinalMeters: 750,
        // longitudinalMeters: 750
   //  )
   // func setCoordinates(){
     //   region.center = CLLocationCoordinate2D(latitude: userLocation?.coordinate.latitude ?? 0, longitude: userLocation?.coordinate.longitude ?? 0)
    //}
    static let shared = LocationManager()
    
    override init(){
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    /**
     A function called when the app must request the user's location information
     */
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
    }
}

/**
 A utility used to dertermine if we have permission to access the user's location
 */
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
    
    /**
     A function used to set the user's location
     
     - Parameter: manger - the current instance of the location manager
     - Parameter: locations - the user's locations over time
     */
    func locationManager(_ manager : CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location
    }
}
