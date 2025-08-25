//
//  Playbacks.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import Foundation
import AVFoundation



class AudioManager{
    
    // in a simplest case the utterance can be played through synthesizer.speak()
    private let synthesizer = AVSpeechSynthesizer()
    
    // but in this case we want the utterance to go through spatialization module
    // for that we need to access the speech buffer and route it to the audio engine
    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private let environment = AVAudioEnvironmentNode()
    
    // ----- initialization of the audio engine -----
    init() {
        engine.attach(player)
        engine.attach(environment)

        // Connect player → environment → output
        engine.connect(player, to: environment, format: nil)
        engine.connect(environment, to: engine.outputNode, format: nil)

        // parameters of the spatialization (environment) node
        environment.listenerPosition = AVAudio3DPoint(x: 0, y: 0, z: 0) // listener at origin
        environment.listenerAngularOrientation = AVAudio3DAngularOrientation(yaw: 0, pitch: 0, roll: 0)

        do {
            try engine.start()
        } catch {
            print("AudioEngine failed to start: \(error)")
        }
    }

    func playWaypointInfo(direction: String, distance: Int)  -> String {
        
        if synthesizer.isSpeaking{
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        if player.isPlaying {
            player.stop()
        }
        
        // Build the spoken text
        let text = "Waypoint at \(direction), \(distance) meters away"

        // Create the utterance
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5   // speed (0.0 = slow, 1.0 = fast)
        utterance.pitchMultiplier = 1.0

        // Speak it
        synthesizer.speak(utterance)
        
        return text
        
    }
}
