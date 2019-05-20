//
//  GameScene.swift
//  Breakout
//
//  Created by Zuhair Ali Kahn 2019 on 5/7/19.
//  Copyright © 2019 Zuhair Ali-Khan. All rights reserved.
//

import SpriteKit
import GameplayKit

let BallCategory   : UInt32 = 0x1 << 0
let BottomCategory : UInt32 = 0x1 << 1
let TopCategory  : UInt32 = 0x1 << 2
let LeftCategory : UInt32 = 0x1 << 3
let RightCategory : UInt32 = 0x1 << 4
let PaddleCategory: UInt32 = 0x1 << 5

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var paddle = SKSpriteNode()
    var ball = SKSpriteNode()
    
    var livesLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    
    var removedBlocks : [SKSpriteNode] = []
    
    var score = 0
    var lives = 3
    
    var start = false
    
    override func didMove(to view: SKView) {
        let bottomLeft = CGPoint(x: frame.origin.x, y: frame.origin.y)
        let bottomRight = CGPoint(x: -frame.origin.x, y: frame.origin.y)
        let topRight = CGPoint(x: -frame.origin.x, y: -frame.origin.y)
        let topLeft = CGPoint(x: frame.origin.x, y: -frame.origin.y)
        
        let bottom = SKNode()
        bottom.name = "bottom"
        bottom.physicsBody = SKPhysicsBody(edgeFrom: bottomLeft, to: bottomRight)
        addChild(bottom)
        
        let top = SKNode()
        top.name = "top"
        top.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        addChild(top)
        
        let left = SKNode()
        left.name = "left"
        left.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: bottomLeft)
        addChild(left)
        
        let right = SKNode()
        right.name = "right"
        right.physicsBody = SKPhysicsBody(edgeFrom: topRight, to: bottomRight)
        addChild(right)
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        paddle = self.childNode(withName: "paddle") as! SKSpriteNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        bottom.physicsBody!.categoryBitMask = BottomCategory
        ball.physicsBody!.categoryBitMask = BallCategory
        top.physicsBody!.categoryBitMask = TopCategory
        left.physicsBody!.categoryBitMask = LeftCategory
        right.physicsBody!.categoryBitMask = RightCategory
        paddle.physicsBody?.categoryBitMask = PaddleCategory
        
        ball.physicsBody!.contactTestBitMask = BottomCategory | TopCategory | LeftCategory | RightCategory | PaddleCategory
        
        livesLabel = SKLabelNode(text: "Lives: 3")
        livesLabel.fontSize = 100.0
        livesLabel.position = CGPoint(x: 0, y: -65)
        addChild(livesLabel)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontSize = 100.0
        scoreLabel.position = CGPoint(x: 0, y: -150)
        addChild(scoreLabel)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if(contact.bodyA.categoryBitMask == BottomCategory){
            lives = lives - 1
            livesLabel.text = "Lives: \(lives)"
            if(lives != 0){
                ball.removeFromParent()
                ball.position = CGPoint(x: 0, y: -20)
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                self.addChild(ball)
                start = false
            }
            else{
                ball.removeFromParent()
                livesLabel.text = "Game Over"
                print("lost")
            }
        }
        else if(contact.bodyA.categoryBitMask != TopCategory && contact.bodyA.categoryBitMask != LeftCategory && contact.bodyA.categoryBitMask != RightCategory && contact.bodyA.categoryBitMask != PaddleCategory) {
            contact.bodyA.node?.removeFromParent()
            removedBlocks.append(contact.bodyA.node as! SKSpriteNode)
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            
            if score == 40 {
                livesLabel.text = "You Win!"
                ball.removeFromParent()
                ball.position = CGPoint(x: 0, y: -20)
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                self.addChild(ball)
                start = false
                print("win")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        paddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
        
        if !start {
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: -20))
            start = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        paddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func restartGame(){
        lives = 3
        score = 0
        ball.removeFromParent()
        ball.position = CGPoint(x: 0, y: -20)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.addChild(ball)
        start = false
        print("ok")
        livesLabel.text = "Lives: \(lives)"
        scoreLabel.text = "Score: \(score)"
        for block in removedBlocks {
            addChild(block)
        }
    }
}
