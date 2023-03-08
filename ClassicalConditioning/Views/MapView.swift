//
//  MapView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI

struct MapView: View {
    @State var playORStop = false
    var body: some View {
        HStack {
            
            Button {
                if playORStop == false {
                    playORStop = true
                }
                else {
                    playORStop = false

                }
                let audioPlayer = AudioPlayer()
                audioPlayer.playAudio()
                
                
            } label: {
                if playORStop == false {
                    Image(systemName: "play.fill")
                }
                else {
                    Image(systemName: "pause.circle.fill")
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
