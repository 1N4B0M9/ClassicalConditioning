//
//  MapView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI
struct MapView: View {
    @ObservedObject var locationManager = LocationManager.shared
    @State private var region = MKCoordinateRegion()
    @State var tracking: MapUserTrackingMode = .follow
    @ObservedObject var locup = LocationUpdates()
    @EnvironmentObject var onoff : onOrOff
    var body: some View {
        Group {
            if locationManager.userLocation == nil {
                LocationRequestView()
            } else {
                Group {
                    if onoff.oof == true {
                        VStack {
                           // TrackView(cords: $locup.coord)
                            MapViews(coords: locup.coord).onAppear {
                                if locationManager.userLocation?.coordinate.latitude != nil && locationManager.userLocation?.coordinate.longitude != nil {
                                    region.center = CLLocationCoordinate2D(latitude: locationManager.userLocation?.coordinate.latitude ?? 0, longitude: locationManager.userLocation?.coordinate.longitude ?? 0)
                                }
                            }
                        }
                    }
                    else {
                        Map(coordinateRegion: $region, showsUserLocation: true).onAppear {
                                if locationManager.userLocation?.coordinate.latitude != nil && locationManager.userLocation?.coordinate.longitude != nil {
                                    region.center = CLLocationCoordinate2D(latitude: locationManager.userLocation?.coordinate.latitude ?? 0, longitude: locationManager.userLocation?.coordinate.longitude ?? 0)
                                }
                            }
                       
                           
                    }
                }
                
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
