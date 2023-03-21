//
//  LocationRequestView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/14/23.
//

import SwiftUI

struct LocationRequestView: View {
    @ObservedObject var hkManager = HealthKitManager()
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            VStack {
                Button{
                    LocationManager.shared.requestLocation()

                } label : {
                    Text("Allow Location")
                        .padding()
                        .font(.headline)
                    
                }
                Button{
                    
                } label : {
                    Text("Maybe Later")
                }
            }
            
           
        }
    }
}

struct LocationRequestView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRequestView()
    }
}
