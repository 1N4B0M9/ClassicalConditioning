//
//  InformationView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI

struct InformationView: View {
    @EnvironmentObject var madOrHappy : HappyOrMad

    var body: some View {
        ZStack {
            if madOrHappy.madHappy == false {
               // RadialGradient(gradient: Gradient(colors: [.white, .red]), center: .center, startRadius: 2, endRadius: 650)
                Color.customRed
                    .ignoresSafeArea()
                
            }
            else {
               // RadialGradient(gradient: Gradient(colors: [.white, .blue]), center: .center, startRadius: 2, endRadius: 650)
                
                Color.customBlue
                    .ignoresSafeArea()

            }
            
                
            VStack {
            TestRunDisplay()
            }
        }
        .animation(Animation.easeInOut.speed(0.25), value : madOrHappy.madHappy)
        
        
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
