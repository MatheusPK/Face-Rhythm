//
//  LevelRules.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 27/01/21.
//

import Foundation


class LevelRules {
    
    static var levels:[LevelRules] = []
    
    let moveSet: [UInt8:Moves]
    let fileName: String
    let turnDuration: TimeInterval // tempo
    
    private init(moveSet: [UInt8:Moves], fileName: String, turnDuration: TimeInterval) {
        self.moveSet = moveSet
        self.fileName = fileName
        self.turnDuration = turnDuration
    }
    
    func factory() {
        
        let defaultMoveSet:[UInt8:Moves] = [
            0 : .idle,
            63 : .leftEyeBlink,
            65: .rightEyeBlink,
            67: .jawOpen,
            70: .mouthPucker
        ]
        
        let defaultFileName = "C5.5-1.1"
        
        let defaultTurnDuration:TimeInterval = 5
        
        LevelRules.levels[0] = LevelRules(moveSet: defaultMoveSet, fileName: defaultFileName, turnDuration: defaultTurnDuration)
    }
}
