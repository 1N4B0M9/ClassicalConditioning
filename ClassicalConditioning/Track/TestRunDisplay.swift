//
//  TestRunDisplay.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/20/23.
//

import SwiftUI

struct TestRunDisplay: View {
    
    var body: some View {
        if let binding = TrackerManager.instance.binding {
            VStack {
                Text("binding is not null")
                HStack {
                    ForEach(binding) { output in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: 200, height: 200)
                            VStack {
                                Text("steps: \(output.wrappedValue.steps)")
                                Text("averageCadence: \(output.wrappedValue.averageCadence, specifier: "%.3f")") //specifier used to round to three decimal places
                                Text("distance: \(output.wrappedValue.distance)")
                            }
                        }
                    }
                }
            }
        } else {
            Text("binding is null") //testing value
        }
    }
}

struct TestRunDisplay_Previews: PreviewProvider {
    static var previews: some View {
        TestRunDisplay()
    }
}
