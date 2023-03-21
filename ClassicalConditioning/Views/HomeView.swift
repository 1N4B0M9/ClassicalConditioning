//
//  HomeView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI

struct HomeView: View {
    @State var anim = false
    var hkManager = HealthKitManager()

    
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
                Button {
                    hkManager.authorizeHealthKit { (authorized, error) in
                          
                      guard authorized else {
                            
                        let baseMessage = "HealthKit Authorization Failed"
                            
                        if let error = error {
                          print("\(baseMessage). Reason: \(error.localizedDescription)")
                        } else {
                          print(baseMessage)
                        }
                            
                        return
                      }
                          
                      print("HealthKit Successfully Authorized.")
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
