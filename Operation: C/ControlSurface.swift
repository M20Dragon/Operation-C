//
//  Obstacle.swift
//  Operation: C
//
//  Created by Timur Guler on 6/3/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ControlSurface: SKShapeNode
{
    private var xPos: Int
    private var yPos: Int
    
    init(rectOf: CGSize, xPos: Int, yPos: Int)
    {
        self.xPos = xPos
        self.yPos = yPos
        
        super.init()
        
        self.name = "ControlSurface"
        self.fillColor = SKColor.clear
        self.strokeColor = SKColor.clear
        let rect = CGRect(origin: CGPoint(x: xPos, y: yPos), size: rectOf)
        self.path = CGPath(rect: rect, transform: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func getXPos() -> Int
    {
        return xPos
    }
    
    func getYPos() -> Int
    {
        return yPos
    }
    
    func getHeight() -> Int
    {
        return 500
    }
}
