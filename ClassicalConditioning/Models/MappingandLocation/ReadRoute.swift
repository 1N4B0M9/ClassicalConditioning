//
//  ReadRoute.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/17/23.
//

import Foundation
import HealthKit
import CoreLocation
import UIKit
import MapKit

/**
 A class used to keep track of the users movement during a run
 */
class LocationUpdates : ObservableObject {
    private var cancelled: Bool = false
    private var locationManager = LocationManager.shared
    @Published var coord : [CLLocationCoordinate2D] = []
    var lines: [MKPolyline] = []


    init() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [self] timer in
            guard !self.cancelled else {
                timer.invalidate()
                return
            }
           
            coord.append(CLLocationCoordinate2D(latitude: locationManager.userLocation?.coordinate.latitude ?? 0, longitude: locationManager.userLocation?.coordinate.longitude ?? 0 ))
        }
    }
    
    /**
     A function used to stop the current instance of the location tracker
     */
    func stop() {
        coord.removeAll()
        self.cancelled = true
    }
 
    /**
     A function that is used to draw a line that will be drawn on the map
     
     - Parameter: coord1 - the first cord
     - Parameter: coord2 - the second cord
     - Returns: a polyline that will be drawn on the map
     */
    func drawLine(coord1 : CLLocationCoordinate2D, coord2 : CLLocationCoordinate2D) -> MKPolyline {
        let blueLocation1 = CLLocationCoordinate2D(latitude: coord1.latitude, longitude: coord1.longitude)

        let blueLocation2 = CLLocationCoordinate2D(latitude: coord2.latitude, longitude: coord2.longitude)

        let routeLine = MKPolyline(coordinates:[blueLocation1,blueLocation2], count:2)
        return routeLine
    }
}
