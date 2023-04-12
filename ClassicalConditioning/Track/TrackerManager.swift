//
//  TrackerManager.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/17/23.
//

import Foundation
import SwiftUI
import CoreLocation

class TrackerManager: ObservableObject {
    static let instance: TrackerManager = TrackerManager()
    
    @Published var trackers: [OutputTrackerProgress] = []
    private var loaded: Bool = false
    
    private init() {
        TrackerManager.load {
            if let trackers = $0 {
                self.trackers = trackers
                self.loaded = true
            } else {
                fatalError("Returned value from disk was null, something has gone VERY wrong")
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.save()
        }
    }
    
    func save() {
        if self.loaded {
            TrackerManager.save(self.trackers)
        }
    }
    
    /*
     https://developer.apple.com/tutorials/app-dev-training/persisting-data
     */
    private static func url() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("runData.data")
    }
    
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

struct OutputTrackerProgress: Codable, Identifiable{
    let steps: Int
    let averageCadence: Double
    let distance: Int
    let cords: [Coordinate]
    let id: UUID = UUID()
    var locationCords: [CLLocationCoordinate2D] {
        cords.map {
            CLLocationCoordinate2D($0)
        }
    }
    
    init(progress: SummativeTrackerProgress) {
        self.steps = progress.steps
        self.averageCadence = progress.averageCadence
        self.distance = progress.distance
        self.cords = progress.cords.map {
            Coordinate($0)
        }
    }
    
    /*
     Exclude id from encoding and decoding
     */
    private enum CodingKeys: String, CodingKey {
        case steps, averageCadence, distance, cords
    }
}

func background(_ task: @escaping () -> ()) {
    DispatchQueue.global(qos: .background).async {
       task()
    }
}

func main(_ task: @escaping () -> ()) {
    DispatchQueue.main.async {
       task()
    }
}

struct Coordinate: Codable {
    let longitude: Double
    let latitude: Double
}

extension CLLocationCoordinate2D {
    init(_ coordinate: Coordinate) {
        self = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

extension Coordinate {
    init(_ coordinate: CLLocationCoordinate2D) {
        self = .init(longitude: coordinate.longitude, latitude: coordinate.latitude)
    }
}
