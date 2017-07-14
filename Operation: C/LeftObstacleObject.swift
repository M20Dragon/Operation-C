//
//  Obstacle.swift
//  Operation: C
//
//  Created by Timur Guler on 6/7/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import Foundation
import SpriteKit

class LeftObstacleObject: SKSpriteNode
{
    override init(texture: SKTexture!, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLeftObstacle(cradle: Int)
    {
        self.texture = SKTexture(imageNamed: "LeftObstacle")
        self.position = CGPoint(x: 0, y: cradle)
        //self.size = CGSize(width: 300, height: 100)
    }
    
    func placeLeftObstacle() -> Int
    {
        let leftRandomizer: Int = Int(arc4random_uniform(300))//must be negative
        return leftRandomizer
    }
}
