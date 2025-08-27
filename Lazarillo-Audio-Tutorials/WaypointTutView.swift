//
//  Waypoint.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import SwiftUI


struct WaypointTut: View {
    
    // initialize AudioManager class (contains my functions for playback)
    let audioManager = AudioManager()
    
    // string that will be printed while the synthesizer is speaking
    @State private var text_to_speak: String = ""
    
    
    var body: some View {
        VStack {
            Text("Waypoint tutorial\n")
            Text("Demo of the sonification for waypoints")
            
            Button(
                
                action:{
                    // pick random direction & distance
                    let hour = (Int((Float.random(in: 0...360)/30).rounded())-1) % 12 + 1
                    let distance = Int.random(in: 1...300)
                    
                    // generate and play spoken text
                    text_to_speak="Waypoint at \(hour) o’clock, \(distance) meters away"
                    audioManager.synth_and_play_speech(text: text_to_speak)
                },
                label:{
                    Image("waypoint")
                        .resizable()
                        .scaledToFit()
                        .frame(height:100)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.black,lineWidth: 4))
                }
            )
            
            Text("Press to start demo")
            
            if !text_to_speak.isEmpty {
                Text("Spoken: \(text_to_speak)")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
}
