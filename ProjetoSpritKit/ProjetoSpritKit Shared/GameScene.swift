//
//  GameScene.swift
//  ProjetoSpritKit Shared
//
//  Created by Vinicius Gomes on 03/11/22.
//

import SpriteKit
import GameplayKit
let kMinDistance = 25
let kMinDuration = 0.1
let kMinSpeed = 100
let kMaxSpeed = 7000
let initialSpeedUpFrequency : Double = 15

class GameScene: SKScene, SKPhysicsContactDelegate {
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 500
    var ScrollLayer: SKNode!
    var player: SKSpriteNode!
    var gameTimer: Timer?
    let effectSound = SKAudioNode(fileNamed: "Space Jazz")
    var score:  SKSpriteNode!
    var moveUP: SKAction!
    private var lastUpdateTime : TimeInterval = 0
    private var lastSpeedUp : TimeInterval = 2
    private var speedUpFrequency = initialSpeedUpFrequency
    private var countdownTime : TimeInterval = 0
    private var playTime : TimeInterval = 0
    private var dados = Dados()
    private var fontColor = UIColor.white
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
   
    
    @objc func createMeteoro(){
        let randomPos = Int.random(in: 0..<10)
        let x_values = [-100,0,150,250,300,450,600,800,850,1000]
        let x_values1 = [100,200,300,400,500,600,700,800,850,1000]
        let fotinhos = ["MeteoroV1_1", "MeteoroV1_2", "MeteoroV1_3", "MeteoroV1_4", "MeteoroV1_5", "MeteoroV1_6", "MeteoroV1_7", "MeteoroV1_8","MeteoroV1_7", "MeteoroV1_8"]
        
        
        let meteoro = SKSpriteNode(imageNamed: fotinhos[randomPos])
        
        
        meteoro.size = CGSize(width: 85, height: 85)
        meteoro.position = CGPoint(x: x_values[randomPos], y: 2000)
        meteoro.physicsBody = SKPhysicsBody(rectangleOf: meteoro.frame.size)
        meteoro.physicsBody!.isDynamic = true
        meteoro.physicsBody!.affectedByGravity = false
        meteoro.physicsBody!.categoryBitMask = 1
        meteoro.physicsBody!.usesPreciseCollisionDetection = true
        
        self.addChild(meteoro)
        
         moveUP = SKAction.move(to: CGPoint(x: x_values1[randomPos], y: -200), duration: 2)
        
        meteoro.run(moveUP)
        

        let remove = SKAction.wait(forDuration: 1)
        
        let sequence = SKAction.sequence([moveUP,
            remove,
            .run {
                meteoro.removeFromParent()
            }
        ])
        meteoro.run(sequence)
       
    
        
    }
  
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.physicsWorld.contactDelegate = self
        
//        dados.carregarDados()
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
        createPlayer()
        addChild(effectSound)

        
    }
    
    
    //MARK: Faz a fisica do jogo
    func didBegin(_ contact: SKPhysicsContact){
       
        let transition = SKTransition.crossFade(withDuration: 0.3)
        let newScene = GameOverScene.init(fileNamed: "GameOverScene")!
        newScene.scaleMode = SKSceneScaleMode.aspectFill
        view?.presentScene(newScene, transition: transition)
        

    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        scrollWorld()
        
        // Calculate time since last update
        if self.lastUpdateTime == 0 {
                   self.lastUpdateTime = currentTime + 2
                   self.lastSpeedUp = lastUpdateTime
                   self.countdownTime = currentTime
               }
               
               // Calculate time since last update
               let dt = currentTime - self.lastUpdateTime
               
               
                   playTime = currentTime - countdownTime

                   if let lblTime = childNode(withName: "Score") as? SKLabelNode {
                       lblTime.text = String(format: "%.2f", playTime)
                   }
                   
               
               // Update entities
               for entity in self.entities {
                   entity.update(deltaTime: dt)
               }
               
              
               
               self.lastUpdateTime = currentTime
      
    }

    
    override  func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Avoid multi-touch gestures (optional) */
               if touches.count > 1 {
                   return;
               }
     
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
    func createPlayer() {
        //MARK: Sprite player
        player = self.childNode(withName: "catNode") as? SKSpriteNode
        // Define a posição do ~Player~
        player.position = CGPoint(x: 415, y: 200)
        let body = SKPhysicsBody(rectangleOf: player.frame.size)
        player?.physicsBody = body
        body.contactTestBitMask = 1
        
    }

}


