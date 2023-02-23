//
//  ContentView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/23/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        Button {
            let utterance = AVSpeechUtterance(string: "Hello world")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.6

            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        } label :  {
            Text("Push me")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
