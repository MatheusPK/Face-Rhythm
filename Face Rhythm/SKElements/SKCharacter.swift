//
//  SKCharacter.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 26/01/21.
//

import Foundation
import SpriteKit

enum Moves {
    case leftEyeBlink
    case rightEyeBlink
    case mouthPucker
    case jawOpen
    case idle
}

let actions:[Moves:SKAction] = [
    .idle : SKAction.move(by: CGVector(dx: 0, dy: 0), duration: 0), //brevemente sera a textura
    .leftEyeBlink : SKAction.move(by: CGVector(dx: 5, dy: 0), duration: 0),
    .rightEyeBlink : SKAction.move(by: CGVector(dx: -5, dy: 0), duration: 0),
    .jawOpen : SKAction.move(by: CGVector(dx: 0, dy: 5), duration: 0),
    .mouthPucker : SKAction.move(by: CGVector(dx: 0, dy: -5), duration: 0)
]

let sounds:[UInt8: Moves] = [
    63 : .idle,
    70 : .leftEyeBlink,
    57: .rightEyeBlink,
    42: .jawOpen,
    89: .mouthPucker
]

class SKCharacter: SKSpriteNode {
    init() {
        super.init(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
    }
    
    func move(sound: UInt8) {
        guard let move = sounds[sound] else {return}
        guard let action = actions[move] else {return}
        self.run(action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

