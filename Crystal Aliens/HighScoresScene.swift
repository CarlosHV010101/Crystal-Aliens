//
//  HighScoresScene.swift
//  Crystal Aliens
//
//  Created by Administrador on 10/04/23.
//

import Foundation
import SpriteKit

class HighScoresScene: SKScene {
    
    override func didMove(to view: SKView) {
        let defaults = UserDefaults()
        let higherScoreNumber = defaults.integer(forKey: "highScore")
        let higherScorePlayer = defaults.string(forKey: "highScorePlayer")
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        if let higherScorePlayer = higherScorePlayer {
            let highScore = SKLabelNode(fontNamed: "The Bold Font")
            highScore.text = "1. \(String(describing: higherScorePlayer)) - \(higherScoreNumber)"
            highScore.fontSize = 100
            highScore.fontColor = SKColor.white
            highScore.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.5)
            highScore.zPosition = 1
            self.addChild(highScore)
        }
        
        let backButton = SKLabelNode(fontNamed: "The Bold Font")
        backButton.text = "Back"
        backButton.fontSize = 100
        backButton.fontColor = SKColor.white
        backButton.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.3)
        backButton.zPosition = 1
        backButton.name = "backButton"
        self.addChild(backButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointTouch = touch.location(in: self)
            
            let nodeTapped = atPoint(pointTouch)
            
            if nodeTapped.name == "backButton" {
                let sceneToMove = MainMenuScene(size: self.size)
                sceneToMove.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMove, transition: transition)
            }
        }
    }
    
    
}

