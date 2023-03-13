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
    private var ticks = 0 //ticks and updates every 30 updates
    private var progress: TrackerProgress = TrackerProgress(steps: 0, cadence: 0, distance: 0)
    
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
            self.prompt()
            /*
            print("____________________________________")
            print("steps \(self.steps ?? -1)")
            print("cadnece \(self.cadence ?? -1)")
            print("distance \(self.distance ?? -1)")
            print("intervals \(self.intervals)")
            print("failedIntervals \(self.intervalsFailed)")
            print("____________________________________")
            */
        }
    }
    
    /*
     Called when tracker is no longer used
     */
    func stop() {
        self.pedometer.stopUpdates()
    }
    
    /*
     Called on every update tick
     */
    func prompt() {
        self.ticks += 1
        guard self.ticks % 30 == 0 else { //every 30 ticks prompt user
            return
        }
        
        if let steps = self.steps, let cadence = self.cadence, let distance = self.distance, self.progress.meetsConditions(steps: steps, cadence: cadence, distance: distance) {
            //read out "good job" in a straightforward or backhand way based on mode
            self.progress = TrackerProgress(steps: steps, cadence: cadence, distance: distance)
        } else {
            //read out encourement that user "can do better" based on mode
        }
    }
}

private struct TrackerProgress {
    let steps: Int
    let cadence: Int
    let distance: Int
    
    init(steps: Int, cadence: Int, distance: Int) {
        self.steps = steps
        self.cadence = cadence
        self.distance = distance
    }
    
    func meetsConditions(steps: Int, cadence: Int, distance: Int) -> Bool {
        return true //determine if current values meet conditions
    }
}
