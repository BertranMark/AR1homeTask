//
//  ViewController.swift
//  AR1homeTask
//
//  Created by Bertran on 15.09.2018.
//  Copyright © 2018 Bertran. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // выполнение домашнего задания - создание двора
        
        sceneView.autoenablesDefaultLighting = true
        
        // добавляем первый узел в корневой узел сцены
        let node = SCNNode()
        sceneView.scene.rootNode.addChildNode(node)
        
        
        // добавление геометрических фигур
        
        // создание геометрической фигуры - дома
        let box = SCNBox(width: 0.6, height: 0.3, length: 0.3, chamferRadius: 0)
        box.firstMaterial?.diffuse.contents = UIColor.brown
        // узел - дом
        let houseNode = SCNNode()
        houseNode.position = SCNVector3(0, -0.3, -1)
        houseNode.geometry = box
        node.addChildNode(houseNode)
        
        // площадка
        let yard = SCNFloor()
        yard.width = 0.3
        yard.length = 0.18
        yard.firstMaterial?.diffuse.contents = UIColor.green
        let yardNode = SCNNode()
     
        yardNode.position = SCNVector3(0, -0.45, -0.65)
        yardNode.geometry = yard
        node.addChildNode(yardNode)
        
        // деревья
        // координаты для стволов
        let myTrunkMap : [ SCNVector3 ] = [
                SCNVector3(-0.15, -0.4, -0.6),
                SCNVector3(0, -0.4, -0.7),
                SCNVector3(0.2, -0.4, -0.5)
        ]
    
        for i in 0..<myTrunkMap.count {
            // стволы деревьев
            let trunk = SCNCylinder()
            trunk.height = 0.07
            trunk.radius = 0.005
            trunk.firstMaterial?.diffuse.contents = UIColor.darkGray
            
            let trunkNode = SCNNode()
            trunkNode.position = myTrunkMap[ i ]
            trunkNode.geometry = trunk
            node.addChildNode(trunkNode)
            
            // кроны деревьев
            let sphere = SCNSphere()
            sphere.radius =  0.03 * CGFloat(i+1)
            sphere.firstMaterial?.diffuse.contents = UIColor.blue
            
            let sphereNode = SCNNode()
            sphereNode.position = SCNVector3( myTrunkMap[i].x, myTrunkMap[i].y + 0.03*Float(i+1), myTrunkMap[i].z)
            sphereNode.geometry = sphere
            node.addChildNode(sphereNode)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
