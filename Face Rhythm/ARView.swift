//
//  ARView.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 26/01/21.
//

import Foundation
import ARKit
import SwiftUI

// MARK: - ARViewIndicator

class ARView: UIViewController, ARSCNViewDelegate {
    //var myGameScene: GameScene
    var ARViewDelegate: ARViewDelegate!
    
    var arView: ARSCNView!
    
    var lastMov: Moves? = nil
    
    override func loadView() {
        arView = ARSCNView(frame: .zero)
        self.view = arView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.scene = SCNScene()
        self.viewWillAppear(true)
    }
    
    // MARK: - Functions for standard AR view handling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard ARFaceTrackingConfiguration.isSupported else {print("iPhone X required"); return}
        
        let configuration = ARFaceTrackingConfiguration()
        
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        arView.delegate = self
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor {
            update(withFaceAnchor: faceAnchor)
        }
    }
    func update(withFaceAnchor faceAnchor: ARFaceAnchor) {
        guard let right = faceAnchor.blendShapes[.mouthRight] as? Float else {return}
        guard let left = faceAnchor.blendShapes[.mouthLeft] as? Float else {return}
        guard let up = faceAnchor.blendShapes[.jawOpen] as? Float else {return}
        guard let down = faceAnchor.blendShapes[.mouthPucker] as? Float else {return}
        
        //mandar apenas o movimento do rosto, tratar na gameviewcontroller
        
        
        let notes:[UInt8: Moves] = [
            0 : .idle,
            63 : .leftEyeBlink,
            65: .rightEyeBlink,
            67: .jawOpen,
            70: .mouthPucker
        ]
        
        let movs:[Moves: UInt8] = [
            .idle : 0,
            .leftEyeBlink : 63,
            .rightEyeBlink: 65,
            .jawOpen: 67,
            .mouthPucker: 70
        ]

        if up > 0.5 {
            //self.ARViewDelegate.movePlayer(sound: 42)
            if self.lastMov != .jawOpen{
                self.lastMov = .jawOpen
                AudioManager.singleInstance.stopNote()
                AudioManager.singleInstance.playNote(note: movs[.jawOpen]!)
            }
        }
        else if left > 0.5 {

            if self.lastMov != .rightEyeBlink{
                self.lastMov = .rightEyeBlink
                AudioManager.singleInstance.stopNote()
                AudioManager.singleInstance.playNote(note: movs[.rightEyeBlink]!)
            }

        }
        else if right > 0.5 {
            if  self.lastMov != .leftEyeBlink{
                self.lastMov = .leftEyeBlink
                AudioManager.singleInstance.stopNote()
                AudioManager.singleInstance.playNote(note: movs[.leftEyeBlink]!)
            }
        }
        else if down > 0.5 {
            if self.lastMov != .mouthPucker{
                self.lastMov = .mouthPucker
                AudioManager.singleInstance.stopNote()
                AudioManager.singleInstance.playNote(note: movs[.mouthPucker]!)
            }
        }
        else{
            self.lastMov = nil
            AudioManager.singleInstance.stopNote()
        }
        
        //funcao que envia o movimento para a gamescene e la a gnt trata pra ver se o movimento e o certo
    }
    
}




