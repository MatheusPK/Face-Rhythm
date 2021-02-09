//
//  LevelRules.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 27/01/21.
//

import Foundation
import ARKit


class LevelRules {
    
    static private var levels:[LevelRules] = []
    static private var currentLevelIndex = 1
    
    static private var empty = LevelRules(moveSet: [:], fileName: "", noteFileName: "", barsInOneTurn: 0, startingBar: 0)
    
    let moveSet: [UInt8:ARFaceAnchor.BlendShapeLocation]
    let fileName: String
    let noteFileName: String
    let barsInOneTurn: Double
    let startingBar: Double
    
    private init(moveSet: [UInt8:ARFaceAnchor.BlendShapeLocation], fileName: String, noteFileName: String, barsInOneTurn: Double, startingBar: Double) {
        self.moveSet = moveSet
        self.fileName = fileName
        self.noteFileName = noteFileName
        self.barsInOneTurn = barsInOneTurn
        self.startingBar = startingBar
    }
    
    static func factory() {
        
        let moveSet1:[UInt8:ARFaceAnchor.BlendShapeLocation] = [
            63 : .mouthLeft,
            65: .mouthRight,
            67: .jawOpen,
            70: .mouthPucker
        ]
        
        
        LevelRules.levels.append(LevelRules(moveSet: moveSet1, fileName: "tema 1.1", noteFileName: "C3 tema", barsInOneTurn: 4, startingBar: 2))
        
        let moveSet2:[UInt8:ARFaceAnchor.BlendShapeLocation] = [
            78: .mouthLeft,
            75: .mouthRight,
            76: .jawOpen,
            71: .mouthPucker,
            73: .browInnerUp
        ]
        
        LevelRules.levels.append(LevelRules(moveSet: moveSet2, fileName: "tiktok 1.2", noteFileName: "C3 tiktok", barsInOneTurn: 2, startingBar: 2))
        
    }
    
    static public func currentLevel() -> LevelRules{
        if levels.isEmpty{
            print("Level Rules Vazio!!")
            return empty
        }
        return levels[currentLevelIndex]
    }
}
