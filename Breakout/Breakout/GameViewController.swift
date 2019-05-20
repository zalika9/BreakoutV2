//
//  GameViewController.swift
//  Breakout
//
//  Created by Zuhair Ali Kahn 2019 on 5/7/19.
//  Copyright © 2019 Zuhair Ali-Khan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            //shows FPS
            view.showsFPS = true
            view.showsNodeCount = true
            
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    //makes it easier for the user to see the application/
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    //can make the statusBarHidden
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //prompts directions to be shown when pressed
    @IBAction func onDirectionsButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    //restarts game
    @IBAction func onRestartButtonPressed(_ sender: UIBarButtonItem) {
        let gameScene = GameScene()
        gameScene.restartGame()
    }
    
}
