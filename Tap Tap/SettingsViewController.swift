//
//  SettingsViewController.swift
//  RainTap
//
//  Created by Peter Senyszyn on 6/27/16.
//  Copyright © 2016 Peter Senyszyn. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SwiftyStoreKit

import GoogleMobileAds

class SettingsViewController: UIViewController, GADBannerViewDelegate
{
    //Banner advertisement for pause menu
    var skView: SKView!
    
    @IBOutlet var bannerView: GADBannerView!
    
    @IBOutlet weak var SoundButton: UIButton!
    
    @IBOutlet weak var BackWithAd: UIButton!
    @IBOutlet weak var BackNoAd: UIButton!
    
    @IBOutlet weak var InfoWithAd: UIButton!
    @IBOutlet weak var InfoNoAd: UIButton!
    
    @IBOutlet weak var Background: UIImageView!
    
    let wrapper = KeychainWrapper(serviceName: "game")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if (!wrapper.boolForKey("removeads")!)
        {
            bannerView.adUnitID = "ca-app-pub-5329314127516962/5878037135"
            bannerView.rootViewController = self
            bannerView.loadRequest(GADRequest())
            
            BackNoAd.hidden = true
            InfoNoAd.hidden = true
        }
            
        else
        {
            BackWithAd.hidden = true
            InfoWithAd.hidden = true
        }
        
        Background.image = UIImage(named: wrapper.stringForKey("background_filepath")!)
        
        InfoWithAd.setTitle("\u{1F6C8}", forState: .Normal)
        InfoNoAd.setTitle("\u{1F6C8}", forState: .Normal)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    @IBAction func soundButtonPressed(sender: AnyObject)
    {
        let prefs = NSUserDefaults.standardUserDefaults()
        
        if (prefs.boolForKey("soundOn"))
        {
            SoundButton.setImage(UIImage(named: "SoundOff"), forState: UIControlState.Normal)
            
            prefs.setBool(false, forKey: "soundOn")
        }
            
        else if (!prefs.boolForKey("soundOn"))
        {
            SoundButton.setImage(UIImage(named: "SoundOn"), forState: UIControlState.Normal)
            
            prefs.setBool(true, forKey: "soundOn")
        }
    }
    
    @IBAction func infoPressed(sender: AnyObject)
    {
        self.performSegueWithIdentifier("toInfo", sender: self)
    }
    
    @IBAction func unwindToSettings(segue: UIStoryboardSegue)
    {
        
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
