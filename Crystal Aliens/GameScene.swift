//
//  GameScene.swift
//  Crystal Aliens
//
//  Created by Administrador on 01/04/23.
//

import SpriteKit
import GameplayKit

var gameScore = 0

class GameScene: SKScene {
        
    let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
    var levelNumber = 0
    
    enum GameState {
        case preGame
        case inGame
        case afterGame
        case continueGame
    }
    
    var currentGameState: GameState = .preGame
    var shieldActivated: Bool = false
    
    var livesNumber = 3
    let livesLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let player: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "playerShip")
        return SKSpriteNode(texture: texture)
    }()
    
    let bulletSound = SKAction.playSoundFileNamed(
        "151023__bubaproducer__laser-shot-short.wav",
        waitForCompletion: false
    )
    
    let explosionSound = SKAction.playSoundFileNamed("455918__bolkmar__missile-launcher-explosion-only", waitForCompletion: false)
    
    let tapToStartLabel = SKLabelNode(fontNamed: "The Bold Font")
    let tapToContinueLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    
    struct PhysicsCategories {
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1 //1
        static let Bullet: UInt32 = 0b10 //2
        static let Enemy: UInt32 = 0b100 //4
    }
    
    func coordinatesRandom() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return coordinatesRandom() * (max - min) + min
    }
    
    
    var gameArea: CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0 / 9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        gameScore = 0
        
        self.physicsWorld.contactDelegate = self
        
        createBackground()
        
        createPlayer()
        
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width * 0.20, y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        livesLabel.text = "Lives: 3"
        livesLabel.fontSize = 70
        livesLabel.fontColor = SKColor.white
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.position = CGPoint(x: self.size.width * 0.80, y: self.size.height + livesLabel.frame.size.height)
        livesLabel.zPosition = 100
        self.addChild(livesLabel)

        
        let moveOnToScreenAction = SKAction.moveTo(y: self.size.height * 0.9, duration: 0.3)
        scoreLabel.run(moveOnToScreenAction)
        livesLabel.run(moveOnToScreenAction)
        
        tapToStartLabel.text = "Tap to Begin"
        tapToStartLabel.fontSize = 100
        tapToStartLabel.fontColor = SKColor.white
        tapToStartLabel.zPosition = 1
        tapToStartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        tapToStartLabel.alpha = 0
        self.addChild(tapToStartLabel)
                
        let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
        tapToStartLabel.run(fadeInAction)
    }
    
    func createPlayer() {
        //PLAYER SPRITE
        player.setScale(1)
        player.position = CGPoint(x: self.size.width / 2, y:  0 - player.size.height)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        
        self.addChild(player)
    }
    
    func createBackground() {
        //BACKGROUND SPRITE
        for i in 0...1 {
            let background = SKSpriteNode(imageNamed: "background")
            background.size = self.size
            background.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            background.position = CGPoint(
                x: self.size.width / 2,
                y: self.size.height * CGFloat(i)
            )
            background.zPosition = 0
            background.name = "Background"
            self.addChild(background)
        }
    }
    
    func createTapToContinueLabel() {
        tapToContinueLabel.text = "Tap to Continue"
        tapToContinueLabel.fontSize = 100
        tapToContinueLabel.fontColor = SKColor.white
        tapToContinueLabel.zPosition = 1
        tapToContinueLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        tapToContinueLabel.alpha = 0
        self.addChild(tapToContinueLabel)
                
        let fadeInAction = SKAction.fadeIn(withDuration: 0.3)
        tapToContinueLabel.run(fadeInAction)
    }
    
    var lastUpdateTime: TimeInterval = 0
    var deltaFrameTime: TimeInterval = 0
    var amountToMovePerSecond: CGFloat = 600.0
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0{
            lastUpdateTime = currentTime
        }else{
            deltaFrameTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
            let amountToMoveBackground = amountToMovePerSecond * CGFloat (deltaFrameTime)
            self.enumerateChildNodes(withName: "Background") {
                background, stop in
                if self.currentGameState == .inGame{
                    background.position.y -= amountToMoveBackground
                }
                if background.position.y < -self.size.height{
                    background.position.y += self.size.height*2
                }
            }
        }
    }
    
    func startGame() {
        
        if currentGameState == .preGame {
            deleteTapToStartLabel()
        }
        
        if currentGameState == .continueGame {
            deleteTapToContinueLabel()
            createPlayer()
        }
        
        currentGameState = .inGame
        
        
        let moveShipOntoScreenAction = SKAction.moveTo(y: self.size.height * 0.2, duration: 0.5)
        let startLevelAction = SKAction.run(startNewLevel)
        let startGameSequence = SKAction.sequence([moveShipOntoScreenAction, startLevelAction])
        
        player.run(startGameSequence)
        
    }
    
    func deleteTapToStartLabel() {
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        
        tapToStartLabel.run(deleteSequence)
    }
    
    func deleteTapToContinueLabel() {
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        
        tapToContinueLabel.run(deleteSequence)
    }
    
    func loseLife() {
        livesNumber -= 1
        livesLabel.text = "Lives: \(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 3.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        if livesNumber != 0 {
            startNewLifeAfterCrash()
        } else {
            runGameOver()
        }
    }
    
    func winLife() {
        livesNumber += 1
        livesLabel.text = "Lives: \(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 3.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
    }
    
    func addScore() {
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        
        if gameScore % 25 == 0 {
            winLife()
        }
        
        if gameScore % 10 == 0 {
            startNewLevel()
        }
        
        if gameScore % 20 == 0 {
            activateShield()
        }
    }
    
    func activateShield() {
        shieldActivated = true
        player.color = SKColor.systemBlue
        player.color = SKColor.systemBlue
        player.colorBlendFactor = 1.0
    }
    
    func desactivateShield() {
        shieldActivated = false
        player.colorBlendFactor = 0
    }
    
    func startNewLevel() {
        
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemies") != nil {
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = TimeInterval()
        var spawnDuration = TimeInterval()
         
        switch levelNumber {
        case 1:
            levelDuration = 3
            spawnDuration = 2.5
        case 2:
            levelDuration = 2.5
            spawnDuration = 2.3
        case 3:
            levelDuration = 2
            spawnDuration = 2.1
        case 4:
            levelDuration = 1.9
            spawnDuration = 1.9
        case 5:
            levelDuration = 1.9
            spawnDuration = 1.7
        case 6:
            levelDuration = 1.7
            spawnDuration = 1.5
        case 7:
            levelDuration = 1.6
            spawnDuration = 1.3
        case 8:
            levelDuration = 1.5
            spawnDuration = 1.1
        case 9:
            levelDuration = 1.5
            spawnDuration = 1
        default:
            levelDuration = 1
            spawnDuration = 1
        }
        
        let spawn = SKAction.run {
            self.spawnEnemy(duration: spawnDuration)
        }
        let waitToSpan = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpan, spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever, withKey: "spawningEnemies")
    }
    
    func runGameOver() {
        
        currentGameState = GameState.afterGame
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Bullet") { bullet, stop in
            bullet.removeAllActions()
            
        }
        
        self.enumerateChildNodes(withName: "Enemy") { enemy, stop in
            enemy.removeAllActions()
        }
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
        
    }
    
    func startNewLifeAfterCrash() {
        currentGameState = GameState.continueGame
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Bullet") { bullet, stop in
            bullet.removeAllActions()
            let deleteBullet = SKAction.removeFromParent()
            let bulletSequence = SKAction.sequence([deleteBullet])
            bullet.run(bulletSequence)
        }
        
        self.enumerateChildNodes(withName: "Enemy") { enemy, stop in
            enemy.removeAllActions()
        }
        
        createTapToContinueLabel()
    }
    
    func changeScene() {
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: transition)
    }
    
    func fireBullet() {
        
        //BULLET SPRITE
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.name = "Bullet"
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
        bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
        bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequence)
        
    }
    
    func spawnEnemy(duration: TimeInterval) {
        let randomXStart = random(
            min: gameArea.minX + player.size.width * 2, // HERE
            max: gameArea.maxX - player.size.width * 2
        )
        let randomxEnd = random(
            min: gameArea.minX + player.size.width * 2,
            max: gameArea.maxX - player.size.width * 2
        )
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomxEnd, y: self.size.height * 0.2)
        
        //ENEMY SPRITE
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.name = "Enemy"
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: duration)
        let deleteEnemy = SKAction.removeFromParent()
        let loseLifeAction = SKAction.run(runGameOver)
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseLifeAction])
        
        let differenceX = endPoint.x - startPoint.x
        let differenceY = endPoint.y - startPoint.y
        let amountToRotate = atan2(differenceY, differenceX)
        enemy.zRotation = amountToRotate
        
        if currentGameState == .inGame {
            enemy.run(enemySequence)
        }
        
    }
    
    func spawnExplosion(spawnPosition: CGPoint) {
        
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentGameState == .preGame || currentGameState == .continueGame {
            startGame()
        }
        
        if currentGameState == .inGame {
            fireBullet()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            if currentGameState == .inGame {
                player.position.x += amountDragged
            }
            
            if player.position.x > gameArea.maxX - player.size.width * 2 {
                player.position.x = gameArea.maxX - player.size.width * 2
                
            }
            
            if player.position.x < gameArea.minX + player.size.width * 2 { player.position.x = gameArea.minX + player.size.width * 2
                
            }
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            body1 = contact.bodyA
            body2 = contact.bodyB
        } else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy {
            //if the player has hit the enemy
            
            if let body1Position = body1.node?.position {
                if !shieldActivated {
                    spawnExplosion(spawnPosition: body1Position)
                }
            }
            
            if let body2Position = body2.node?.position {
                spawnExplosion(spawnPosition: body2Position)
            }
            
            if shieldActivated {
                desactivateShield()
            } else {
                body1.node?.removeFromParent()
                loseLife()
            }
            
            body2.node?.removeFromParent()
                                    
        }
        
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy && body2.node?.position.y ?? 0 < size.height {
            //if the bullet has hit the enemy
            addScore()
            
            if let body2Position = body2.node?.position {
                spawnExplosion(spawnPosition: body2Position)
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
                        
        }
    }
}
