//
//  LevelRules.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 27/01/21.
//

import Foundation


class LevelRules {
    
    static private var levels:[LevelRules] = []
    static private var currentLevelIndex = 0
    
    static private var empty = LevelRules(moveSet: [:], fileName: "", barsInOneTurn: 0, startingBar: 0)
    
    let moveSet: [UInt8:Moves]
    let fileName: String
    let barsInOneTurn: Double
    let startingBar: Double
    
    private init(moveSet: [UInt8:Moves], fileName: String, barsInOneTurn: Double, startingBar: Double) {
        self.moveSet = moveSet
        self.fileName = fileName
        self.barsInOneTurn = barsInOneTurn
        self.startingBar = startingBar
    }
    
    static func factory() {
        
        let defaultMoveSet:[UInt8:Moves] = [
            0 : .idle,
            63 : .leftEyeBlink,
            65: .rightEyeBlink,
            67: .jawOpen,
            70: .mouthPucker
        ]
        
        let defaultFileName = "C5.5 - 1.1"
        
        LevelRules.levels.append(LevelRules(moveSet: defaultMoveSet, fileName: defaultFileName, barsInOneTurn: 4, startingBar: 2))
    }
    
    static public func currentLevel() -> LevelRules{
        if levels.isEmpty{
            print("Level Rules Vazio!!")
            return empty
        }
        return levels[currentLevelIndex]
    }
}
