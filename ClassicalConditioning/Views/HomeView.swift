//
//  HomeView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI

struct HomeView: View {
    @State private var anim = false
    @EnvironmentObject var madOrHappy : HappyOrMad
    @ObservedObject var locup = LocationUpdates()
    @EnvironmentObject var onoff : onOrOff
    var body: some View {
        ZStack{
            
            if madOrHappy.madHappy == false {
               // RadialGradient(gradient: Gradient(colors: [.white, .red]), center: .center, startRadius: 2, endRadius: 650)
                LinearGradient(gradient: Gradient(colors: [.customRed, .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                

                //Color.red
                
            }
            else {
               // RadialGradient(gradient: Gradient(colors: [.white, .blue]), center: .center, startRadius: 2, endRadius: 650)
                
              //  Color.blue
                LinearGradient(gradient: Gradient(colors: [.customBlue, .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                    .ignoresSafeArea()

            }
            
                
            
            VStack {
                
               
                Spacer()
                LogoView()
                Spacer()
                TrackView(cords: $locup.coord, onoff: _onoff)
                Spacer()
            

            }
        }
        .animation(Animation.easeInOut.speed(0.25), value : madOrHappy.madHappy)
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
