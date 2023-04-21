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
    @State private var selectedTab = 1

    init() {
     //   UITabBar.appearance().backgroundColor = UIColor.red
    //    UITabBar.appearance().barTintColor = .black

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
            
               // .onAppear() {
                
                    

               // }
            
            
            TabView(selection: $selectedTab) {
                MapView()
                    .tabItem {
                        Image(systemName: "mappin" )
                    }
                        .tag(0)

                
                HomeView()
                    .tabItem {
                        Image(systemName: "house" )
                    }
                        .tag(1)
            
            
                InformationView()
                    .tabItem {
                        Image(systemName: "info")
                    }
                    .tag(2)
            }
           // .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
                


            
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
