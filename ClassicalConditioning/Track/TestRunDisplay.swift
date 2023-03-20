//
//  TestRunDisplay.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/20/23.
//

import SwiftUI

struct TestRunDisplay: View {
    private var manager: TrackerManager {
        TrackerManager.instance
    }
    
    var body: some View {
        ForEach(manager.pull()) { output in
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 200)
                VStack {
                    Text("steps: \(output.steps)")
                    Text("averageCadence: \(output.averageCadence, specifier: "%.3f")") //specifier used to round to three decimal places
                    Text("distance: \(output.distance)")
                }
            }
        }
    }
}

struct TestRunDisplay_Previews: PreviewProvider {
    static var previews: some View {
        TestRunDisplay()
    }
}
