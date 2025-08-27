//
//  ContentView.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.


import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Audio Tutorials for Capitan Lazarillo")
                    .font(.title)
                
                NavigationLink("Basic Audio", destination: BasicAudio())
                NavigationLink("Waypoint tutorial", destination: WaypointTut())
                NavigationLink("Wind tutorial", destination: WindTut())
                NavigationLink("Relative bearing tutorial", destination: RelbearTut())
                NavigationLink("Home port tutorial", destination: HomeportTut())
                NavigationLink("Obstacles tutorial", destination: ObstacleTut())
                
            }
            .navigationTitle("Home")
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
