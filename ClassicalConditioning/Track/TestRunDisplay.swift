//
//  TestRunDisplay.swift
//  ClassicalConditioning
//
//  Created by Ethan Lieberman (student LM) on 3/20/23.
//

import SwiftUI

struct TestRunDisplay: View {
    @ObservedObject private var manager = TrackerManager.instance
    @State var i = 0
    var body: some View {
        NavigationView {
            List {
            
            ForEach(self.$manager.trackers) { output in
                NavigationLink {
                    VStack {
                        Text("steps: \(output.wrappedValue.steps)")
                        Text("averageCadence: \(output.wrappedValue.averageCadence, specifier: "%.3f")") //specifier used to round to three decimal places
                        Text("distance: \(output.wrappedValue.distance)")
                    }
                } label : {
                    Text("Run\(i+1)")
                }
               
                
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
