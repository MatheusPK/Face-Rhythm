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
    var ARViewDelegate: ARViewDelegate!
    var currentMove: ARFaceAnchor.BlendShapeLocation? = nil
    
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
    
        //mandar apenas o movimento do rosto, tratar na gameviewcontroller
//        guard var selectedMove = LevelRules.currentLevel().moveSet.values.first else {return}
        
        var selectedMove: ARFaceAnchor.BlendShapeLocation? = nil
        
        for move in LevelRules.currentLevel().moveSet.values {
            guard let faceFactor = faceAnchor.blendShapes[move] as? Float else {return}
            if (faceFactor > 0.5){
                if selectedMove == nil{
                    selectedMove = move
                }
                else{
                    guard let maxFactor = faceAnchor.blendShapes[selectedMove!] as? Float else {return}
                    if faceFactor > maxFactor{
                        selectedMove = move
                    }
                }
            }
        }
        
        if(self.currentMove != selectedMove) {
            self.ARViewDelegate.handleFaceExpression(faceExpression: selectedMove)
            self.currentMove = selectedMove
        }
        
        
    }
    
    func resetTracking(){
        self.currentMove = nil
    }
    
}




