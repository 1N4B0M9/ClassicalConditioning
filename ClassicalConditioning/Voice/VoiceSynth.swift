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
    
    private var player: AVAudioPlayer?
    private var lastSound: SoundOption?
    
    enum SoundOption: String {
        case v1, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15, h16
    }
    
    private init() {}
    
    func play(_ happyOrMad: Bool) {
        print("play audio") //debug
        let audio = self.randomSound(happyOrMad: happyOrMad)
        
        
        guard let url = Bundle.main.url(forResource: audio.rawValue, withExtension: ".mp3") else {
            print("could not find file")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
            if player == nil {
                print("player is null") //debug
            }
            
            self.lastSound = audio
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        print("audio played") //debug
    }
    
    func randomSound(happyOrMad: Bool) -> SoundOption {
        let prefix = happyOrMad ? "h" : "m"
        var index = Int.random(in: 1...16)
        let raw = {
            prefix + String(index)
        }
        
        while (raw() == self.lastSound?.rawValue) {
            index = Int.random(in: 1...16)
        }
        
        return SoundOption.init(rawValue: raw())!
    }
}

// Use  Sound.instance.play(sound: .v1) to play the sound. Replace v1 with the name of the sound you're using.
// add sounds you want to use with the exact name in the the SoundOption enum
