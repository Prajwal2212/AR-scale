//
//  ViewController.swift
//  AR Ruler
//
//  Created by Prajwal Prasad on 18/07/24.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var dotNodes = [SCNNode]()
    var textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) 
    {
        if dotNodes.count >= 2
        {
            for dot in dotNodes
            {
                dot.removeFromParentNode()
            }
            dotNodes = [SCNNode]()
        }
        
        if let touchLocation = touches.first?.location(in: sceneView)
        {
            guard let query = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .any) else { return }
            let results = sceneView.session.raycast(query)
            
            if let hitTestResult = results.first
            {
                addDot(at: hitTestResult)
            }
        }
    }
    
    func addDot(at hitResult: ARRaycastResult)
    {
        let dot = SCNSphere(radius: 0.005)
        
        let materials = SCNMaterial()
        materials.diffuse.contents = UIColor.red
        
        dot.materials = [materials]
        
        let dotNode = SCNNode(geometry: dot)
        dotNode.position = SCNVector3(
            x: hitResult.worldTransform.columns.3.x,
            y: hitResult.worldTransform.columns.3.y,
            z: hitResult.worldTransform.columns.3.z
        )
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        dotNodes.append(dotNode)
        
        if dotNodes.count >= 2
        {
            calculate()
        }
    }
    
    func calculate()
    {
        let startNode = dotNodes[0]
        let endNode = dotNodes[1]
        
        let a = endNode.position.x - startNode.position.x
        let b = endNode.position.y - startNode.position.y
        let c = endNode.position.z - startNode.position.z
        
        let distance = sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2))
        
        updateText(text: "\(distance)m", atPosition: endNode.position)
    }
    
    func updateText(text: String, atPosition position: SCNVector3)
    {
        textNode.removeFromParentNode()
        
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.red
        
        textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(position.x, position.y + 0.01, position.z)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        sceneView.scene.rootNode.addChildNode(textNode)
    }
}
