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
    
    var body: some View {
        Group {
            if locationManager.userLocation == nil {
                LocationRequestView()
            }
            else {
                VStack {
                    TrackView()
                    MapViews(coords: locup.coord).onAppear {
                        if locationManager.userLocation?.coordinate.latitude != nil && locationManager.userLocation?.coordinate.longitude != nil {
                            region.center = CLLocationCoordinate2D(latitude: locationManager.userLocation?.coordinate.latitude ?? 0, longitude: locationManager.userLocation?.coordinate.longitude ?? 0)
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
