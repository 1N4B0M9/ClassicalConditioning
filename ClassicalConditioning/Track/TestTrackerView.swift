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
            if $tracker.wrappedValue != nil {
                HStack {
                    Text("steps: \($tracker.wrappedValue?.steps ?? -1)")
                    Text("cadence: \($tracker.wrappedValue?.cadence ?? -1)")
                    Text("distance: \($tracker.wrappedValue?.distance ?? -1)")
                    Text("intervals: \($tracker.wrappedValue?.intervals ?? -1)")
                    Text("intervalsFailed: \($tracker.wrappedValue?.intervalsFailed ?? -1)")
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
