//
//  NewScene.swift
//  ProjetoSpritKit iOS
//
//  Created by Guilherme Lozano Borges on 22/11/22.
//

import Foundation

import SpriteKit

class NewScene: SKScene {
    class func newGameScene() -> NewScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? NewScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
}
