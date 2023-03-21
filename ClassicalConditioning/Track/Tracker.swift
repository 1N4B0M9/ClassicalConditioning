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
    @Published var cadence: Double? //steps per second
    @Published var distance: Int? //total distance traveled in meters
    @Published var intervals: Int = 0 //testing value
    @Published var intervalsFailed: Int = 0 //testing value
    @Published var promptsPositive: Int = 0 //testing value
    @Published var promptsNegative: Int = 0 //testing value
    private var progress: TrackerProgress = TrackerProgress() //tracks progress of current interval
    private var cancelled: Bool = false
    private let total: SummativeTrackerProgress = SummativeTrackerProgress() //tracks total progress
    
    init(_ progress: OutputTrackerProgress? = nil) {
        if let progress = progress {
            self.total.steps += progress.steps
            self.total.averageCadence += progress.averageCadence
            self.total.distance += progress.distance
        }
        
        self.pedometer.startUpdates(from: self.date) { value, error in
            if let data = value {
                self.steps = data.numberOfSteps.intValue
                self.cadence = data.currentCadence?.doubleValue
                self.distance = data.distance?.intValue
                self.intervals += 1
            } else {
                self.intervalsFailed += 1
            }
            self.total.push(steps: self.steps, cadence: self.cadence, distance: self.distance)
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
        
        Timer.scheduledTimer(withTimeInterval: 25, repeats: true) { [self] timer in
            guard !self.cancelled else {
                timer.invalidate()
                return
            }
            
            if let steps = self.steps, let cadence = self.cadence, let distance = distance, self.progress.meetsConditions(steps: steps, cadence: cadence, distance: distance) {
                //read out "good job" in a straightforward or backhand way based on mode
                self.promptsPositive += 1
            } else {
                //read out encourement that user "can do better" based on mode
                self.promptsNegative += 1
            }
            
            self.progress = TrackerProgress(steps: self.steps, cadence: self.cadence, distance: self.distance)
            self.total.push(steps: self.steps, cadence: self.cadence, distance: self.distance)
        }
    }
    
    /*
     Called when tracker is no longer used
     */
    func stop() -> OutputTrackerProgress {
        self.cancelled = true
        self.pedometer.stopUpdates()
        let output = OutputTrackerProgress(progress: total)
        TrackerManager.instance.push(output)
        return output
    }
}

private struct TrackerProgress {
    let steps: Int?
    let cadence: Double?
    let distance: Int?
    
    init(steps: Int? = nil, cadence: Double? = nil, distance: Int? = nil) {
        self.steps = steps
        self.cadence = cadence
        self.distance = distance
    }
    
    func meetsConditions(steps: Int, cadence: Double, distance: Int) -> Bool {
        //if internal steps is null or new steps is at least 20 higher
        //if internal cadance is null or new cadnece is at least .25 higher or meets threshold of 5 steps per second
        //if internal distance is null or new distance is at least 10 higher
        return (self.steps == nil || steps >= self.steps! + 20) && (self.cadence == nil || cadence >= self.cadence! + 0.25 || cadence >= 5) && (self.distance == nil || distance >= self.distance! + 10)
    }
}

class SummativeTrackerProgress {
    var steps: Int
    var averageCadence: Double
    var distance: Int
    private var calls: Double = 0
    
    init(steps: Int = 0, averageCadence: Double = 0.0, distance: Int = 0) {
        self.steps = steps
        self.averageCadence = averageCadence
        self.distance = distance
    }
    
    func push(steps: Int? = nil, cadence: Double? = nil, distance: Int? = nil) {
        if let steps = steps {
            self.steps = steps
        }
        
        if let cadence = cadence {
            calls += 1
            self.averageCadence = Double(averageCadence + cadence) / calls
        }
        
        if let distance = distance {
            self.distance = distance
        }
    }
}
