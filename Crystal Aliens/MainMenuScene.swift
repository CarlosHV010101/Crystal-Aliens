//
//  MainMenuScene.swift
//  Crystal Aliens
//
//  Created by Administrador on 03/04/23.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameNameTop = SKLabelNode(fontNamed: "The Bold Font")
        gameNameTop.text = "Crystal"
        gameNameTop.fontSize = 200
        gameNameTop.fontColor = SKColor.white
        gameNameTop.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.7)
        gameNameTop.zPosition = 1
        self.addChild(gameNameTop)
        
        let gameNameBottom = SKLabelNode(fontNamed: "The Bold Font")
        gameNameBottom.text = "Aliens"
        gameNameBottom.fontSize = 200
        gameNameBottom.fontColor = SKColor.white
        gameNameBottom.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.625)
        gameNameBottom.zPosition = 1
        self.addChild(gameNameBottom)
        
        let startGame = SKLabelNode(fontNamed: "The Bold Font")
        startGame.text = "Start Game"
        startGame.fontSize = 100
        startGame.fontColor = SKColor.white
        startGame.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.4)
        startGame.zPosition = 1
        startGame.name = "startButton"
        self.addChild(startGame)
        
        let highScores = SKLabelNode(fontNamed: "The Bold Font")
        highScores.text = "High Scores"
        highScores.fontSize = 100
        highScores.fontColor = SKColor.white
        highScores.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.3)
        highScores.zPosition = 1
        highScores.name = "highScoresButton"
        self.addChild(highScores)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointTouch = touch.location(in: self)
            
            let nodeTapped = atPoint(pointTouch)
            
            if nodeTapped.name == "startButton" {
                let sceneToMove = GameScene(size: self.size)
                sceneToMove.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMove, transition: transition)
            }
            
            if nodeTapped.name == "highScoresButton" {
                let sceneToMove = HighScoresScene(size: self.size)
                sceneToMove.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMove, transition: transition)
            }
        }
    }
}
