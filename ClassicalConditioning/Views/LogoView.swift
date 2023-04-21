import SwiftUI

struct LogoView: View {
    @State private var isFlipped = false
    @State private var bounceEffect: CGFloat = 1.0
    @State private var verticalOffset: CGFloat = 0
    @EnvironmentObject var madOrHappy: HappyOrMad
    @State private var coolor = false
    @EnvironmentObject var onoff: onOrOff

    
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 350, height: 350, alignment: .center)
                //.shadow(color: .black, radius: 5, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)

            Image($madOrHappy.madHappy.wrappedValue ? "happy" : "mad")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 400)
                .foregroundColor(coolor ? .yellow : .red)
                .rotation3DEffect(
                    .degrees(isFlipped ? 360 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .scaleEffect(bounceEffect)
                .offset(y: verticalOffset)
                .onTapGesture {
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 70, damping: 10, initialVelocity: 0)) {
                        isFlipped.toggle()
                        coolor.toggle()
                    }
                    withAnimation(.easeInOut(duration: 0.3)) {
                        bounceEffect = 1.1
                        verticalOffset -= 40
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            bounceEffect = 1.0
                            verticalOffset += 40
                        }
                    }
                    if onoff.oof == false {
                        madOrHappy.madHappy.toggle()
                    }
                }
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView().environmentObject(HappyOrMad())
    }
}
