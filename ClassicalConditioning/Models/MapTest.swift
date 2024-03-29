//
//  MapTest.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/23/23.
//

import SwiftUI
import MapKit

/**
 A structure that will be adapted into a map view
 */
struct MapViews : UIViewRepresentable {
    var coords : [CLLocationCoordinate2D] = []
    var reg : MKCoordinateRegion = MKCoordinateRegion()
    var locationManager = LocationManager.shared
    @State var polylineArr : [MKPolyline] = []
    init(coords: [CLLocationCoordinate2D]) {
        self.coords = coords
        reg.center = CLLocationCoordinate2D(latitude: locationManager.userLocation?.coordinate.latitude ?? 0, longitude: locationManager.userLocation?.coordinate.longitude ?? 0)
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
        mapView.removeOverlays(mapView.overlays)
        if coords.count > 2 {
           // for i in 0..<coords.count-1 {
            mapView.addOverlay(drawLine(coord1: coords[coords.count-2], coord2: coords[coords.count-1], lineArr: &polylineArr))
               // print("Test Init")
               // print(coords[i])
               // print(coords[i+1])
               // print("______________")
              //  print("Helllo")
          // }

        }
        
        
        return mapView
    }
    
    /**
     A function called when the view needs to be updated
     
     - Parameter: mapView - the instance of the view
     - Parameter: context - the context in which the view needs to be updated
     */
    func updateUIView(_ mapView: MKMapView, context: Context) {
        //view.delegate = context.coordinator
        
        if coords.count > 2 {
            
            //for i in 0..<coords.count-1 {
            //mapView.removeOverlays(mapView.overlays)
            //test
            
            
            mapView.addOverlay(drawLine(coord1: coords[coords.count-2], coord2: coords[coords.count-1], lineArr: &polylineArr))


               //print("Print test update")
              // print(coords[i])
             //  print(coords[i+1])
             //  print("_______________")
            //}
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
