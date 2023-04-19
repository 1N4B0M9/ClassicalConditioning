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
    @EnvironmentObject var madOrHappy : HappyOrMad
    func getName () -> String {
        var m : [String] = ["Awful", "Dreadful", "Horrible", "Abysmal", "Atrocious", "Ghastly", "Appalling", "Gruesome", "Dire", "Frightful", "Catastrophic", "Infernal", "Miserable", "Repugnant", "Unbearable","Wretched"]
        var h : [String] = ["Awesome",
                            "Astonishing",
                            "Breathtaking",
                            "Extraordinary",
                            "Incredible",
                            "Phenomenal",
                            "Splendid",
                            "Spectacular",
                            "Marvelous",
                            "Wonderful",
                            "Fabulous",
                            "Remarkable",
                            "Exquisite",
                            "Majestic",
                            "Stupendous",
                            "Sublime"]
        if madOrHappy.madHappy == false {
            return m[Int.random(in: 0..<15)]
        }
        else {
            return h[Int.random(in: 0..<15)]

        }
    }
    var body: some View {
        
        NavigationView {
            List {
            
            ForEach(self.$manager.trackers) { output in
                NavigationLink {
                    Group {
                        VStack {
                            Text("steps: \(output.wrappedValue.steps)")
                            Text("averageCadence: \(output.wrappedValue.averageCadence, specifier: "%.3f")") //specifier used to round to three decimal places
                            Text("distance: \(output.wrappedValue.distance)")
                            if output.wrappedValue.locationCords.count == 0 {
                                Text("No Enough Data")
                            }
                            else {
                                MapViewDisk(coords: output.wrappedValue.locationCords)

                            }
                            
                                    
                            }
                        
                    }
                    
                } label : {
                    Text("\(getName()) Run \(TrackerManager.instance.indexOf(output.wrappedValue) ?? -1)")
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
