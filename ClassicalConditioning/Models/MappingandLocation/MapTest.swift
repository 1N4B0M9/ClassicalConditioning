//
//  MapTest.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/23/23.
//

import SwiftUI
import MapKit

struct MapViews : UIViewRepresentable {
    var coords : [CLLocationCoordinate2D] = []
    var reg : MKCoordinateRegion
    init(coords: [CLLocationCoordinate2D], reg : MKCoordinateRegion){
        self.coords = coords
        self.reg = reg
        
    }
   
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = reg
        if coords.count != 0{
            for i in 0..<coords.count-1 {
            mapView.addOverlay(drawLine(coord1: coords[i], coord2: coords[i+1]))
                print("HI")
            }

        }
        
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        if coords.count != 0 {
            for i in 0..<coords.count-1 {
                view.addOverlay(drawLine(coord1: coords[i], coord2: coords[i+1]))
                print("HI")
            }
        }

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    func drawLine(coord1 : CLLocationCoordinate2D, coord2 : CLLocationCoordinate2D) -> MKPolyline {
        let blueLocation1 = CLLocationCoordinate2D(latitude: coord1.latitude, longitude: coord1.longitude)

        let blueLocation2 = CLLocationCoordinate2D(latitude: coord2.latitude, longitude: coord2.longitude)

        let routeLine = MKPolyline(coordinates:[blueLocation1,blueLocation2], count:2)
        return routeLine
       // lines.append(routeLine)
        //self.mapView.add(routeLine)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 3.0
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
