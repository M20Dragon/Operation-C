//
//  ObstacleNode.swift
//  Operation: C
//
//  Created by Timur Guler on 6/22/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class obstacleNode: CGRect
{
    private var xPos: Int
    private var yPos: Int
    private var rect: CGRect
    
    init(rectOf: CGSize, xPos: Int, yPos: Int)
    {
        self.xPos = xPos
        self.yPos = yPos
        rect = CGRect(origin: CGPoint(x: xPos, y: yPos), size: rectOf)
        
        
        
        
        
        
    }
    
    func getObjectIdentity() -> CGRect
    {
        return self.rect
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
