//
//  TestTrackerView.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/1/23.
//

import SwiftUI

struct TestTrackerView: View {
    @State var tracker: Tracker?
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    if tracker == nil {
                        tracker = Tracker()
                    }
                } label: {
                    Text("Start tracker")
                }
                Button {
                    if let tracker = tracker {
                        tracker.stop()
                        self.tracker = nil
                    }
                } label: {
                    Text("Stop tracker")
                }
            }
            if let t = tracker {
                HStack {
                    Text("steps: \(String(describing: $tracker.convert(t).steps))")
                    Text("cadence: \(String(describing: $tracker.convert(t).cadence))")
                    Text("disance: \(String(describing: $tracker.convert(t).distance))")
                    Text("intervals: \(String(describing: $tracker.convert(t).intervals))")
                    Text("intervalsFailed: \(String(describing: $tracker.convert(t).intervalsFailed))")
                }
            }
        }
    }
}

struct TestTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TestTrackerView()
    }
}
