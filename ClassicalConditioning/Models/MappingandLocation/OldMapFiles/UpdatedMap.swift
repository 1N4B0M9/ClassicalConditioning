//
//  UpdatedMap.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/23/23.
//

import Foundation
import MapKit
import SwiftUI
class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var lines : [MKPolyline] = []
    func viewDidLoad(coords : [CLLocationCoordinate2D]) {
        super.viewDidLoad()
        
        // Set the map view's delegate to self
        mapView.delegate = self
        
        for i in 0..<coords.count-1 {
            lines.append(drawLine(coord1: coords[i], coord2: coords[i+1]))
        }
        
        for e in lines {
            mapView.addOverlay(e)

        }
        
        
        
        
        }
    func drawLine(coord1 : CLLocationCoordinate2D, coord2 : CLLocationCoordinate2D) -> MKPolyline {
        let blueLocation1 = CLLocationCoordinate2D(latitude: coord1.latitude, longitude: coord1.longitude)

        let blueLocation2 = CLLocationCoordinate2D(latitude: coord2.latitude, longitude: coord2.longitude)

        let routeLine = MKPolyline(coordinates:[blueLocation1,blueLocation2], count:2)
        return routeLine
       // lines.append(routeLine)
        //self.mapView.add(routeLine)
    }
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
