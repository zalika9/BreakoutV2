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
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    @IBAction func directionsButton(_ sender: UIButton) {
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
