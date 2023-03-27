//
//  InformationView.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/2/23.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack {
            
            Button {
                Sound.instance.play(sound: .m2)
            } label: {
                Text("BAKOKOAKAKAKAKwoAMksczx")
                    .font(.largeTitle)
                    
            }
            
            
        TestRunDisplay()
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
