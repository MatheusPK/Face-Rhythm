//
//  GameScene.swift
//  Face Rhythm
//
//  Created by Theo Necyk Agner Caldas on 26/01/21.
//

import SpriteKit
import GameplayKit
import ARKit



class GameScene: SKScene, ARViewDelegate {
    
    var myArView:ARView!
    var character: SKCharacter!
    
    
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
    }
    
    func movePlayer(sound: UInt8) {
//        self.character.move(sound: sound)
    }
    
    func handleFaceExpression(faceExpression: ARFaceAnchor.BlendShapeLocation) {
        
    }
    
}

protocol ARViewDelegate {
    func handleFaceExpression(faceExpression: ARFaceAnchor.BlendShapeLocation)
}
