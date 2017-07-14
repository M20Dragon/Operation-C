//
//  RightObstacle.swift
//  Operation: C
//
//  Created by Timur Guler on 6/7/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import Foundation
import SpriteKit

class RightObstacleObject: SKSpriteNode
{
    override init(texture: SKTexture!, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeRightObstacle(cradle: Int)
    {
        
    }
    
    func placeRightObstacle() -> Int
    {
        let RightRandomizer: Int = Int(arc4random_uniform(300))//must be negative
        return RightRandomizer
    }
}
