//
//  GameScene.swift
//  Face Rhythm
//
//  Created by Theo Necyk Agner Caldas on 26/01/21.
//

import SpriteKit
import GameplayKit
import ARKit




class GameScene: SKScene, ARViewDelegate, MidiManagerDelegate {
    
    var myArView:ARView!
    var character:SKCharacter!
    var playerTurn: Bool = true
    
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(SKLabelNode(text: "oi"))
        self.character = SKCharacter()
        self.addChild(self.character)
        
        self.myArView = ARView()
        self.myArView.ARViewDelegate = self
        self.view?.addSubview(myArView.view)
        self.view?.subviews[0].frame = CGRect(x: 15, y: 30, width: 90, height: 90)
        
        AudioManager.singleInstance.playMusic()
        MidiManager.singleInstance.startCheckingNotesAndTurns()
        MidiManager.singleInstance.addDelegate(delegate: self)
    }
    
    
    func handleFaceExpression(faceExpression: ARFaceAnchor.BlendShapeLocation) {
        guard playerTurn == true else {return}
        AudioManager.singleInstance.playNote(note: LevelRules.currentLevel().moveSet.getKeyByValue(value: faceExpression)!)
        // ver se a nota tocada e a certa -> funcao na level rules
    }
    
    func noteOn(note: UInt8) {
        self.character.move(faceExpression: LevelRules.currentLevel().moveSet[note]!)
    }
    
    func noteOff() {
        self.character.setIdleState()
    }
    
    func changeTurn() {
        self.playerTurn.toggle()
    }
    
}

protocol ARViewDelegate {
    func handleFaceExpression(faceExpression: ARFaceAnchor.BlendShapeLocation)
}
