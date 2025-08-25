//
//  Bearing.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import SwiftUI

struct RelbearTut: View {
    var body: some View {
        VStack {
            Text("Relative bearing tutorial")
            Text("Demo of the sonification for relative bearing")
            
            
        Button(
                action:{
                }, label:{
                    Image("bearing")
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
