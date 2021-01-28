//
//  SKCharacter.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 26/01/21.
//

import Foundation
import SpriteKit
import ARKit

let characterTextures:[SKTexture] = [
    SKTexture(imageNamed: ""),
    SKTexture(imageNamed: ""),
    SKTexture(imageNamed: ""),
    SKTexture(imageNamed: ""),
    SKTexture(imageNamed: "")
]

let actions:[ARFaceAnchor.BlendShapeLocation:SKAction] = [
    .mouthLeft : SKAction.setTexture(characterTextures[1]),
    .mouthRight : SKAction.setTexture(characterTextures[2]),
    .jawOpen : SKAction.setTexture(characterTextures[3]),
    .mouthPucker : SKAction.setTexture(characterTextures[4])
]
    

class SKCharacter: SKSpriteNode {

    
    init() {
        super.init(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
        //characterTextures.map({$0.preload {print("carreguei")}})
        for texture in characterTextures {
            texture.preload {
                print("carreguei")
            }
        }
    }
    
    func move(faceExpression: ARFaceAnchor.BlendShapeLocation) {
        guard let action = actions[faceExpression] else {return}
        self.run(action)
    }
    
    func setIdleState() {
        self.texture = characterTextures[0]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

