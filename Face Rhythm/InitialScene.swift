//
//  InitialScene.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 27/01/21.
//

import Foundation
import SpriteKit

class InitialScene: SKScene {
    
    var creatorsLabel: SKLabelNode!
    var titleLabel: SKLabelNode!
    var playButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.creatorsLabel = SKLabelNode(text: "Created by Matheus Kulick and Theo Caldas")
        self.creatorsLabel.fontSize = 15
        self.creatorsLabel.position = CGPoint(x: 0, y: -400)
        
        self.titleLabel = SKLabelNode(text: "Face Rhythm")
        self.titleLabel.position = CGPoint(x: 0, y: 50)
        
        self.playButton = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 40))
        self.playButton.position = CGPoint(x: 0, y: 0)
        
        self.addChild(self.creatorsLabel)
        self.addChild(self.titleLabel)
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
