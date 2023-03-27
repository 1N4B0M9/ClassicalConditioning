//
//  VoiceSynth.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/28/23.
//
import SwiftUI
import AVFoundation
import CoreMotion
import Foundation
import AVKit

class Sound {
    
    static let instance = Sound()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case v1
        case m1
        case m2
        case m3
        case m4
        case m5
    }
    
    private init() {}
    
    func play(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

// Use  Sound.instance.play(sound: .v1) to play the sound. Replace v1 with the name of the sound you're using.
// add sounds you want to use with the exact name in the the SoundOption enum
