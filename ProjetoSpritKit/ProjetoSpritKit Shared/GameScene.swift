//
//  GameScene.swift
//  ProjetoSpritKit Shared
//
//  Created by Vinicius Gomes on 03/11/22.
//

import SpriteKit

class GameScene: SKScene {
    
    var playButtonNode: SKSpriteNode?
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    
    override func didMove(to view: SKView) {
        
        
        playButtonNode = (self.childNode(withName: "Play") as! SKSpriteNode)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in:self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "Play" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let newScene = NewScene(size: self.size)
                self.view?.presentScene(newScene, transition: transition)
                print("oi")
            }
            
        }
    }
}
