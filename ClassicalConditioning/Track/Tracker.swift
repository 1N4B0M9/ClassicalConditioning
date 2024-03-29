//
//  Tracker.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/28/23.
//

import Foundation
import CoreMotion
import CoreLocation

/**
 Constructs a new instance of a tracker
 */
//main actor decorator forces class to act only in main thread
@MainActor class Tracker: ObservableObject {
    private let pedometer: CMPedometer = CMPedometer()
    //private let location: CLLocationManager = CLLocationManager()
    private let date: Date = Date()
    @Published var steps: Int? //total steps
    @Published var cadence: Double? //steps per second
    @Published var distance: Int? //total distance traveled in meters
    @Published var intervals: Int = 0 //testing value
    @Published var intervalsFailed: Int = 0 //testing value
    @Published var timeSince: String = "" //time since run started
    private var progress: TrackerProgress = TrackerProgress() //tracks progress of current interval
    private var cancelled: Bool = false
    private let total: SummativeTrackerProgress = SummativeTrackerProgress() //tracks total progress
    private var happyOrMad: HappyOrMad
    
    
    /**
     Constructs a new instance of a tracker
     
     - Parameter: progress - an optional progress output that this tracker will continue off from
     - Parameter: happyOrMad - the instance of the boolean wrapper that is used to determine what "mode" the app is on
     */
    init(progress: OutputTrackerProgress? = nil, happyOrMad: HappyOrMad) {
        self.happyOrMad = happyOrMad
        
        if let progress = progress {
            self.total.steps += progress.steps
            self.total.averageCadence += progress.averageCadence
            self.total.distance += progress.distance
            self.total.seconds += progress.seconds
        }
        
        self.pedometer.startUpdates(from: self.date) { value, error in
            DispatchQueue.main.async {
                if let data = value {
                    self.steps = data.numberOfSteps.intValue
                    self.cadence = data.currentCadence?.doubleValue
                    self.distance = data.distance?.intValue
                    self.intervals += 1
                } else {
                    self.intervalsFailed += 1
                }
                self.total.push(steps: self.steps, cadence: self.cadence, distance: self.distance)
            }
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
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            guard !self.cancelled else {
                timer.invalidate()
                return
            }
            
            self.total.seconds += 1
            let time = self.timePassed(self.total.seconds)
            
            self.timeSince = "\(time.0):\(time.1):\(time.2)"
        }
        
        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [self] timer in
            guard !self.cancelled else {
                timer.invalidate()
                return
            }
            
            if let steps = self.steps, let cadence = self.cadence, let distance = distance {
                let meetsConditions = self.progress.meetsConditions(steps: steps, cadence: cadence, distance: distance)
                
                if meetsConditions, self.happyOrMad.madHappy {
                    Sound.instance.play(true) //encouragement
                    print("happy") //debug
                } else if !meetsConditions, !self.happyOrMad.madHappy {
                    Sound.instance.play(false) //insult
                    print("mad") //debug
                }
            }
            
            self.progress = TrackerProgress(steps: self.steps, cadence: self.cadence, distance: self.distance)

        }
        
        Sound.instance.play(true) //always happy
    }
    
    /**
     Ends the current instance of the run and outputs the run information
     
     - Parameter: cords - an array that contains the coordinates they went during their run that will be used to draw lines on the map
     
     - Returns: the output containing the information with the run that will be saved to disk
     */
    func stop(_ cords: [CLLocationCoordinate2D]) -> OutputTrackerProgress {
        self.cancelled = true
        self.pedometer.stopUpdates()
        
        /*
        print("-----------reading from singleton-----------")
        for output in TrackerManager.instance.trackers {
            print("---")
            print("steps: \(output.steps)")
            print("cadence: \(output.averageCadence)")
            print("distance: \(output.distance)")
            print("---")
        }
        print("--------------------------------------------")
        */
        
        let output = OutputTrackerProgress(progress: total, cords: cords)
        let manager = TrackerManager.instance
        manager.trackers.append(output)
        manager.save()
        return output
    }
    
    
    /**
     (THANKS CHATGPT)
     A function that converts seconds to the format (hh:mm:ss)
     
     - Parameter: seconds - how many seconds has passed since the start of the run
     - Returns: a tuple that contains integers that represent the hours, minutes, and seconds that have passed
     */
    private func timePassed(_ seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        return (hours, minutes, seconds)
    }
}

/**
 A class that is used to keep track of a users movement every "interval" used for audio prompting
 */
private struct TrackerProgress {
    let steps: Int?
    let cadence: Double?
    let distance: Int?
    
    init(steps: Int? = nil, cadence: Double? = nil, distance: Int? = nil) {
        self.steps = steps
        self.cadence = cadence
        self.distance = distance
    }
    
    /**
     A function used to check if the conditions have been met to provide a positive audio prompt
     
     - Parameter: steps - the current amount of steps they have taken in the interval to compared to the previous interval
     - Parameter: cadence - the current cadence they have in the interval to compared to the previous interval
     - Parameter: distance - the current amount of distance they have moved in the interval to compared to the previous interval
     
     - Returns: whether or not the conditions were met
     */
    func meetsConditions(steps: Int, cadence: Double, distance: Int) -> Bool {
        //if internal steps is null or new steps is at least 20 higher
        //if internal cadance is null or new cadnece is at least .25 higher or meets threshold of 5 steps per second
        //if internal distance is null or new distance is at least 10 higher
        return (self.steps == nil || steps >= self.steps! + 20) && (self.cadence == nil || cadence >= self.cadence! + 0.25 || cadence >= 5) && (self.distance == nil || distance >= self.distance! + 10)
    }
}

/**
 A class used to store information of user progress across the entire run
 */
class SummativeTrackerProgress {
    var steps: Int
    var averageCadence: Double
    var distance: Int
    var seconds: Int
    private var calls: Double = 0
    
    init(steps: Int = 0, averageCadence: Double = 0.0, distance: Int = 0, seconds: Int = 0) {
        self.steps = steps
        self.averageCadence = averageCadence
        self.distance = distance
        self.seconds = seconds
    }
    
    /**
     A function used to add information to the total progress after each interval used for audio prompting
     
     - Parameter: steps - the current amount of steps they have taken in the interval
     - Parameter: cadence - the current cadence they have in the interval
     - Parameter: distance - the current amount of distance they have moved in the interval
     */
    func push(steps: Int? = nil, cadence: Double? = nil, distance: Int? = nil) {
        if let steps = steps {
            self.steps += steps
        }
        
        if let cadence = cadence {
            calls += 1
            self.averageCadence = Double(self.averageCadence + cadence) / calls
        }
        
        if let distance = distance {
            self.distance += distance
        }
    }
}
