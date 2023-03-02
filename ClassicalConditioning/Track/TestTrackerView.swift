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
        Text("Hey")
        /*
        VStack {
            HStack {
                Button {
                    tracker = Tracker()
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
                HStack {
                    Text("steps: \(tracker.steps)")
                    Text("cadence: \(tracker.cadence)")
                    Text("disance: \(tracker.distance)")
                }
            }
        }
         */
    }
}

struct TestTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TestTrackerView()
    }
}
