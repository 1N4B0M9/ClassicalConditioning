//
//  Constants.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 3/1/23.
//

import Foundation
import SwiftUI


extension Color {
    
     static let DarkBlue = Color("Dark Blue")
/*
     static let LightBlue = Color("Light Blue")

     static let LightGreen = Color("Light Green")
 

     */
    static let customRed = Color("customRed")
    static let customBlue = Color("customBlue")

    
}

struct Constants {
    static let TitleFont : Font = Font(UIFont(name: "HelveticaNeue-Bold", size: 25) ?? UIFont.systemFont(ofSize: 35))
    static let textFont : Font = Font(UIFont(name: "Space Grotesk", size: 16) ?? UIFont.systemFont(ofSize: 18))
    static let HeaderFont : Font = Font(UIFont(name: "Space Grotesk", size: 18) ?? UIFont.systemFont(ofSize: 25))

       
}
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

/**
 A wrapper class used to store a boolean in the form of an enviromental object
 */
class HappyOrMad : ObservableObject {
    @Published var madHappy : Bool = false
}

/**
 A wrapper class used to store a boolean in the form of an enviromental object
 */
class onOrOff : ObservableObject {
    @Published var oof : Bool = false
}

