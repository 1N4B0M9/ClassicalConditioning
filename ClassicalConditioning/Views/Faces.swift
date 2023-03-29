//
//  Faces.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/1/23.
//

import SwiftUI

struct Faces: View {
    @State private var isAnimating = false
    @State private var coolor = false
    @EnvironmentObject var madOrHappy : HappyOrMad
    var body: some View {
        VStack {
            //coin flip
            Button {
                isAnimating = true
                coolor = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isAnimating = false
                }
                if madOrHappy.madHappy == false {
                    madOrHappy.madHappy = true
                }
                else {
                    madOrHappy.madHappy = false
                }


                } label :  {
                    Image(madOrHappy.madHappy == false ? "mad" : "happy")
                    .resizable()
                    .frame(width: 450, height: 450)
                    .foregroundColor(coolor ? .yellow : .red)
                    .rotation3DEffect(
                        .degrees(isAnimating ? 360 : 0),
                        axis: (x: 1.0, y: 0.0, z: 0.0))
                    .animation(.easeInOut(duration: 0.5))
            }
        }
    }
}

struct Faces_Previews: PreviewProvider {
    static var previews: some View {
        Faces()
    }
}
