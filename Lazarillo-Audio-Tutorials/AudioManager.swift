//
//  Playbacks.swift
//  Lazarillo-Audio-Tutorials
//
//  Created by Joanna Luberadzka on 24/8/25.
//

import Foundation
import AVFoundation


class AudioManager: ObservableObject{
    
    // --- initialize speech synthesizer class ---
    public var MySynthesizer = AVSpeechSynthesizer()
    
    // --- initialize empty basic audio player ---
    // (using ? is the way to initialize it without specific url - this is the standard way to
    // declare a basic audio player in a class when we don’t know the audio file at initialization time)
    public var MyAudioPlayer = AVAudioPlayer()
    
    // --- initialize audio engine and its nodes ---
    public var MyEngine = AVAudioEngine()
    public var MyAudioPlayerNode = AVAudioPlayerNode()
    public var MyEnvironmentNode = AVAudioEnvironmentNode()
    public var MyReverb = AVAudioUnitReverb()

    
    // ------ Function to play back audio from a file using Audio Engine ------
    func play_audio_file_in_space(filename: String, direction: Float) {
        
        // if the something is already playing back, stop it
        if MyAudioPlayerNode.isPlaying || MyAudioPlayer.isPlaying || MySynthesizer.isSpeaking{
            MySynthesizer.stopSpeaking(at: .immediate)
            MyAudioPlayerNode.stop()
            MyAudioPlayer.stop()
        }
        // set up audio engine
        MyEngine.attach(MyAudioPlayerNode)
        MyEngine.attach(MyEnvironmentNode)

        // Player -> Spatializer -> Output
        MyEngine.connect(MyAudioPlayerNode, to: MyEnvironmentNode, format: nil)
        MyEngine.connect(MyEnvironmentNode, to: MyEngine.mainMixerNode, format: nil)
    
        MyEngine.mainMixerNode.outputVolume = 1

        MyAudioPlayerNode.pan = 0
        
        do {
            try MyEngine.start()
        } catch {
            print("Error starting engine: \(error)")
        }
        
        // Place listener at the origin (looking to the front)
        MyEnvironmentNode.listenerPosition = AVAudio3DPoint(x: 0, y: 0, z: 0)
        MyEnvironmentNode.listenerAngularOrientation = AVAudio3DAngularOrientation(
           yaw: 0, pitch: 0, roll: 0)
        
        // Place source in the environment
        let radians = direction * .pi / 180
        let x = cos(radians) * 2.0
        let z = sin(radians) * 2.0
        MyAudioPlayerNode.position = AVAudio3DPoint(x: x, y: 0, z: z)
        
        // guard let ... else { ... return } =
        // if either the URL or audio file could not be created, stop and exit the function
        guard let url = Bundle.main.url(forResource: filename, withExtension: ".wav"),
              let audioFile = try? AVAudioFile(forReading: url) else {
            print("File not found: \(filename)")
            return
        }
        
        do {
            try MyEngine.start()
            MyAudioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
            MyAudioPlayerNode.play()
            print("Playing \(filename) at direction \(direction) deg")
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    func play_audio_file_with_reverb(filename: String, wetdry: Float) {
        
        // if the something is already playing back, stop it
        if MyAudioPlayerNode.isPlaying || MyAudioPlayer.isPlaying || MySynthesizer.isSpeaking{
            MySynthesizer.stopSpeaking(at: .immediate)
            MyAudioPlayerNode.stop()
            MyAudioPlayer.stop()
        }
        
        // set up audio engine
        MyEngine.attach(MyAudioPlayerNode)
        MyEngine.attach(MyReverb)

        // Player -> Reverb -> Output
        MyEngine.connect(MyAudioPlayerNode, to: MyReverb, format: nil)
        MyEngine.connect(MyReverb, to: MyEngine.mainMixerNode, format: nil)
    
        MyEngine.mainMixerNode.outputVolume = 1
        
        MyAudioPlayerNode.pan = 0
        
        do {
            try MyEngine.start()
        } catch {
            print("Error starting engine: \(error)")
        }
        
        // Configure reverb node
        MyReverb.loadFactoryPreset(.mediumRoom)
        MyReverb.wetDryMix = wetdry // percentage of effect applied
        
        // guard let ... else { ... return } =
        // if either the URL or audio file could not be created, stop and exit the function
        guard let url = Bundle.main.url(forResource: filename, withExtension: ".wav"),
              let audioFile = try? AVAudioFile(forReading: url) else {
            print("File not found: \(filename)")
            return
        }
        
        do {
            try MyEngine.start()
            MyAudioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
            MyAudioPlayerNode.play()
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    func play_audio_file_panned(filename: String, direction: Float) {
        
        // if the something is already playing back, stop it
        if MyAudioPlayerNode.isPlaying || MyAudioPlayer.isPlaying || MySynthesizer.isSpeaking{
            MySynthesizer.stopSpeaking(at: .immediate)
            MyAudioPlayerNode.stop()
            MyAudioPlayer.stop()
        }
        
        // set up audio engine
        MyEngine.attach(MyAudioPlayerNode)

        // Player (with panning) -> Output
        MyEngine.connect(MyAudioPlayerNode, to: MyEngine.mainMixerNode, format: nil)
    
        MyEngine.mainMixerNode.outputVolume = 1
        
        do {
            try MyEngine.start()
        } catch {
            print("Error starting engine: \(error)")
        }
        
        // Panning with 2 cardioids
        let radians_R=direction-40.0*(.pi/180);
        let radians_L=direction+40.0*(.pi/180);
        // compute gain for left and right
        let G_R=abs(1/2*(1+cos(radians_R)));
        let G_L=abs(1/2*(1+cos(radians_L)));
        print("gain")
        print(G_R)
        print(G_L)
        // normalized gain [0,1]
        let G_R_norm=G_R/(G_R+G_L)
        let G_L_norm=G_L/(G_R+G_L)
        print("gain norm")
        print(G_R_norm)
        print(G_L_norm)
        // panning parameter [-1,1]
        let panLR=G_R_norm-G_L_norm
        
        // Left/Right Panning
        MyAudioPlayerNode.pan = panLR

        // guard let ... else { ... return } =
        // if either the URL or audio file could not be created, stop and exit the function
        guard let url = Bundle.main.url(forResource: filename, withExtension: ".wav"),
              let audioFile = try? AVAudioFile(forReading: url) else {
            print("File not found: \(filename)")
            return
        }
        
        do {
            try MyEngine.start()
            MyAudioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
            MyAudioPlayerNode.play()
        } catch {
            print("Error: \(error)")
        }
    }

    // ------ Function to synthesize and play back speech ------
    func synth_and_play_speech(text: String) {
        
        // if the something is already playing back, stop it
        if MyAudioPlayerNode.isPlaying || MyAudioPlayer.isPlaying || MySynthesizer.isSpeaking{
            MySynthesizer.stopSpeaking(at: .immediate)
            MyAudioPlayerNode.stop()
            MyAudioPlayer.stop()
        }

        // Create the utterance
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5   // speed (0.0 = slow, 1.0 = fast)
        utterance.pitchMultiplier = 1.0

        // Speak it
        MySynthesizer.speak(utterance)
    }
    
    
    // ------ Function to play back audio from a file ------
    func play_audio_file(filename: String) {
        
        // if the player is already playing back something, stop it
        if MyAudioPlayer.isPlaying {
            MyAudioPlayer.stop()
        }
                
        if let soundPath = Bundle.main.path(forResource: filename, ofType: "wav") {
            let url = URL(fileURLWithPath: soundPath)
            do {
                // Fill MyAudioPlayer with a specific audio url
                MyAudioPlayer = try AVAudioPlayer(contentsOf: url)
                // Playback
                MyAudioPlayer.prepareToPlay() //optional, to reduce latency
                MyAudioPlayer.play()
            } catch {
                print("Error loading or playing clip: \(error)")
            }
        } else {
            print("Audio file \(filename).wav not found in bundle.")
        }
    }
    
    
    
}
