//
//  Wind.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import SwiftUI

struct WindTut: View {
    var body: some View {
        VStack {
            Text("Wind tutorial")
            Text("Demo of the sonification for wind info")
            
        Button(
                action:{
                }, label:{
                    Image("wind")
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
