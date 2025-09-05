//
//  HomeportTut.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import SwiftUI

struct BasicAudio: View {
    
    // initialize AudioManager class (contains my functions for playback)
    @StateObject private var audioManager = AudioManager()
    
    // initialize string that will be printed while the synthesizer is speaking
    @State private var text_to_speak: String = ""
    
    // initialize var for audio file name to play
    @State private var myaudiofilename: String = ""
    
    // initialize var for direction of arrival of the source
    @State private var mydirection: Float = 0.0
    
    // initialize var for reverb wetdry parameter
    @State private var mywetdry: Float = 0.0
    
    // initialize var for reverb wetdry parameter
    @State private var sectionplaying: String = ""
    
    
    var body: some View {
        
        VStack {
            Text("Basic audio functions")
            playFileSection
            playReverbSection
            playSpatialSection
            playPannedSection
            ttsSection
        }
    }
    
    
    // ---------- playFileSection ----------
    var playFileSection: some View {
        VStack {
            
            Button(action: {
                
                myaudiofilename="speech_sample"
                audioManager.play_audio_file(filename: myaudiofilename)
                sectionplaying="playFileSection"
                
            }) {
                Text("Play audio from file")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if sectionplaying=="playFileSection" {
                Text("Playing back: \(myaudiofilename).wav ")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    // ---------- playReverbSection ----------
    var playReverbSection: some View {
        VStack {
            
            Button(action: {
                mywetdry=Float.random(in: 0...100)
                myaudiofilename="speech_sample"
                audioManager.play_audio_file_with_reverb(filename: myaudiofilename, wetdry: mywetdry)
                sectionplaying="playReverbSection"
            }) {
                Text("Play audio from file with reverb")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if sectionplaying=="playReverbSection"  {
                Text("Playing back: \(myaudiofilename).wav with wetdry mix \(Int(mywetdry)) %")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    // ---------- playSpatialSection ----------
    var playSpatialSection: some View {
        VStack {
            
            Button(action: {
                mydirection=Float.random(in: 0...360)
                myaudiofilename="speech_sample"
                audioManager.play_audio_file_in_space(filename: myaudiofilename, direction: mydirection)
                sectionplaying="playSpatialSection"
            }) {
                Text("Play spatialized audio file")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if sectionplaying=="playSpatialSection" {
                Text("Playing back: \(myaudiofilename).wav with DOA of \(Int(mydirection)) deg")
                    .padding()
                    .multilineTextAlignment(.center)
            }
            
        }
    }
    
    // ---------- playPannedSection ----------
    var playPannedSection: some View {
        VStack {
            
            Button(action: {
                mydirection=Float.random(in: 0...360)
                myaudiofilename="speech_sample"
                audioManager.play_audio_file_panned(filename: myaudiofilename, direction: mydirection)
                sectionplaying="playPannedSection"
            }) {
                Text("Play panned audio file")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if  sectionplaying=="playPannedSection"  {
                Text("Playing back: \(myaudiofilename).wav with DOA of \(Int(mydirection)) deg")
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    // ---------- ttsSection ----------
    var ttsSection: some View {
        VStack {
            
            Button(action: {
                // pick random direction & distance
                let hour = (Int((Float.random(in: 0...360)/30).rounded())-1) % 12 + 1
                let distance = Int.random(in: 1...300)
                
                // generate and play spoken text
                text_to_speak="Waypoint at \(hour) o’clock, \(distance) meters away"
                
                audioManager.synth_and_play_speech(text: text_to_speak)
                sectionplaying="ttsSection"

            }) {
                Text("TTS - synth and play")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if sectionplaying=="ttsSection"{
                Text("Spoken: \(text_to_speak)")
                    .padding()
                    .multilineTextAlignment(.center)
            }
            
        }
    }
    
}
    
    
    
