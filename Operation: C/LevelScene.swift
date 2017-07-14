//
//  GameScene.swift
//  Operation: C
//
//  Created by Timur Guler on 5/26/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory
{
    static let Obstacle: UInt32 = 0x1 << 0 // Set the obstacle physicsDelagate
    static let Ship: UInt32 = 0x1 << 1 // Set the ship physicsDelagate
}

private var backgroundNode: SKSpriteNode = SKSpriteNode() // Declare the node that controls the background
private var shipNode: SKSpriteNode = SKSpriteNode()
private var defaultScoreText: String = ""
private var speed: Int = 100
private var score: Int = 0
private var obstacleGenerator: [ControlSurface] = []
                                   //private var trueObstacleGenerator: [ObstacleObject] = [] //TEST
private var rectGeneration: [TestRect] = []
private var rectIdentityGeneration: [CGRect] = []
private var obstacleMemoryIndex: Int = 0

class LevelScene: SKScene, SKPhysicsContactDelegate
{

    private var scoreLabel: SKLabelNode?
    var backgroundColours = [UIColor()]
    var backgroundLoop = 0
    
    
    override func didMove(to view: SKView)
    {
        
        
        score = 0
        obstacleMemoryIndex = 0
        obstacleGenerator.removeAll()
                            //trueObstacleGenerator.removeAll() //TEST
        rectGeneration.removeAll()
        rectIdentityGeneration.removeAll()
        
        self.isPaused = false
        
        self.physicsWorld.contactDelegate = self
        
        //self.backgroundColor = UIColor.clear
        
                
        backgroundNode.size = CGSize(width: self.size.width, height: self.size.height)
        backgroundNode.position = CGPoint(x: -(self.size.width / 2), y: -(self.size.height / 2))
        //self.addChild(backgroundNode)
        backgroundNode.color = UIColor.blue
    
        
        animateBackgroundColour()
        
        self.scoreLabel = self.childNode(withName: "ScoreLabel") as? SKLabelNode
    
        
        if let findShip: SKSpriteNode = self.childNode(withName: "shipNode") as? SKSpriteNode
        {
            print("ship initized")
            shipNode = findShip
            shipNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 90))
            shipNode.physicsBody?.isDynamic = true
            shipNode.physicsBody?.affectedByGravity = false
            shipNode.physicsBody?.isResting = true
            shipNode.physicsBody?.categoryBitMask = PhysicsCategory.Ship
            shipNode.physicsBody?.contactTestBitMask = PhysicsCategory.Obstacle
            shipNode.physicsBody?.collisionBitMask = PhysicsCategory.Obstacle
            shipNode.name = "Ship"
        } else {
            print("ERROR")
        }
        
        
        for i in 0...1999
        {
            let thisDeter = determineSideAndSize()
            print(thisDeter)
            obstacleGenerator.append(ControlSurface(rectOf: CGSize(width: self.size.width, height: 500), xPos: 0 - Int(self.size.width / 2), yPos: 500 * i))
            rectGeneration.append(TestRect(rectOf: CGSize(width: 800, height: 100),xPos: thisDeter, yPos: (500 * i) + ((obstacleGenerator[i].getHeight()) - 100)))
           // trueObstacleGenerator.appen
            
            
            self.addChild(rectGeneration[i])
            self.addChild(obstacleGenerator[i])
            
            obstacleMemoryIndex = i
        }

    }
    
    func touchDown(atPoint pos : CGPoint)
    {
        
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        
        
    }
    
    func touchUp(atPoint pos : CGPoint)
    {
        moveShip(pos: pos)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        score += 1
        updateScore(score: score)
        
        
        for obstacleParser in 0...obstacleGenerator.count-1
        {
            obstacleGenerator[obstacleParser].run(SKAction.moveBy(x: 0, y: -speed, duration: 1))
            rectGeneration[obstacleParser].run(SKAction.moveBy(x: 0, y: -speed, duration: 1))
        }
        
        speed += 0.005
        
        if score > (99999)
        {
            score = 99999
            //you beat the game
        }
        shipNode.physicsBody?.usesPreciseCollisionDetection = true
        
        if obstacleHitBottom()
        {
            deleteObstacle(index: obstacleMemoryIndex)
            makeObstacle(yPos: 500 * obstacleMemoryIndex)
            obstacleMemoryIndex += 1
        }
    
    }
    
    func moveShip(pos: CGPoint)
    {
        let moveRight: SKAction = SKAction.moveBy(x: 70, y: 0, duration: 0.5)
        let moveLeft: SKAction = SKAction.moveBy(x: -70, y: 0, duration: 0.5)
        let touchPosition = pos
        if touchPosition.x > (self.view?.bounds.maxX)! / 2 - 210
        {
            if(shipNode.position.x < self.size.width / 2 - 100)
            {
            shipNode.run(moveRight)
            }
        }
        else if touchPosition.x < (self.view?.bounds.maxX)! / 2
        {
            if(shipNode.position.x > -self.size.width / 2 + 100)
            {
            shipNode.run(moveLeft)
            }
        }
    }
    
    func animateBackgroundColour()
    {
        if backgroundLoop < backgroundColours.count - 1
        {
            backgroundLoop += 1
        } else {
            backgroundLoop = 0
        }
        /*backgroundNode.run(SKAction.fadeIn(withDuration: 3))
         {
         backgroundNode.color = self.backgroundColours[self.backgroundLoop]
         }*/
        while score > 1000 {
            
            backgroundNode.run(SKAction.colorize(with: UIColor.red/*self.backgroundColours[self.backgroundLoop]*/, colorBlendFactor: 1.0, duration: 2.0))
        }
        //animateBackgroundColour()
    }
    
    func updateScore(score: Int)
    {
        scoreLabel?.text = "SCORE: " + String(score)
    }
    
    func determineSideAndSize() -> Int
    {
        let deviceBound: Int
        let tabletException = ["iPad Air","iPad Air 2","iPad Mini 4", "iPad Pro","Simulator"]
        let modelName = UIDevice.current.modelName
        if tabletException.contains(modelName)
        {
            deviceBound = 400
        }
        else
        {
            deviceBound = 150
        }
        let randomNumber = Int(arc4random_uniform(11))
        if randomNumber > 4
        {
            let rightRandom = Int(arc4random_uniform(UInt32(deviceBound))) + -200
            return  rightRandom
        }else{
            let up = Int(self.size.width / 2) - deviceBound
            let down = Int(self.size.width) - deviceBound
            let leftRandom = Int(arc4random_uniform(UInt32(up))) + down
            return -leftRandom
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA.node as! SKSpriteNode
        let secondBody = contact.bodyB.node as! TestRect
        
        if ((firstBody.name == "Ship") && (secondBody.name == "Obstacle") || (firstBody.name == "Obstacle") && (secondBody.name == "Ship"))
        {
            print("GAME OVER")
            
            self.isPaused = true
            lostGame()
        }
    }
    
    func obstacleHitBottom() -> Bool
    {
        //return true
        return false
    }
    
    func deleteObstacle(index: Int)
    {
        rectGeneration.remove(at: index)
        rectIdentityGeneration.remove(at: index)
    }
    
    func makeObstacle(yPos: Int)
    {
        let thisDeter = determineSideAndSize()
        rectGeneration.append(TestRect(rectOf: CGSize(width: 800, height: 100),xPos: thisDeter, yPos: (500 * obstacleMemoryIndex) + ((obstacleGenerator[obstacleMemoryIndex].getHeight()) - 100)))
        
        
        self.addChild(rectGeneration[obstacleMemoryIndex])
        self.addChild(obstacleGenerator[obstacleMemoryIndex])
        
    }
    
    func lostGame()
    {
        if let controller = self.view?.window?.rootViewController as? GameViewController {
            controller.showLoseMenu()
        }
        
    }

    func getScore() -> Int
    {
        return score
    }
}
