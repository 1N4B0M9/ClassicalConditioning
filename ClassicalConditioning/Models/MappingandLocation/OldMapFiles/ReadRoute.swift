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
class getLocationUpdates : ObservableObject {
    private var cancelled: Bool = false
    var locationManager = LocationManager.shared
    @Published var coord : [CLLocationCoordinate2D] = []
    var lines : [MKPolyline] = []
    var index = 0
    init() {
    Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [self] timer in
        guard !self.cancelled else {
            timer.invalidate()
            return
        }
        index = index + 1
        coord.append(CLLocationCoordinate2D(latitude: locationManager.userLocation?.coordinate.latitude ?? 0, longitude: locationManager.userLocation?.coordinate.latitude ?? 0 ))
        /*
        if index == 1 {
            drawLine(coord1: coord[0], coord2: coord[0])
            //maps.overlay(ShapeStyle(drawLine(coord1: coord[0], coord2: coord[0]))
            maps.addOverlay(drawLine(coord1: coord[0], coord2: coord[0]))
            
        }
        else {
            maps.addOverlay(drawLine(coord1: coord[index], coord2: coord[index-1]))
        }
         */
        
    
        //long.append(locationManager.userLocation?.coordinate.latitude ?? 0)

        
    }
    }
    func getCoordlist(index : Int) -> CLLocationCoordinate2D {
        return coord[index]
        
    }
    func stop() {
        self.cancelled = true
    }
    func drawLine(coord1 : CLLocationCoordinate2D, coord2 : CLLocationCoordinate2D) -> MKPolyline {
        let blueLocation1 = CLLocationCoordinate2D(latitude: coord1.latitude, longitude: coord1.longitude)

        let blueLocation2 = CLLocationCoordinate2D(latitude: coord2.latitude, longitude: coord2.longitude)

        let routeLine = MKPolyline(coordinates:[blueLocation1,blueLocation2], count:2)
        return routeLine
       // lines.append(routeLine)
        //self.mapView.add(routeLine)
    }
    

}
