//
//  ClassicalConditioningApp.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/23/23.
//

import SwiftUI

/**
 The main class of the app
 */
@main
struct ClassicalConditioningApp: App {
    @StateObject var madOrHappy : HappyOrMad = HappyOrMad()
    @StateObject var onoff : onOrOff = onOrOff()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(madOrHappy)
                .environmentObject(onoff)
        }
    }
}
