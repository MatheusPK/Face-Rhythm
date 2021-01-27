//
//  InstructionsScene.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 27/01/21.
//

import Foundation
import SpriteKit

class InstructionsScene: SKScene {
    
    var instructionLabel1: SKLabelNode!
    var instructionLabel2: SKLabelNode!
    var instructionLabel3: SKLabelNode!
    var playButton: SKSpriteNode!
    let instructions:[String] = ["Look at the movements", "Memorize it", "Then repeat"]
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.instructionLabel1 = SKLabelNode(text: self.instructions[0])
        self.instructionLabel1.position = CGPoint(x: 0, y: 30)
        
        self.instructionLabel2 = SKLabelNode(text: self.instructions[1])
        self.instructionLabel2.position = CGPoint(x: 0, y: 0)
        
        self.instructionLabel3 = SKLabelNode(text: self.instructions[2])
        self.instructionLabel3.position = CGPoint(x: 0, y: -30)
        
        self.playButton = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 40))
        self.playButton.position = CGPoint(x: 0, y: -100)
        
        self.addChild(self.instructionLabel1)
        self.addChild(self.instructionLabel2)
        self.addChild(self.instructionLabel3)
        self.addChild(self.playButton)
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
