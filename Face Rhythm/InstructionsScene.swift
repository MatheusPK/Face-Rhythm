//
//  InstructionsScene.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 27/01/21.
//

import Foundation
import SpriteKit

class InstructionsScene: SKScene {
    
    var playButton: SKSpriteNode!
    var backgroundImage: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let playTexture = SKTexture(imageNamed: "playButton")
        self.playButton = SKSpriteNode(texture: playTexture, size: CGSize(width: 120, height: 120))
        self.playButton.position = CGPoint(x: 0, y: -280)
        self.playButton.zPosition = 10
        
        let texture = SKTexture(imageNamed: "instrucoes_2")
        self.backgroundImage = SKSpriteNode(texture: texture, size: self.size)
        
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
