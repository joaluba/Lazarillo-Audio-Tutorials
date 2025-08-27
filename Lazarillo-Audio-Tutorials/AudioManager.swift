//
//  Playbacks.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import Foundation
import AVFoundation

class AudioManager{
    
    // --- initialize speech synthesizer class ---
    private var MySynthesizer = AVSpeechSynthesizer()
    
    // --- initialize empty basic audio player ---
    // (using ? is the way to initialize it without specific url - this is the standard way to
    // declare a basic audio player in a class when we don’t know the audio file at initialization time)
    private var MyAudioPlayer: AVAudioPlayer? = nil
    
    // --- initialize audio engine and its nodes ---
    private let MyEngine = AVAudioEngine()
    private let MyAudioPlayerNode = AVAudioPlayerNode()
    private let MyEnvironmentNode = AVAudioEnvironmentNode()
    
    

    // ------ Function to synthesize and play back speech ------
    func synth_and_play_speech(text: String) {
        
        // if the synth is already playing back something, stop it
        if MySynthesizer.isSpeaking{
            MySynthesizer.stopSpeaking(at: .immediate)
        }

        // Create the utterance
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5   // speed (0.0 = slow, 1.0 = fast)
        utterance.pitchMultiplier = 1.0

        // Speak it
        MySynthesizer.speak(utterance)
    }
    
    
    // ------ Function to play back audio from a file ------
    func play_audio_file(filename: String) {
        if let soundPath = Bundle.main.path(forResource: filename, ofType: "wav") {
            let url = URL(fileURLWithPath: soundPath)
            do {
                // Fill MyAudioPlayer with a specific audio url
                MyAudioPlayer = try AVAudioPlayer(contentsOf: url)
                // Playback
                MyAudioPlayer?.prepareToPlay() //optional, to reduce latency
                MyAudioPlayer?.play()
            } catch {
                print("Error loading or playing clip: \(error)")
            }
        } else {
            print("Audio file \(filename).wav not found in bundle.")
        }
    }
    
    
    
    
    
}
