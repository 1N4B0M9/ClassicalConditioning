//
//  HomeView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI

struct HomeView: View {
    @State var anim = false
    @ObservedObject var hkManager = HealthKitManager()

    
    var body: some View {
        ZStack{
            Color.red
                .ignoresSafeArea()
            
            VStack {
                
               
                Spacer()
                Faces()
                Spacer()
                TrackView()
               // TestTrackerView()
                Spacer()
                Button {
                    if hkManager.isActive == false {
                        hkManager.requestAccess()
                        
                    }
                    else {
                        hkManager.getWalk()
                    }
                } label: {
                    Text("PRESS ME")
                }
            

            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
