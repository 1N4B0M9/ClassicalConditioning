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
    var reg : MKCoordinateRegion = MKCoordinateRegion()
    var locationManager = LocationManager.shared
    @State var polylineArr : [MKPolyline] = []
    init(coords: [CLLocationCoordinate2D]) {
        self.coords = coords
        reg.center = CLLocationCoordinate2D(latitude: locationManager.userLocation?.coordinate.latitude ?? 0, longitude: locationManager.userLocation?.coordinate.longitude ?? 0)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = reg
        mapView.showsUserLocation = true
        if coords.count > 2{
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
    func stop(){
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
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
    
    class Coordinator: NSObject, MKMapViewDelegate {
       // @EnvironmentObject var madOrHappy : HappyOrMad
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKMultiPolyline {
               // let renderer = MKMultiPolylineRenderer(polyline: polyline)
                let renderer = MKMultiPolylineRenderer(multiPolyline: polyline)
             //   if madOrHappy.madHappy == true {
                 //   renderer.strokeColor = UIColor.blue

             //   }
              //  else {
              //      renderer.strokeColor = UIColor.red
              //  }
                
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 3.0
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
