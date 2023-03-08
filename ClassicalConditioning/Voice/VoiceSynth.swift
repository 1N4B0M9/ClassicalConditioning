//
//  VoiceSynth.swift
//  ClassicalConditioning
//
//  Created by Nathan Morelli (student LM) on 2/28/23.
//

import Foundation
import AVFoundation

class AudioPlayer {
    var player: AVAudioPlayer?
    
    func playAudio() {
        guard let path = Bundle.main.path(forResource: "audio", ofType: "mp3") else {
            print("Audio file not found!")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error playing audio file: \(error.localizedDescription)")
        }
    }
}

// To play the audio, simply call the playAudio() method of the AudioPlayer class:

