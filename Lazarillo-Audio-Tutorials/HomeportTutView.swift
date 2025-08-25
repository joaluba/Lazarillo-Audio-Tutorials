//
//  HomeportTut.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import SwiftUI

struct HomeportTut: View {
    var body: some View {
        VStack {
            Text("Homeport tutorial")
            Text("Demo of the waypoint sonification")
            
            Button(
                action:{
                }, label:{
                    Image("homeport")
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
