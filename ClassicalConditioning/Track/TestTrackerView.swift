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
            if let tracker = tracker {
                DisplayView(tracker: tracker)
            }
        }
    }
    
    private struct DisplayView: View {
        @ObservedObject var tracker: Tracker
        
        var body: some View {
            HStack {
                Text("steps: \($tracker.steps.wrappedValue ?? 0)")
                Text("cadence: \($tracker.cadence.wrappedValue ?? 0)")
                Text("distance: \($tracker.distance.wrappedValue ?? 0)")
                Text("intervals: \($tracker.intervals.wrappedValue)") //debug
                Text("intervalsFailed: \($tracker.intervalsFailed.wrappedValue)") //debug
            }
        }
    }
}

struct TestTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TestTrackerView()
    }
}
