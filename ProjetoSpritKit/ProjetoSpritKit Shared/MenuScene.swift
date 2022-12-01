//
//  MenuScene.swift
//  ProjetoSpritKit iOS
//
//  Created by Vinicius Gomes on 22/11/22.
//

import Foundation
import SpriteKit
class MenuScene: SKScene {
    var dados = Dados()
    var playButtonNode: SKSpriteNode?

    let effectSound = SKAudioNode(fileNamed: "Space Jazz")
    override func sceneDidLoad() {
        dados.carregarDados()
        
        if let ScoreNumber = childNode(withName: "ScoreNumber") as? SKLabelNode {
            ScoreNumber.text = String(format: "%.2f", dados.Recorde!)
        
        }
        
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
    override func didMove(to view: SKView) {
        
        playButtonNode = (self.childNode(withName: "PlayV2") as? SKSpriteNode)
        //Adiciona musica ao jogo
        addChild(effectSound)
//        var effectSound = SKAction.playSoundFileNamed("Space Jazz", waitForCompletion: false)
//        run(effectSoun)
//    https://medium.com/academy-ifce/primeiros-passos-com-spritekit-4710ee69a4c0
       }
       
       
       override func update(_ currentTime: TimeInterval) {
           // Called before each frame is rendered
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           let touch = touches.first
           
           if let location = touch?.location(in:self) {
               let nodesArray = self.nodes(at: location)
               
               if nodesArray.first?.name == "PlayV2" {
                   let transition = SKTransition.crossFade(withDuration: 0.5)
                   let newScene = GameScene.init(fileNamed: "GameScene")!
//                   var effectSound = SKAction.playSoundFileNamed("Space Jazz", waitForCompletion: false)
//                   run(effectSound)
                   newScene.scaleMode = SKSceneScaleMode.aspectFit
                   view?.presentScene(newScene, transition: transition)
                  
               }
               
           }
       }
}
