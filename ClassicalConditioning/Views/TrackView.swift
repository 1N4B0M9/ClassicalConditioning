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
            HStack {
                Button {
                    if onoff.oof == false {
                        onoff.oof = true
                        if tracker == nil {
                            tracker = Tracker(happyOrMad: happyOrMad)
                        }
                    }
                    else {
                        onoff.oof = false
                        if let tracker = tracker {
                            tracker.stop(cords)
                            locup.stop()
                            self.tracker = nil
                        }
                    }
                    Sound.instance.play(false)
                    
                } label: {
                    if onoff.oof == false {
                        Image(systemName: "play.fill")
                            .frame(width: 50, height: 50)
                    }
                    else {
                        Image(systemName: "pause.circle.fill")
                            .frame(width: 50, height: 50)

                    }
                }
                Spacer()
            }
            .frame(width: UIScreen.screenWidth-30, height: 100)
            .border(.gray, width: 4)
            .cornerRadius(10)
        }
    }
    
    private struct DisplayView: View {
        @ObservedObject var tracker: Tracker
        
        var body: some View {
            Text($tracker.timeSince.wrappedValue)
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
