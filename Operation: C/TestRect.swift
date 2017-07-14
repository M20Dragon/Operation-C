//
//  TestRect.swift
//  Operation: C
//
//  Created by Timur Guler on 6/8/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import Foundation
import SpriteKit

let category0: UInt32 = 0x1 << 0
let category1: UInt32 = 0x1 << 1
let category2: UInt32 = 0x1 << 2
let category3: UInt32 = 0x1 << 4

class TestRect: SKShapeNode
{
    private var xPos: Int
    private var yPos: Int
    private var rect: CGRect
    
    init(rectOf: CGSize, xPos: Int, yPos: Int)
    {
        self.xPos = xPos
        self.yPos = yPos
        rect = CGRect(origin: CGPoint(x: xPos, y: yPos), size: rectOf)
        
        super.init()
        
        self.name = "ControlSurface"
        self.fillColor = SKColor.red
        self.strokeColor = SKColor.blue
        self.path = CGPath(rect: rect, transform: nil)
        let centerPoint = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 100), center: centerPoint)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Obstacle
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Ship
        self.physicsBody?.collisionBitMask = PhysicsCategory.Ship
        self.name = "Obstacle"
    
        

    }
    
    func getObjectIdentity() -> CGRect
    {
        return self.rect
    }
    
    func getXPos() -> Int
    {
        return self.xPos
    }
    
    func getYPos() -> Int
    {
        return self.yPos
    }
    
    func getWidth() -> Int
    {
        return Int(self.rect.width)
    }
    
    func getHeight() -> Int
    {
        return Int(self.rect.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
