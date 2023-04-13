//
//  GameOverScene.swift
//  Crystal Aliens
//
//  Created by Administrador on 01/04/23.
//

import GameplayKit
import GameKit
import SpriteKit

class GameOverScene: SKScene, Alertable {
    
    let defaults = UserDefaults()
    let higherScoreNumber = UserDefaults.standard.integer(forKey: "highScore")
    
    let restartLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        
        let gameOverLabel = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 165
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        let defaults = UserDefaults()
        var higherScoreNumber = defaults.integer(forKey: "highScore")
        
        print(higherScoreNumber)
        
        if gameScore > higherScoreNumber {
            higherScoreNumber = gameScore
            defaults.set(higherScoreNumber, forKey: "highScore")
        }
     
        let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        highScoreLabel.text = "High Score \(higherScoreNumber)"
        highScoreLabel.fontSize = 125
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.45)
        self.addChild(highScoreLabel)
                
        restartLabel.text = "Restart"
        restartLabel.fontSize = 90
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.3)
        self.addChild(restartLabel)
        
        saveScore()
        
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if restartLabel.contains(pointOfTouch) {
                
                let sceneToMove = GameScene(size: self.size)
                sceneToMove.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMove, transition: transition)
            }
        }
    }
    
    
    func saveScore() {
        
        if gameScore > higherScoreNumber {
            showAlert(withTitle: "High Score", message: "Introduzca un nombre de 5 letras", action: saveNewHighScore)
            saveHigher(gameScore)
        }
    }
    
    func saveNewHighScore(player: String) {
        defaults.set(player, forKey: "highScorePlayer")
    }
    
    func saveHigher(_ score: Int) {
        defaults.set(score, forKey: "highScore")
    }
    
}

