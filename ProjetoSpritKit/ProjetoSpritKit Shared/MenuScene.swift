//
//  MenuScene.swift
//  ProjetoSpritKit iOS
//
//  Created by Vinicius Gomes on 22/11/22.
//

import Foundation
import SpriteKit
class MenuScene: SKScene {
    
    var playButtonNode: SKSpriteNode?
    
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
    override func didMove(to view: SKView) {
        
        playButtonNode = (self.childNode(withName: "playV1") as? SKSpriteNode)
           
       }
       
       
       override func update(_ currentTime: TimeInterval) {
           // Called before each frame is rendered
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           let touch = touches.first
           
           if let location = touch?.location(in:self) {
               let nodesArray = self.nodes(at: location)
               
               if nodesArray.first?.name == "playV1" {
                   let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                   let newScene = GameScene.init(fileNamed: "GameScene")!
                   newScene.scaleMode = SKSceneScaleMode.aspectFill
                   view?.presentScene(newScene)
                  
               }
               
           }
       }
}
