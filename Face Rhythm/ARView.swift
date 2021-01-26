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
        guard let right = faceAnchor.blendShapes[.eyeBlinkLeft] as? Float else {return}
        guard let left = faceAnchor.blendShapes[.eyeBlinkRight] as? Float else {return}
        guard let up = faceAnchor.blendShapes[.jawOpen] as? Float else {return}
        guard let down = faceAnchor.blendShapes[.mouthPucker] as? Float else {return}
        
        if up > 0.5 {
            self.ARViewDelegate.movePlayer(sound: 42)
        }
        if left > 0.5 {
            self.ARViewDelegate.movePlayer(sound: 57)
        }
        if right > 0.5 {
            self.ARViewDelegate.movePlayer(sound: 70)
        }
        
        if down > 0.5 {
            self.ARViewDelegate.movePlayer(sound: 89)
        }
        
        //funcao que envia o movimento para a gamescene e la a gnt trata pra ver se o movimento e o certo
    }
    
}




