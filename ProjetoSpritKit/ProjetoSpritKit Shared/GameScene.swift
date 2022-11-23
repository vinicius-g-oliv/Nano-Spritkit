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
    var backgroundMusic: SKAudioNode!
    
    
    class func newGameScene() -> GameScene {
        //MARK: Load 'GameScene.sks' as an SKScene.
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
        //MARK: Sprite player
        player = SKSpriteNode(imageNamed: "GatoV2")
        // Define a posição do ~Player~
        player.position = CGPoint(x: 415, y: 200)
        // Adiciona o node do ~Player~
        self.addChild(player)
      
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        scrollWorld()
    }
    
    override  func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       //MARK: Movimenta pela tela
        for touch  in touches {
            let location = touch.location(in: self)
            
            player.position.x = location.x
            player.position.y = 200

        }
        
        
        
    }
    
    func scrollWorld() {
        //MARK: Movimento do background
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

