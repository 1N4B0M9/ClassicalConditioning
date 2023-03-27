//
//  HomeView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI

struct HomeView: View {
    @State var anim = false

    
    var body: some View {
        ZStack{
            Color.red
                .ignoresSafeArea()
            
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
