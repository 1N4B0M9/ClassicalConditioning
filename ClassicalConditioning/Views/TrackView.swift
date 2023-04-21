//
//  TrackView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/28/23.
//

import SwiftUI
import CoreLocation

struct TrackView: View {
    @Binding var cords: [CLLocationCoordinate2D]
    @State var tracker: Tracker?
    @EnvironmentObject var onoff: onOrOff
    @EnvironmentObject var happyOrMad: HappyOrMad
    @ObservedObject var locup = LocationUpdates()

    var body: some View {
        VStack {
            if let track = tracker {
                DisplayView(tracker: track)
            }
            else {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(happyOrMad.madHappy == false ? Color.red : Color.blue)
                        .frame(height: 150)
                        .padding(10)
                        .opacity(0.8)
                    VStack {
                        HStack {
                            Text("Time: ---")
                                //.font(.system(size: 36))
                                .font(Constants.TitleFont)

                            Text("Cadence: ---")
                                .font(Constants.TitleFont)
                        }
                        HStack {
                            Text("Distance: ---")
                                .font(Constants.TitleFont)
                            Text("Steps: ---")
                                .font(Constants.TitleFont)
                        }
                    }
                    
                }
              
            }
                        


                
                Button {
                    if onoff.oof == false {
                        onoff.oof = true
                        if tracker == nil {
                            tracker = Tracker(happyOrMad: happyOrMad)
                        }
                        Sound.instance.play(happyOrMad.madHappy)


                    }
                    else {
                        onoff.oof = false
                        if let tracker = tracker {
                            tracker.stop(cords)
                            locup.stop()
                            self.tracker = nil
                        }
                    }

                   
                    
                } label: {
                   
                            
                    if onoff.oof == false {
                        ZStack{
                            Circle()
                                .frame(width: 80, height: 80)
                                .foregroundColor(happyOrMad.madHappy == false ? Color.red : Color.blue)
                                .offset(y: 10)
                                
                            Image(systemName: "play.fill").resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.black)
                                .offset(y: 10)
                        }
                    }
                    else {
                        ZStack{
                            Circle()
                                .frame(width: 80, height: 80)
                                .foregroundColor(happyOrMad.madHappy == false ? Color.red : Color.blue)
                                .offset(y: 10)
                            Image(systemName: "pause.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.black)
                                .offset(y: 10)
                        }
                    }
                    
                   
                
            }
           
        }
    }
    
    private struct DisplayView: View {
        @ObservedObject var tracker: Tracker
        @EnvironmentObject var happyOrMad: HappyOrMad
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(happyOrMad.madHappy == false ? Color.red : Color.blue)
                    .frame(height: 150)
                    .padding(10)
                VStack {
                    HStack {
                        Text("Time: \($tracker.timeSince.wrappedValue)")
                            .font(Constants.TitleFont)
                            .foregroundColor(Color.white)
                        Text("Cadence: \($tracker.cadence.wrappedValue ?? 0, specifier: "%.3f")")
                            .font(Constants.TitleFont)
                            .foregroundColor(Color.white)

                    }
                    HStack {
                        Text("Distance: \($tracker.distance.wrappedValue ?? 0)")
                            .font(Constants.TitleFont)
                            .foregroundColor(Color.white)

                        Text("Steps: \($tracker.steps.wrappedValue ?? 0)")
                            .font(Constants.TitleFont)
                            .foregroundColor(Color.white)

                    }
                    
                }
                
            }
            
        }
    }
    
    /*
     private struct DisplayView: View {
         @ObservedObject var tracker: Tracker
         
         var body: some View {
             HStack {
                 Text("steps: \($tracker.steps.wrappedValue ?? 0)")
                 Text("cadence: \($tracker.cadence.wrappedValue ?? 0, specifier: "%.3f")")
                 Text("distance: \($tracker.distance.wrappedValue ?? 0)")
                 /*
                 Text("intervals: \($tracker.intervals.wrappedValue)") //debug
                 Text("intervalsFailed: \($tracker.intervalsFailed.wrappedValue)") //debug
                 Text("positive: \($tracker.promptsPositive.wrappedValue)") //debug
                 Text("negative: \($tracker.promptsNegative.wrappedValue)") //debug
                 */
             }
         }
     }
     */
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView(cords: .constant([]))
    }
}
