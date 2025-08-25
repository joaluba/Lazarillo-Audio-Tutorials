//
//  Waypoint.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import SwiftUI

// Screens defined in the same file
struct WaypointTut: View {
    var body: some View {
        VStack {
            Text("Waypoint tutorial\n")
            Text("Demo of the sonification for waypoints")
            
            Button(
                action:{ PlayWaipointInfo()
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
        }
    }
}
