//
//  Tracker.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/28/23.
//

import Foundation
import CoreMotion
//import CoreLocation

class Tracker: ObservableObject {
    private let pedometer: CMPedometer = CMPedometer()
    //private let location: CLLocationManager = CLLocationManager()
    private let date: Date = Date()
    @Published var steps: Int? //total steps
    @Published var cadence: Int? //steps per second
    @Published var distance: Int? //total distance traveled in meters
    @Published var intervals: Int = 0 //testing value
    @Published var intervalsFailed: Int = 0 //testing value
    
    init() {
        self.pedometer.startUpdates(from: self.date) { value, error in
            if let data = value {
                self.steps = data.numberOfSteps.intValue
                self.cadence = data.currentCadence?.intValue
                self.distance = data.distance?.intValue
                self.intervals += 1
            } else {
                self.intervalsFailed += 1
            }
            print("____________________________________")
            print("steps \(self.steps ?? -1)")
            print("cadnece \(self.cadence ?? -1)")
            print("distance \(self.distance ?? -1)")
            print("intervals \(self.intervals)")
            print("failedIntervals \(self.intervalsFailed)")
            print("____________________________________")
        }
    }
    
    func stop() {
        self.pedometer.stopUpdates()
    }
}
