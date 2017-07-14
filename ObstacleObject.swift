//
//  ObstacleObject.swift
//  Operation: C
//
//  Created by Timur Guler on 7/7/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import Foundation
import SpriteKit

class ObstacleObject: SKSpriteNode
{
    override init(texture: SKTexture!, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
