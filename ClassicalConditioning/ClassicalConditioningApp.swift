//
//  ClassicalConditioningApp.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/23/23.
//

import SwiftUI

@main
struct ClassicalConditioningApp: App {
    @StateObject var madOrHappy : HappyOrMad = HappyOrMad()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(madOrHappy)
        }
    }
}
