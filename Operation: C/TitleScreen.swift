//
//  TitleScreen.swift
//  Operation: C
//
//  Created by Timur Guler on 6/15/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import Foundation
import UIKit

class TitleScreen: UIViewController
{
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    
    @IBAction func playPressed()
    {
        
        //performSegue(withIdentifier: "ShowGameView", sender: self)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameView") as! GameViewController
        self.addChildViewController(newViewController)
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func ratePressed()
    {
        
    }
    
    func removeChildView()
    {
        self.removeChildView()
    }
}
