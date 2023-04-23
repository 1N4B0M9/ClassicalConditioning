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
    
    private static let m : [String] = ["Awful", "Dreadful", "Horrible", "Abysmal", "Atrocious", "Ghastly", "Appalling", "Gruesome", "Dire", "Frightful", "Catastrophic", "Infernal", "Miserable", "Repugnant", "Unbearable","Wretched"]
    private static let h : [String] = ["Awesome",
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
    
    /**
     A function that provides a random positive or negitive adjective to describe the proformance of a run
     
     - Perameter: madOrHappy - a boolean that is true when the adjective should be positive and false when it should be negative
     - Returns: a random positive or negitive adjective to describe the proformance of a run
     */
    private static func getName(_ madOrHappy: Bool) -> String {
        madOrHappy ? h[Int.random(in: 0..<15)] : m[Int.random(in: 0..<15)]
    }
    
    init() {
          // Set the background color of the navigation bar
        //UITableView.appearance().backgroundColor = UIColor(Color.red)
       // UITableViewCell.appearance().backgroundColor = UIColor(Color.red)
        
    }
    var body: some View {
       
          
        NavigationView {
            
            
            List {
            
            ForEach(self.$manager.trackers) { output in
                NavigationLink {
                    Group {
                        VStack {
                            Text("Steps: \(output.wrappedValue.steps)")
                            Text("Average Cadence: \(output.wrappedValue.averageCadence, specifier: "%.3f")") //specifier used to round to three decimal places
                            Text("Distance: \(output.wrappedValue.distance)")
                            Text("Time: \(output.wrappedValue.seconds)")
                            if output.wrappedValue.locationCords.count == 0 {
                                Text("No Enough Data")
                            }
                            else {
                                MapViewDisk(coords: output.wrappedValue.locationCords)

                            }
                            
                                    
                            }
                        
                    }
                    
                } label : {
                    Text("\(TestRunDisplay.getName(self.madOrHappy.madHappy)) Run \(TrackerManager.instance.indexOf(output.wrappedValue) ?? -1)")
                }
                .listRowBackground(madOrHappy.madHappy == false ? Color.customRed : Color.customBlue)
               
                
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
