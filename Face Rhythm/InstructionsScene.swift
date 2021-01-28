//
//  InstructionsScene.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 27/01/21.
//

import Foundation
import SpriteKit

class InstructionsScene: SKScene {
    
//    var instructionLabel1: SKLabelNode!
//    var instructionLabel2: SKLabelNode!
//    var instructionLabel3: SKLabelNode!
//    let instructions:[String] = ["Look at the movements", "Memorize it", "Then repeat"]
    
    var playButton: SKSpriteNode!
    var backgroundImage: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
//        self.instructionLabel1 = SKLabelNode(text: self.instructions[0])
//        self.instructionLabel1.position = CGPoint(x: 0, y: 30)
//
//        self.instructionLabel2 = SKLabelNode(text: self.instructions[1])
//        self.instructionLabel2.position = CGPoint(x: 0, y: 0)
//
//        self.instructionLabel3 = SKLabelNode(text: self.instructions[2])
//        self.instructionLabel3.position = CGPoint(x: 0, y: -30)
        
        let playTexture = SKTexture(imageNamed: "playButton")
        self.playButton = SKSpriteNode(texture: playTexture, size: CGSize(width: 120, height: 120))
        self.playButton.position = CGPoint(x: 0, y: -280)
        self.playButton.zPosition = 10
        
        let texture = SKTexture(imageNamed: "instrucoes")
        self.backgroundImage = SKSpriteNode(texture: texture, size: self.size)
        
//        self.addChild(self.instructionLabel1)
//        self.addChild(self.instructionLabel2)
//        self.addChild(self.instructionLabel3)
        self.addChild(self.playButton)
        self.addChild(self.backgroundImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode == playButton {
                self.view?.presentScene(GameScene(size: self.size), transition: .crossFade(withDuration: 0.5))
            }
        }
    }
    
}
