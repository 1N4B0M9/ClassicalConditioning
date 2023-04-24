//
//  LocationRequestView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/14/23.
//

import SwiftUI

/**
 A view used to request location permissions from the user
 */
struct LocationRequestView: View {
    @EnvironmentObject var madOrHappy : HappyOrMad

    var body: some View {
        ZStack {
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
                Button {
                    LocationManager.shared.requestLocation()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
                                        .frame(height: 80)
                                        .padding(20)

                        Text("Share Your Location to Track Your Runs")
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color.black)
                            
                    }
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
