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
    SKTexture(imageNamed: "personagem_neutro"),
    SKTexture(imageNamed: "personagem_boca_pra_esquerda"),
    SKTexture(imageNamed: "personagem_boca_pra_direita"),
    SKTexture(imageNamed: "personagem_boca_aberta"),
    SKTexture(imageNamed: "personagem_biquinho")
]

let actions:[ARFaceAnchor.BlendShapeLocation:SKAction] = [
    .mouthLeft : SKAction.setTexture(characterTextures[1]),
    .mouthRight : SKAction.setTexture(characterTextures[2]),
    .jawOpen : SKAction.setTexture(characterTextures[3]),
    .mouthPucker : SKAction.setTexture(characterTextures[4])
]
    

class SKCharacter: SKSpriteNode {

    var numberOfMovs = 1
    
    init() {
        super.init(texture: nil, color: .white, size: CGSize(width: 200, height: 280))
        let _ = characterTextures.map({$0.preload {print("carreguei")}})
        self.setIdleState()
    }
    
    func move(faceExpression: ARFaceAnchor.BlendShapeLocation) {
        guard let action = actions[faceExpression] else {return}
        self.run(action)
        self.numberOfMovs += 1
    }
    
    func setIdleState() {
        self.numberOfMovs -= 1
        if self.numberOfMovs == 0{
            self.texture = characterTextures[0]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

