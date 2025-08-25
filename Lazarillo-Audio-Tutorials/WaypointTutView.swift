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
    @State private var lastUtterance: String = ""
    
    
    var body: some View {
        VStack {
            Text("Waypoint tutorial\n")
            Text("Demo of the sonification for waypoints")
            
            // Example pool of directions
            let directions = ["one o’clock", "two o’clock", "three o’clock", "five o’clock", "six o’clock", "twelve o’clock"]
            
            Button(
                
                action:{
                    // Pick random direction & distance
                    let direction = directions.randomElement() ?? "three o’clock"
                    let distance = Int.random(in: 100...500)

                    // Play & save spoken text
                    lastUtterance = audioManager.playWaypointInfo(direction: direction, distance: distance)
                }, label:{
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
            
            if !lastUtterance.isEmpty {
                Text("Spoken: \(lastUtterance)")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
}
