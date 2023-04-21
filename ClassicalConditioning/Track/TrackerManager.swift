//
//  TrackerManager.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/17/23.
//

import Foundation
import SwiftUI
import CoreLocation

/**
 A class used to manage all the instances of runs from disk (singleton)
 */
class TrackerManager: ObservableObject {
    static let instance: TrackerManager = TrackerManager()
    
    @Published var trackers: [OutputTrackerProgress] = []
    private var loaded: Bool = false
    
    private init() {
        TrackerManager.load {
            if let trackers = $0 {
                self.trackers = trackers
            } else {
                do {
                    try FileManager.default.removeItem(at: TrackerManager.url())
                    print("deleted file on disk because there was an error parsing the file")
                } catch let error {
                    print(error)
                }
            }
            
            self.loaded = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.save()
        }
    }
    
    /**
     A function used to write all the data to disk
     */
    func save() {
        if self.loaded {
            TrackerManager.save(self.trackers)
        }
    }
    
    /**
     A function used to get the current index in the cache that a provided output is
     
     - Perameter: info - the provided output
     - Returns: the index (or nil if the output is not present in the cache)
     */
    func indexOf(_ info: OutputTrackerProgress) -> Int? {
        for i in 0..<self.trackers.count {
            if self.trackers[i].id == info.id {
                return i
            }
        }
        
        return nil
    }
    
    /**
     (https://developer.apple.com/tutorials/app-dev-training/persisting-data)
     A function that returns the URL of the file that is used to save persistant data
     
     - Returns: the url of the file used to sotre persistant data
     */
    private static func url() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("runData.data")
    }
    
    /**
     A function used to load all data from disk into the cache
     
     - Perameter: completeion - a closure used to proform some operation async with the parsed data (or nil if an error occured)
     */
    private static func load(_ completion: @escaping ([OutputTrackerProgress]?) -> ()) {
        do {
            let url = try url()
            let file = try FileHandle(forReadingFrom: url)
            let data = try JSONDecoder().decode([OutputTrackerProgress].self, from: file.availableData)
            
            completion(data)
        } catch {
            completion(nil)
        }
    }
    
    /**
     A function used to write the current cache to disk
     
     - Perameter: value - the value to write to disk
     */
    private static func save(_ value: [OutputTrackerProgress]) {
        background {
            do {
                let data = try JSONEncoder().encode(value)
                let output = try url()
                try data.write(to: output)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

/**
 A structure used to store important data from the run that will be saved persistantly
 */
struct OutputTrackerProgress: Codable, Identifiable {
    let steps: Int
    let averageCadence: Double
    let distance: Int
    let seconds: Int
    private let cords: [Coordinate]
    let id: UUID = UUID()
    var locationCords: [CLLocationCoordinate2D] {
        cords.map {
            CLLocationCoordinate2D($0)
        }
    }
    
    init(steps: Int, averageCadnece: Double, distance: Int, seconds: Int, cords: [Coordinate] = []) {
        self.steps = steps
        self.averageCadence = averageCadnece
        self.distance = distance
        self.seconds = seconds
        self.cords = cords
    }
    
    init(progress: SummativeTrackerProgress, cords: [CLLocationCoordinate2D]) {
        self.steps = progress.steps
        self.averageCadence = progress.averageCadence
        self.distance = progress.distance
        self.seconds = progress.seconds
        self.cords = cords.map {
            Coordinate($0)
        }
    }
    
    /*
     Exclude id from encoding and decoding
     */
    private enum CodingKeys: String, CodingKey {
        case steps, averageCadence, distance, seconds, cords
    }
}

/**
 A utility function used to run a background task
 
 Parameter: task - the task to run in the background
 */
func background(_ task: @escaping () -> ()) {
    DispatchQueue.global(qos: .background).async {
       task()
    }
}

/**
 A utility function used to run a task on the main dispatch queue
 
 Parameter: task - the task to run in the background
 */
func main(_ task: @escaping () -> ()) {
    DispatchQueue.main.async {
       task()
    }
}

/**
 A wrapper for CLLocationCoordinate2D
 */
struct Coordinate: Codable {
    let longitude: Double
    let latitude: Double
}

/**
 An extension used to add a constructor that creates a new instance of a CLLocationCoordinate2D from its wrapper
 */
extension CLLocationCoordinate2D {
    init(_ coordinate: Coordinate) {
        self = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

/**
 An extension used to add a constructor that creates a new instance of a wrapper from a CLLocationCoordinate2D
 */
extension Coordinate {
    init(_ coordinate: CLLocationCoordinate2D) {
        self = .init(longitude: coordinate.longitude, latitude: coordinate.latitude)
    }
}
