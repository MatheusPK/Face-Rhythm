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
    private var character:SKCharacter!
    private var playerTurn: Bool = true
    private var hasStarted = false
    private var playerTurnLabel: SKSpriteNode!
    var playerTurnLabelTexture = SKTexture(imageNamed: "yourTurn")
    
    
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.character = SKCharacter()
        self.addChild(self.character)
        self.backgroundColor = .red
        
        self.myArView = ARView()
        self.myArView.ARViewDelegate = self
        self.view?.addSubview(myArView.view)
        self.view?.subviews[0].frame = CGRect(x: 15, y: 45, width: 60, height: 100)
        
        self.playerTurnLabel = SKSpriteNode(texture: self.playerTurnLabelTexture, size: CGSize(width: 200, height: 50))
        self.playerTurnLabel.position = CGPoint(x: 0, y: 350)
        self.playerTurnLabel.isHidden = true
        self.addChild(self.playerTurnLabel)
        
        AudioManager.singleInstance.playMusic()
        MidiManager.singleInstance.startCheckingNotesAndTurns()
        MidiManager.singleInstance.addDelegate(delegate: self)
    }
    
    
    func handleFaceExpression(faceExpression: ARFaceAnchor.BlendShapeLocation?) {
        guard playerTurn else {return}
        guard hasStarted else {return}
        guard let faceExp = faceExpression else {
            AudioManager.singleInstance.stopNote()
            return
        }
        AudioManager.singleInstance.playNote(note: LevelRules.currentLevel().moveSet.getKeyByValue(value: faceExp)!)
        // ver se a nota tocada e a certa -> funcao na level rules
    }
    
    func noteOn(note: UInt8) {
        self.character.removeAllActions()
        self.character.move(faceExpression: LevelRules.currentLevel().moveSet[note]!)
    }
    
    func noteOff() {
        print("oi")
        self.character.setIdleState()
    }
    
    func changeTurn() {
        self.playerTurn.toggle()
        AudioManager.singleInstance.stopNote()
        self.hasStarted = true
        self.updateUI(screenState: self.playerTurn)
        self.myArView.resetTracking()
    }
    
    func updateUI(screenState: Bool) {
        if(screenState) {
            UIView.animate(withDuration: 0.3, animations: {
                self.view?.subviews[0].frame = CGRect(x: ((self.view?.bounds.maxX)!/2) - 150, y: ((self.view?.bounds.maxY)!/2) - 300, width: 300, height: 400)
            })
            
            self.character.setScale(0.7)
            self.character.run(SKAction.move(to: CGPoint(x: 0, y: -250), duration: 0.2))
            
            self.playerTurnLabel.isHidden = false
        }
        else {
            UIView.animate(withDuration: 0.3, animations: {
                self.view?.subviews[0].frame = CGRect(x: 15, y: 45, width: 60, height: 100)
            })
            self.character.setScale(1)
            self.character.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.2))
            self.playerTurnLabel.isHidden = true
        }
    }
}

protocol ARViewDelegate {
    func handleFaceExpression(faceExpression: ARFaceAnchor.BlendShapeLocation?)
}
