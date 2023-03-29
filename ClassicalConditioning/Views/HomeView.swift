//
//  HomeView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI

struct HomeView: View {
    @State var anim = false
    @EnvironmentObject var madOrHappy : HappyOrMad
    
    var body: some View {
        ZStack{
            if madOrHappy.madHappy == false {
                Color.blue
                    .ignoresSafeArea()
            }
            else {
                Color.red
                    .ignoresSafeArea()

            }
                
            
            VStack {
                
               
                Spacer()
                Faces()
                Spacer()
                //TrackView()
                TestTrackerView()
                Spacer()
            

            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
