//
//  TrackerManager.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/17/23.
//

import Foundation
import SwiftUI

class TrackerManager: ObservableObject {
    static let instance: TrackerManager = TrackerManager()
    
    @Published private var trackers: [OutputTrackerProgress] = []
    private var loaded: Bool = false
    var binding: Binding<[OutputTrackerProgress]>?
    
    private init() {
        TrackerManager.load {
            print("load complete: \($0)") //test
            if let trackers = $0 {
                self.trackers = trackers
                self.loaded = true
                print("set tracker to loaded value") //test
            } else {
                print("loaded value was nil") //test
            }
        }
        
        self.binding = Binding() {
            self.trackers
        } set: {
            if self.loaded {
                self.trackers = $0
                TrackerManager.save(self.trackers)
            } else {
                print("not loaded") //test
            }
        }
    }
    
    /*
     https://developer.apple.com/tutorials/app-dev-training/persisting-data
     */
    private static func url() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("runData.data")
    }
    
    private static func load(_ completion: @escaping ([OutputTrackerProgress]?) -> ()) {
        background {
            do {
                let url = try url()
                let file = try FileHandle(forReadingFrom: url)
                let data = try JSONDecoder().decode([OutputTrackerProgress].self, from: file.availableData)
                
                main {
                    completion(data)
                }
            } catch {
                main {
                    completion(nil)
                }
            }
        }
    }
    
    private static func save(_ value: [OutputTrackerProgress]) {
        background {
            do {
                let data = try JSONEncoder().encode(value)
                let output = try url()
                try data.write(to: output)
                print("--------------data---------------")
                print(data.description)
                print("---------------------------------")
                print("write complete")
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

struct OutputTrackerProgress: Codable, Identifiable {
    let steps: Int
    let averageCadence: Double
    let distance: Int
    let id: UUID = UUID()
    
    init(progress: SummativeTrackerProgress) {
        self.steps = progress.steps
        self.averageCadence = progress.averageCadence
        self.distance = progress.distance
    }
    
    /*
     Exclude id from encoding and decoding
     */
    private enum CodingKeys: String, CodingKey {
        case steps, averageCadence, distance
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
