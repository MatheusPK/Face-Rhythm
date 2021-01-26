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
    .leftEyeBlink : SKAction.move(by: CGVector(dx: 20, dy: 0), duration: 0),
    .rightEyeBlink : SKAction.move(by: CGVector(dx: -20, dy: 0), duration: 0),
    .jawOpen : SKAction.move(by: CGVector(dx: 0, dy: 20), duration: 0),
    .mouthPucker : SKAction.move(by: CGVector(dx: 0, dy: -20), duration: 0)
]

let notes:[UInt8: Moves] = [
    0 : .idle,
    63 : .leftEyeBlink,
    65: .rightEyeBlink,
    67: .jawOpen,
    70: .mouthPucker
]

class SKCharacter: SKSpriteNode, MidiManagerDelegate {
    func noteOn(note: UInt8) {
        self.move(sound: note)
        print("\(note) on!")
    }
    
    func noteOff() {
        self.removeAllActions()
        print("Note off!")
    }
    
    init() {
        super.init(texture: nil, color: .blue, size: CGSize(width: 50, height: 50))
        MidiManager.singleInstance.addDelegate(delegate: self)
    }
    
    func move(sound: UInt8) {
        guard let move = notes[sound] else {return}
        guard let action = actions[move] else {return}
        self.run(action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

