//
//  GameViewController.swift
//  ProjetoSpritKit iOS
//
//  Created by Vinicius Gomes on 03/11/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Present the scene
        let skView = self.view as! SKView
        let scene = MenuScene.init(fileNamed: "MenuScene")
       
        scene?.scaleMode = .aspectFit
        skView.presentScene(scene)

       
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
}

