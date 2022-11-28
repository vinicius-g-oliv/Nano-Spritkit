//
//  GameOverScene.swift
//  ProjetoSpritKit iOS
//
//  Created by Guilherme Lozano Borges on 24/11/22.
//

import Foundation
import SpriteKit


class GameOverScene: SKScene {
    class func startScene() -> MenuScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let start = SKScene(fileNamed: "MenuScene") as? MenuScene else {
            print("Failed to load MenuScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        start.scaleMode = SKSceneScaleMode.aspectFill
        
        return start
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in:self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "playagain" {
                let transition = SKTransition.crossFade(withDuration: 0.5)
                let newScene = GameScene.init(fileNamed: "GameScene")!
                newScene.scaleMode = SKSceneScaleMode.aspectFill
                view?.presentScene(newScene, transition: transition)
               
            }else {
                let newScene = MenuScene.init(fileNamed: "MenuScene")!
                let transition = SKTransition.crossFade(withDuration: 0.5)
                newScene.scaleMode = SKSceneScaleMode.aspectFill
                view?.presentScene(newScene, transition: transition)
                
            }
            
        }
    }
}