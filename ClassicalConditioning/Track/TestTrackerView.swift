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
            if tracker != nil {
                HStack {
                    Text("steps: \(String(describing: $tracker.wrappedValue?.steps))")
                    Text("cadence: \(String(describing: $tracker.wrappedValue?.cadence))")
                    Text("distance: \(String(describing: $tracker.wrappedValue?.distance))")
                    Text("intervals: \(String(describing: $tracker.wrappedValue?.intervals))")
                    Text("intervalsFailed: \(String(describing: $tracker.wrappedValue?.intervalsFailed))")
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
