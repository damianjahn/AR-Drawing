//
//  ViewController.swift
//  AR Drawing
//
//  Created by Damian Jahn on 05/03/2019.
//  Copyright © 2019 Damian Jahn. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController, ARSKViewDelegate {

    @IBOutlet weak var sceneVIEW: ARSCNView!
    @IBOutlet weak var Draw: UIButton!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneVIEW.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneVIEW.showsStatistics = true
        self.sceneVIEW.session.run(configuration)
        self.sceneVIEW.delegate = self as? ARSCNViewDelegate
    }

    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneVIEW.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        let currentPositionOfCamera = orientation + location
        DispatchQueue.main.async {
            if self.Draw.isHighlighted {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
                sphereNode.position = currentPositionOfCamera
                self.sceneVIEW.scene.rootNode.addChildNode(sphereNode)
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                print("draw button is being pressed")
            }
            else {
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                pointer.name = "pointer"
                pointer.position = currentPositionOfCamera
                self.sceneVIEW.scene.rootNode.enumerateChildNodes({ (node, _) in
                    if node.name == "pointer" {
                        node.removeFromParentNode()
                    }
                })
                self.sceneVIEW.scene.rootNode.addChildNode(pointer)
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                
            }
            
        }
    }
    
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    
}


//    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval){
//        guard let pointOfView = sceneVIEW.pointOfView else {return}
//        let transofm = pointOfView.transform
//        let orientation = SCNVector3(-transofm.m31,-transofm.m32,-transofm.m33)
//        let location = SCNVector3(transofm.m41,transofm.m42,transofm.m43)
//        let currentPositionOfCamera = orientation + location
//        DispatchQueue.main.async {
//            if self Draw.isHighlighted {
//                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.01))
//                sphereNode.position = currentPositionOfCamera
//                self.sceneVIEW.scene.rootNode.addChildNode(sphereNode)
//                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//            } else {
//                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
//                pointer.name = "pointer"
//                pointer.position = currentPositionOfCamera
//
//                self.sceneVIEW.scene.rootNode.enumerateChildNodes({(node, _) in
//                    if node.name == "pointer" {
//                    node.removeFromParentNode()
//                    }
//                })
//
//                self.sceneVIEW.scene.rootNode.addChildNode(pointer)
//                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//            }
//        }
//
//
//    }
//
//}
//
//func +(left:SCNVector3, right: SCNVector3) -> SCNVector3
//{
//    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
//}
