//
//  Playbacks.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import Foundation
import AVFoundation



class Playbacks {
    private let synthesizer = AVSpeechSynthesizer()

    func playWaypointInfo(direction: String, distance: Int) {
        // Build the spoken text
        let text = "Waypoint at \(direction), \(distance) meters away"

        // Create the utterance
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5   // speed (0.0 = slow, 1.0 = fast)
        utterance.pitchMultiplier = 1.0

        // Speak it
        synthesizer.speak(utterance)
    }
}
