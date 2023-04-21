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
                    Text("\(getName()) Run \(TrackerManager.instance.indexOf(output.wrappedValue) ?? -1)")
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
