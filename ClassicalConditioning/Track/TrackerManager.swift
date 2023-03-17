//
//  TrackerManager.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/17/23.
//

import Foundation

class TrackerManager {
    static let instance: TrackerManager = TrackerManager()
    
    private var trackers: [OutputTrackerProgress] = []
    
    private init() {
        OutputTrackerProgress.load {
            if let trackers = $0 {
                self.trackers = trackers
            }
        }
    }
    
    func push(_ value: OutputTrackerProgress) {
        trackers.append(value)
        OutputTrackerProgress.save(trackers)
    }
    
    func pull() -> [OutputTrackerProgress] {
        let dupe = trackers //shallow copy
        return dupe
    }
}

struct OutputTrackerProgress: Codable {
    let steps: Int
    let averageCadence: Double
    let distance: Int
    
    init(progress: SummativeTrackerProgress) {
        self.steps = progress.steps
        self.averageCadence = progress.averageCadence
        self.distance = progress.distance
    }
    
    /*
     https://developer.apple.com/tutorials/app-dev-training/persisting-data
     */
    private static func url() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("runData.data")
    }
    
    static func load(_ completion: @escaping ([OutputTrackerProgress]?) -> ()) {
        background {
            do {
                guard let file = try? FileHandle(forReadingFrom: url()) else {
                    main {
                        completion(nil)
                    }
                    return
                }
                
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
    
    static func save(_ value: [OutputTrackerProgress]) {
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

private func background(_ task: @escaping () -> ()) {
    DispatchQueue.global(qos: .background).async {
       task()
    }
}

private func main(_ task: @escaping () -> ()) {
    DispatchQueue.main.async {
       task()
    }
}
