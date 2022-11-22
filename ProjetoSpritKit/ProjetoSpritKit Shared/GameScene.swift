//
//  GameScene.swift
//  ProjetoSpritKit Shared
//
//  Created by Vinicius Gomes on 03/11/22.
//

import SpriteKit

class GameScene: SKScene {
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 500
    var ScrollLayer: SKNode!
    var player: SKNode!
     var playButtonNode: SKSpriteNode?
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFit
      
        return scene
    }
    
    
    override func didMove(to view: SKView) {
        ScrollLayer = self.childNode(withName: "ScrollLayer")
        // Define a imagem do ~Player~
        player = SKSpriteNode(imageNamed: "CatV1icon2")
        // Define a posição do ~Player~
        player.position = CGPoint(x: 415, y: 200)
        // Adiciona o node do ~Player~
        self.addChild(player)
    
    
    
        
        
        playButtonNode = (self.childNode(withName: "Play") as! SKSpriteNode)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        scrollWorld()
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch  in touches {
            let location = touch.location(in: self)
            
            player.position.x = location.x
            player.position.y = location.y
            

        }
        
        
        
    }
    
    func scrollWorld() {
        /* Scroll World */
        ScrollLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        for ground in ScrollLayer.children as! [SKSpriteNode] {
            
            /* Get ground node position, convert node position to scene space */
            let groundPosition = ScrollLayer.convert(ground.position, to: self)
            
            /* Check if ground sprite has left the scene */
            if groundPosition.y <= -ground.size.height  {
                
                /* Reposition ground sprite to the second starting position */
                let newPosition = CGPoint(x: groundPosition.x, y: self.size.height  - 10)
                
                /* Convert new node position back to scroll layer space */
                ground.position = self.convert(newPosition, to: ScrollLayer)
            }
        }
        
    }
}

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in:self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "Play" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let newScene = NewScene.init(fileNamed: "NewScene")!
                newScene.scaleMode = SKSceneScaleMode.aspectFill
                view?.presentScene(newScene)
               
            }
            
        }
    }
}
