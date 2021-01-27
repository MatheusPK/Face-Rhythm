//
//  AudioManager.swift
//  midiTest_21-01
//
//  Created by Theo Necyk Agner Caldas on 25/01/21.
//

import Foundation
import AVFoundation

class AudioManager{
    
    private let engine = AVAudioEngine()
    private let speedControl = AVAudioUnitVarispeed()
    private let pitchControl = AVAudioUnitTimePitch()
    private let audioPlayerNode = AVAudioPlayerNode()
    
    private var singleNoteFile = AVAudioFile()
    
    private var musicAudioPlayer = AVAudioPlayer()
    
    static let singleInstance = AudioManager()
    
    private init(){
        do{
            try self.loadEngine()
        }catch{
            print("Erro ao carregar Engine!", #function)
        }
        self.loadPlayer()
    }
    
    private func loadEngine() throws{
        if let note = Bundle.main.url(forResource: "C3", withExtension: ".mp3"){
            self.singleNoteFile = try AVAudioFile(forReading: note)
        }
        else{
            print("Arquivo não encontrado!", #function)
        }
            
        engine.attach(audioPlayerNode)
        engine.attach(pitchControl)
        engine.attach(speedControl)
        
        engine.connect(audioPlayerNode, to: speedControl, format: nil)
        engine.connect(speedControl, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
        
        audioPlayerNode.volume = 3
        try engine.start()
    }
    
    private func loadPlayer(){
        do{
            if let mp3File = Bundle.main.url(forResource: LevelRules.currentLevel().fileName, withExtension: ".mp3"){
                self.musicAudioPlayer = try AVAudioPlayer(contentsOf: mp3File)
            }else{
                print("Arquivo mp3 nao encontrado!")
                return
            }
        }catch{
            print("Impossivel carregar AVAudioPlayer!")
            return
        }
    }
    
    public func playNote(note: UInt8){
        let midiNumberC4 = 60
        self.pitchControl.pitch = Float(100*(Int(note) - midiNumberC4))
        self.audioPlayerNode.scheduleFile(singleNoteFile, at: nil, completionHandler: nil)
        self.audioPlayerNode.play()
    }
    
    public func stopNote(){
        self.audioPlayerNode.stop()
    }
    
    public func playMusic(){
        self.musicAudioPlayer.prepareToPlay()
        self.musicAudioPlayer.play()
    }
    
    public func getMusicTimeStamp() -> TimeInterval{
        return self.musicAudioPlayer.currentTime
    }
    
    
    
    
}
