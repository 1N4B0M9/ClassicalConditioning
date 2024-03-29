//
//  MapDisk.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 4/17/23.
//

import SwiftUI
import MapKit

/**
 A structure used to build a map view using persistant data
 */
struct MapViewDisk : UIViewRepresentable {
    var coords : [CLLocationCoordinate2D] = []
    var reg : MKCoordinateRegion = MKCoordinateRegion()
    var locationManager = LocationManager.shared
    @State var polylineArr : [MKPolyline] = []
    init(coords : [CLLocationCoordinate2D]) {
        self.coords = coords
        if coords.count > 1 {
            reg.center = CLLocationCoordinate2D(latitude: coords[1].latitude, longitude: coords[1].longitude)
        }
        
    }
    
    /**
     A function that creates an instance of a view from this structures information
     
     - Parameter: context - the context in which this view must be created
     - Returns: an instance of the representing view
     */
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = reg
        mapView.showsUserLocation = true
        
        if coords.count > 2 {
            for i in 0..<coords.count-1 {
                mapView.addOverlay(drawLine(coord1: coords[i], coord2: coords[i+1], lineArr: &polylineArr))
            }
        }
        
        
        return mapView
    }
    
    /**
     A function called when the view needs to be updated
     
     - Parameter: mapView - the instance of the view
     - Parameter: context - the context in which the view needs to be updated
     */
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if coords.count > 2 {
            mapView.addOverlay(drawLine(coord1: coords[coords.count-2], coord2: coords[coords.count-1], lineArr: &polylineArr))
        }

    }
    
    /**
     A utility function used to build a new instance of a custom implementation of a context coordinator
     - Returns:a new instance of a context coordinator
     */
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    /**
     A utility function used to draw a multipolyline from an array of polylines
     
     - Parameter: coord1 - the first point to be drawn
     - Parameter: coord2 - the last point to be drawn
     - Parameter: lineArr - the array of lines
     - Returns: A multpolyline to be drawn
     */
    func drawLine(coord1 : CLLocationCoordinate2D, coord2 : CLLocationCoordinate2D, lineArr : inout [MKPolyline]) -> MKMultiPolyline {
        let blueLocation1 = CLLocationCoordinate2D(latitude: coord1.latitude, longitude: coord1.longitude)

        let blueLocation2 = CLLocationCoordinate2D(latitude: coord2.latitude, longitude: coord2.longitude)

        let routeLine = MKPolyline(coordinates:[blueLocation1,blueLocation2], count:2)
        lineArr.append(routeLine)
        let lines = MKMultiPolyline(lineArr)
        print(coord1)
        print(coord2)
        return lines
       // lines.append(routeLine)
        //self.mapView.add(routeLine)
    }
    
    /**
     A custom implementatio of a context coordinator
     */
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKMultiPolyline {
                let renderer = MKMultiPolylineRenderer(multiPolyline: polyline)
                
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 3.0
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
