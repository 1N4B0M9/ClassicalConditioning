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
                    Text("steps: \($tracker.convert(t).steps.convert(-1))" as String)
                    Text("cadence: \($tracker.convert(t).cadence.convert(-1))" as String)
                    Text("disance: \($tracker.convert(t).distance.convert(-1))" as String)
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
