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
struct PersistantMapView: View {
    @State private var region = MKCoordinateRegion()
    @State var tracking: MapUserTrackingMode = .follow
    @ObservedObject var locup = LocationUpdates()
    
    var body: some View {
        Group {
            VStack {
                TrackView(cords: $locup.coord)
                MapViews(coords: locup.coord).onAppear {
                    region.center = CLLocationCoordinate2D(latitude: locup.coord[0].latitude, longitude: locup.coord[0].longitude)
                }
            }
        }
    }
}

struct PersistantMapView_Previews: PreviewProvider {
    static var previews: some View {
        PersistantMapView()
    }
}
