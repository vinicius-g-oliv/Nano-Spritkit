//
//  GameScene.swift
//  ProjetoSpritKit Shared
//
//  Created by Vinicius Gomes on 03/11/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 500
    var ScrollLayer: SKNode!
    var player: SKNode!
    
    
    var gameTimer: Timer?
    
    let ship = SKSpriteNode()
    
    
    // MARK: cria os meteoros
    // de forma aleatoria ja sorteando as imagens e posicoes
    @objc func createMeteoro(){
        let randomPos = Int.random(in: 0..<8)
        let x_values = [-100,0,150,300,450,600,800,1000]
        let x_values1 = [100,200,300,400,500,600,700,800]
        let fotinhos = ["MeteoroV1_1", "MeteoroV1_2", "MeteoroV1_3", "MeteoroV1_4", "MeteoroV1_5", "MeteoroV1_6", "MeteoroV1_7", "MeteoroV1_8"]
        
        
        let meteoro = SKSpriteNode(imageNamed: fotinhos[randomPos])
        
        
        meteoro.size = CGSize(width: 150, height: 150)
        meteoro.position = CGPoint(x: x_values[randomPos], y: 2000)
        
        
        meteoro.physicsBody = SKPhysicsBody(rectangleOf: meteoro.frame.size)
        meteoro.physicsBody!.isDynamic = true
        meteoro.physicsBody!.affectedByGravity = false
        meteoro.physicsBody!.categoryBitMask = 1
        meteoro.physicsBody!.usesPreciseCollisionDetection = true
        
        self.addChild(meteoro)
        //duration = tempo que o meteoro demora para percorrer a tela
        let moveUp = SKAction.move(to: CGPoint(x: x_values1[randomPos], y: -200), duration: 2)
        meteoro.run(moveUp)
       
       

        
        
    }
    
   
    @objc func deleteMeteor(){
        
    }

    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        self.physicsWorld.contactDelegate = self
        
       
    }
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
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(createMeteoro), userInfo: nil, repeats: true)
        self.physicsWorld.contactDelegate = self
        
        createMeteoro()
        
        ScrollLayer = self.childNode(withName: "ScrollLayer")
        //MARK: Sprite player
        player = SKSpriteNode(imageNamed: "GatoV2")
        // Define a posição do ~Player~
        player.position = CGPoint(x: 415, y: 200)
        let body = SKPhysicsBody(rectangleOf: player.frame.size)
        body.affectedByGravity = true
        player?.physicsBody = body
        body.contactTestBitMask = 1
        
        // let body = SKPhysicsBody(rectangleOf: player?.size ?? .zero)
        //  player?.physicsBody = body
        // Adiciona o node do ~Player~
        self.addChild(player)

        
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact){
        print("encostou ")
        let transition = SKTransition.flipHorizontal(withDuration: 0.3)
        let newScene = MenuScene.init(fileNamed: "MenuScene")!
        newScene.scaleMode = SKSceneScaleMode.aspectFill
        view?.presentScene(newScene)
        
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
            player.position.y = location.y

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

