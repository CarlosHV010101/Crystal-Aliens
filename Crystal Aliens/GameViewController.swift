//
//  GameViewController.swift
//  Crystal Aliens
//
//  Created by Administrador on 01/04/23.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backingAudio = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "air_war", ofType: "m4a")
        let audioURL = URL(fileURLWithPath: filePath!)
        
        do {
            backingAudio = try AVAudioPlayer(contentsOf: audioURL)
        } catch {
            print("ERROR PLAYING AUDIO", error.localizedDescription)
        }
        
        backingAudio.numberOfLoops = -1
        backingAudio.play()
        
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            
            let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
            
            view.showsFPS = false
            view.showsNodeCount = false
            
            // Set the scale mode to scale to fit the window
            
            scene.scaleMode = .aspectFill
            
            // Present the scene
            
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
        }
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
