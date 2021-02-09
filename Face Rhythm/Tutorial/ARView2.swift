//
//  ARView2.swift
//  Face Rhythm
//
//  Created by Matheus Kulick on 04/02/21.
//


import ARKit

class ARView2: UIViewController, ARSessionDelegate {
    
    var session:ARSession!
    var arView: ARSCNView!
    
    override func viewDidLoad() {
        session = ARSession()
        session.delegate = self
        arView.session = session
        self.view = arView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard ARFaceTrackingConfiguration.isSupported else {print("iPhone X required"); return}
        
        let configuration = ARFaceTrackingConfiguration()
        
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // -> roda quando uma anchor atualiza
        if let faceAnchor = anchors.first as? ARFaceAnchor {
            update(withFaceAnchor: faceAnchor)
        }
    }
    
    
    func update(withFaceAnchor faceAnchor: ARFaceAnchor) {
        var bledShapes:[ARFaceAnchor.BlendShapeLocation:Any] = faceAnchor.blendShapes
        
        guard let browInnerUp = bledShapes[.browInnerUp] as? Float else {return}
        print(browInnerUp)
        
        if browInnerUp > 0.5 {
            //gameScene.updatePlayer(state: .up)
        }else if browInnerUp < 0.025 {
            //gameScene.updatePlayer(state: .down)
        }else {
            //gameScene.updatePlayer(state: .neutral)
        }
        
    }
    
}



/*
import UIKit
import SpriteKit
import ARKit

class GameViewController: UIViewController, ARSessionDelegate {

    var gameScene:GameScene!
    var session:ARSession!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                gameScene = scene
                // Set the scale mode to scale to fit the window
                gameScene.scaleMode = .aspectFill
            
                // Present the scene
                view.presentScene(gameScene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            session = ARSession()
            session.delegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard ARFaceTrackingConfiguration.isSupported else {print("iPhone X required"); return}
        
        let configuration = ARFaceTrackingConfiguration()
        
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: ARSession Delegate
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // -> roda quando uma anchor atualiza
        if let faceAnchor = anchors.first as? ARFaceAnchor {
            update(withFaceAnchor: faceAnchor)
        }
    }
    
    
    func update(withFaceAnchor faceAnchor: ARFaceAnchor) {
        var bledShapes:[ARFaceAnchor.BlendShapeLocation:Any] = faceAnchor.blendShapes
        
        guard let browInnerUp = bledShapes[.browInnerUp] as? Float else {return}
        print(browInnerUp)
        
        if browInnerUp > 0.5 {
            gameScene.updatePlayer(state: .up)
        }else if browInnerUp < 0.025 {
            gameScene.updatePlayer(state: .down)
        }else {
            gameScene.updatePlayer(state: .neutral)
        }
        
    }
}
*/
