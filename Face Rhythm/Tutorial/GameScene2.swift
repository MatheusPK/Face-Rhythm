//
//  GameScene2.swift
//  Face Rhythm
//
//  Created by Theo Necyk Agner Caldas on 04/02/21.
//

import SpriteKit

class GameScene2: SKScene {
    
    private var character: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.character = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
        self.addChild(self.character)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self) ?? .zero
        if (location.x > 0){
            self.character.run(SKAction.moveBy(x: 10, y: 0, duration: 0.5))
        }else{
            self.character.run(SKAction.moveBy(x: -10, y: 0, duration: 0.5))
        }
    }
}

