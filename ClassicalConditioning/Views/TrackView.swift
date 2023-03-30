//
//  TrackView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/28/23.
//

import SwiftUI

struct TrackView: View {
    @State var playORStop = false
    @State var tracker: Tracker?

    var body: some View {
        
        HStack {
            Button {
                if playORStop == false {
                    playORStop = true
                    if tracker == nil {
                        tracker = Tracker()
                    }
                }
                else {
                    playORStop = false
                    if let tracker = tracker {
                        tracker.stop()
                        self.tracker = nil
                    }
                }
                
                
            } label: {
                if playORStop == false {
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

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}
