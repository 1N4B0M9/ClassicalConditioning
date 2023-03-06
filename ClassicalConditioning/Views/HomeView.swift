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
                Button {
                    anim = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        anim = false
                    }
                    } label :  {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.yellow)
                        .rotation3DEffect(
                            .degrees(anim ? 360 : 0),
                            axis: (x: 1.0, y: 0.0, z: 0.0))
                        .animation(.easeInOut(duration: 0.5))
                }
                Spacer()
                Faces()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
