//
//  ContentView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/23/23.
//

import SwiftUI
import AVFoundation
import CoreMotion
struct ContentView: View {
    @State private var isAnimating = false
    @State private var coolor = false

    var body: some View {
        //voice   
        /*
        Button {
            let utterance = AVSpeechUtterance(string: "Hello world")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.6

            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        } label :  {
            Text("Push me")
            
        }
        */
        VStack {
            //coin flip
            TestTrackerView()
            Button {
                isAnimating = true
                coolor = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isAnimating = false
                }
                } label :  {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(coolor ? .yellow : .red)
                    .rotation3DEffect(
                        .degrees(isAnimating ? 360 : 0),
                        axis: (x: 1.0, y: 0.0, z: 0.0))
                    .animation(.easeInOut(duration: 0.5))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
