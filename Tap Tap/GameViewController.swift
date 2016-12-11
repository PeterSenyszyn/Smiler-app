//
//  GameViewController.swift
//  Tap Tap
//
//  Created by Peter Senyszyn on 6/14/16.
//  Copyright © 2016 Peter Senyszyn. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SwiftyStoreKit

import GoogleMobileAds

class GameViewController: UIViewController, GADBannerViewDelegate
{
    //Banner advertisement for pause menu
    var skView: SKView!
    
    @IBOutlet var bannerView: GADBannerView!
    
    @IBOutlet weak var SettingsWithAd: UIButton!
    @IBOutlet weak var SettingsWithoutAd: UIButton!
    
    @IBOutlet weak var StoreWithAd: UIButton!
    @IBOutlet weak var StoreWithoutAd: UIButton!
    
    @IBOutlet weak var TopScore: UILabel!
    
    @IBOutlet weak var Background: UIImageView!
    
    let wrapper = KeychainWrapper(serviceName: "game")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadKeychainData()
        
        if (!wrapper.boolForKey("removeads")!)
        {
            bannerView.adUnitID = "ca-app-pub-5329314127516962/5878037135"
            bannerView.rootViewController = self
            bannerView.loadRequest(GADRequest())
            
            SettingsWithoutAd.hidden = true
            StoreWithoutAd.hidden = true
        }
            
        else
        {
            SettingsWithAd.hidden = true
            StoreWithAd.hidden = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        TopScore.text = "Top Score: \(wrapper.integerForKey("topscore")!)"
        
        print("suhhhh")
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        Background.image = UIImage(named: wrapper.stringForKey("background_filepath")!)
        
        SwiftyStoreKit.completeTransactions() { completedTransactions in
            for completedTransaction in completedTransactions
            {
                if (completedTransaction.transactionState == .Purchased || completedTransaction.transactionState == .Restored)
                {
                    print("Purchased: \(completedTransaction.productId)")
                }
            }
        }
    }
    
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue)
    {

    }
    
    @IBAction func playTapped(sender: AnyObject)
    {
        self.performSegueWithIdentifier("play", sender: self)
    }
    
    
    @IBAction func settingsTouched(sender: AnyObject)
    {
        self.performSegueWithIdentifier("settingsSegue", sender: self)
    }
    
    
    @IBAction func storeTouched(sender: AnyObject)
    {
        self.performSegueWithIdentifier("toStore", sender: self)
    }
    
    func loadKeychainData()
    {
        //***********************************************************************
        
        _ = wrapper.setBool(true, forKey: "ownsBG1")
        
        if (wrapper.boolForKey("ownsBG2") == nil)
        {
            _ = wrapper.setBool(false, forKey: "ownsBG2")
        }
        
        if (wrapper.boolForKey("ownsBG3") == nil)
        {
            _ = wrapper.setBool(false, forKey: "ownsBG3")
        }
        
        if (wrapper.boolForKey("ownsBG4") == nil)
        {
            _ = wrapper.setBool(false, forKey: "ownsBG4")
        }
        
        //***********************************************************************
        
        if (wrapper.stringForKey("background_filepath") == nil)
        {
            _ = wrapper.setString("Background1", forKey: "background_filepath")
        }
        
        //***********************************************************************
        if (wrapper.integerForKey("points") == nil)
        {
            _ = wrapper.setInteger(0, forKey: "points")
        }
        
        //***********************************************************************
        if (wrapper.integerForKey("topscore") == nil)
        {
            _ = wrapper.setInteger(0, forKey: "topscore")
        }
        
        //***********************************************************************
        if (wrapper.boolForKey("removeads") == nil)
        {
            _ = wrapper.setBool(false, forKey: "removeads")
        }
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
