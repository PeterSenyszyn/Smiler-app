//
//  PlayViewController.swift
//  RainTap
//
//  Created by Peter Senyszyn on 6/28/16.
//  Copyright © 2016 Peter Senyszyn. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

import GoogleMobileAds

class PlayViewController: UIViewController, GADBannerViewDelegate
{    
    //Banner advertisement for pause menu
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var Points: UILabel!
    @IBOutlet weak var Instructions: UILabel!
    
    let wrapper = KeychainWrapper(serviceName: "game")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let scene = GameScene(fileNamed: "GameScene")
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene?.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
        if (!wrapper.boolForKey("removeads")!)
        {
            bannerView.adUnitID = "ca-app-pub-5329314127516962/5878037135"
            bannerView.rootViewController = self
            bannerView.loadRequest(GADRequest())
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
}