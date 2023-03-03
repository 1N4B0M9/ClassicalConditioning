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
    init() {
   // UITabBar.appearance().backgroundColor = UIColor.red
        

    }

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
        ZStack {
            Color.DarkBlue
                .ignoresSafeArea()
            TabView {
                MapView()
                    .tabItem {
                        Image(systemName: "mappin" )
                    }
                HomeView()
                    .tabItem {
                        Image(systemName: "house" )

                    }
            
            
                InformationView()
                    .tabItem {
                        Image(systemName: "info")
                    }
            }
            .background(Color.red)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
