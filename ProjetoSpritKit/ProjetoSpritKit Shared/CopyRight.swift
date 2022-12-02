//
//  CopyRight.swift
//  ProjetoSpritKit iOS
//
//  Created by Victor Levenetz Mariano on 02/12/22.
//

import Foundation
import SpriteKit


class CopyRight: SKScene{
    private var dados = Dados()
    //private var player = GameScene()
    override func sceneDidLoad() {
       
        
        
        
    }
    class func startScene() -> MenuScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let start = SKScene(fileNamed: "MenuScene") as? MenuScene else {
            print("Failed to load MenuScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        start.scaleMode = SKSceneScaleMode.aspectFit
        
        return start
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in:self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "voltar" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let newScene = MenuScene.init(fileNamed: "MenuScene")!
                newScene.scaleMode = SKSceneScaleMode.aspectFit
                view?.presentScene(newScene, transition: transition)
               
            }
            
        }
    }
    
}
