//
//  InitialScene.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 27/01/21.
//

import Foundation
import SpriteKit

class InitialScene: SKScene {
    
    private var playButton: SKSpriteNode!
    private var playButtonTexture = SKTexture(imageNamed: "playButton")
    private var backgroundImage: SKSpriteNode!
    private var backgroundTexture = SKTexture(imageNamed: "titulo_2")
    
    override func didMove(to view: SKView) {
        
        self.backgroundImage = SKSpriteNode(texture: self.backgroundTexture, size: self.size)
        
        self.playButton = SKSpriteNode(texture: self.playButtonTexture)
        self.playButton.position = CGPoint(x: 5, y: 0)
        self.playButton.zPosition = 10
        
        self.addChild(self.backgroundImage)
        self.addChild(self.playButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode == playButton {
                self.view?.presentScene(InstructionsScene(size: self.size), transition: .crossFade(withDuration: 0.5))
            }
        }
    }
}
