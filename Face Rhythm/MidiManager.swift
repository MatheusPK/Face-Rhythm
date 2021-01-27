//
//  MidiManager.swift
//  midiTest_21-01
//
//  Created by Theo Necyk Agner Caldas on 25/01/21.
//

import Foundation
import AVFoundation

protocol MidiManagerDelegate{
    func noteOn(note: UInt8)
    func noteOff()
    func changeTurn()
}

class MidiManager{
    
    private let midiData = MidiData()
    private var delegates = [MidiManagerDelegate]()
    
    static let singleInstance = MidiManager()
    
    private init(){
        self.loadFile()
    }
    
    public func addDelegate(delegate: MidiManagerDelegate){
        self.delegates.append(delegate)
    }
    
    private func loadFile(){
        guard let midiFile = Bundle.main.url(forResource: LevelRules.currentLevel().fileName, withExtension: ".mid") else{
            print("Impossivel carregar arquivo Midi!")
            return
        }
        
        guard let data = try? Data(contentsOf: midiFile) else {
            print("Impossivel converter pro tipo Data!")
            return
        }
        
        self.midiData.load(data: data)
        
//        print("BPM: \(self.midiData.beatsPerMinute.value)")
    }
    
    public func startCheckingNotesAndTurns(){
        let _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime(){
        self.checkTurn()
        self.checkNoteOn()
    }
    
    private func checkNoteOn() {
        let track = self.midiData.noteTracks[0]
        
        for note in track{
            if note.timeStamp.getTimeInSeconds().roundTo(places: 2) == AudioManager.singleInstance.getMusicTimeStamp().roundTo(places: 2){
                
                for delegate in self.delegates{
                    delegate.noteOn(note: note.note)
                }
                
                let _ = Timer.scheduledTimer(timeInterval: note.duration.getTimeInSeconds(), target: self, selector: #selector(scheduleNoteOff), userInfo: nil, repeats: false)
            }
        }
    }
    
    private func checkTurn(){
        let currentTimeStamp = AudioManager.singleInstance.getMusicTimeStamp().roundTo(places: 2)
        let barDuration: Double = Double(self.midiData.beatsPerMinute.value)/60.0
        let multiple = barDuration * LevelRules.currentLevel().barsInOneTurn
        if  currentTimeStamp.truncatingRemainder(dividingBy: multiple) - LevelRules.currentLevel().startingBar == .zero{
            for delegate in self.delegates{
                delegate.changeTurn()
            }
        }
    }
    
    @objc private func scheduleNoteOff(){
        for delegate in self.delegates{
            delegate.noteOff()
        }
    }
}
