//
//  SKCharacter.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 26/01/21.
//

import Foundation
import SpriteKit
import ARKit


let actions:[ARFaceAnchor.BlendShapeLocation:SKAction] = [
    .mouthLeft : SKAction.move(by: CGVector(dx: 20, dy: 0), duration: 0),
    .mouthRight : SKAction.move(by: CGVector(dx: -20, dy: 0), duration: 0),
    .jawOpen : SKAction.move(by: CGVector(dx: 0, dy: 20), duration: 0),
    .mouthPucker : SKAction.move(by: CGVector(dx: 0, dy: -20), duration: 0)
]

class SKCharacter: SKSpriteNode {

    
    init() {
        super.init(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
    }
    
    func move(faceExpression: ARFaceAnchor.BlendShapeLocation) {
        guard let action = actions[faceExpression] else {return}
        self.run(action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

