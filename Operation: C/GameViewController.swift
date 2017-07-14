//
//  GameViewController.swift
//  Operation: C
//
//  Created by Timur Guler on 5/26/17.
//  Copyright © 2017 Timur Guler. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{
    
    // Connect all of the buttons from Main.storyboard to the GameViewController
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var ocLogo: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    public var publicScene: LevelScene = LevelScene() // Make the SKScene used public
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        playButton.isHidden = false
        //rateButton.isHidden = false
        
    }
    
    override var shouldAutorotate: Bool
    {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func startGame()
    {
        
        finalScoreLabel.isHidden = true // Hide the high score label
        playButton.isHidden = true
        if let view = self.view as! SKView?
        {
            // Load the SKScene from 'GameScene.sks'
            if let scene = LevelScene(fileNamed: identifyDevice()) // Call identifyDevice() to check if iPad or iPhone
            {
                
                publicScene = scene // Set the internally declared scene to the public scene declared
                
                publicScene.scaleMode = .aspectFill // Set the scale mode to scale to fit the window
                
                publicScene.isPaused = false // Start the game by unpausing it
                
                
                view.showsPhysics = false // Make everything stay where it is
                
                view.presentScene(publicScene) // Present the scene
            }
            
            
        }

    }
    
    func identifyDevice() -> String
    {
        let tabletException = ["iPad Air","iPad Air 2","iPad Mini 4", "iPad Pro","Simulator"]
        let modelName = UIDevice.current.modelName // Set modelName to the name of the device
        if tabletException.contains(modelName) // Proceed if iPad
        {
            return "iPadLevelScene"
        }
        return "LevelScene" // Else load the iPhone scene
    }
    
    @IBAction func showOptionMenu(_ sender: UIButton)
    {
        resumeButton.isHidden = false
        quitButton.isHidden = false
        
        publicScene.isPaused = true
        
    }
    
    @IBAction func hideOptionMenu(_ sender: UIButton)
    {
        resumeButton.isHidden = true
        quitButton.isHidden = true
        
        publicScene.isPaused = false
    }
    
    @IBAction func quitGame(_ sender: UIButton)
    {
        print("QUITTING")
        publicScene.removeAllActions()
        publicScene.removeAllChildren()
        
        playButton.isHidden = false
        //rateButton.isHidden = false
        pauseButton.isHidden = true
        resumeButton.isHidden = true
        quitButton.isHidden = true
        ocLogo.isHidden = false
        retryButton.isHidden = true
    }
    
    func showLoseMenu()
    {
        finalScoreLabel.text = String(publicScene.getScore())
        finalScoreLabel.isHidden = true//false
        retryButton.isHidden = false
        quitButton.isHidden = false
        resumeButton.isHidden = true
    }
    
    func hideLoseMenu()
    {
        finalScoreLabel.isHidden = true
        retryButton.isHidden = true
        quitButton.isHidden = true
        resumeButton.isHidden = true
    }
    
    @IBAction func start(_ sender: UIButton)
    {
        publicScene.isPaused = false
        playButton.isHidden = true
        rateButton.isHidden = true
        pauseButton.isHidden = false
        retryButton.isHidden = true
        quitButton.isHidden = true
        ocLogo.isHidden = true
        resumeButton.isHidden = true
        startGame()
    }
    
    @IBAction func restart(_ sender: UIButton)
    {
        publicScene.isPaused = false
        playButton.isHidden = true
        rateButton.isHidden = true
        pauseButton.isHidden = false
        retryButton.isHidden = true
        quitButton.isHidden = true
        ocLogo.isHidden = true
        resumeButton.isHidden = true
        startGame()
    }
    

    
}
