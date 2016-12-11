//
//  InfoViewController.swift
//  RainTap
//
//  Created by Peter Senyszyn on 6/28/16.
//  Copyright © 2016 Peter Senyszyn. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SwiftyStoreKit

import GoogleMobileAds

class InfoViewController: UIViewController, GADBannerViewDelegate
{
    //Banner advertisement for pause menu
    var skView: SKView!
    
    @IBOutlet var bannerView: GADBannerView!
    
    @IBOutlet weak var Twitter: UIButton!
    @IBOutlet weak var Instagram: UIButton!
    
    @IBOutlet weak var BackWithAd: UIButton!
    @IBOutlet weak var BackNoAd: UIButton!
    
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
        }
            
        else
        {
            BackWithAd.hidden = true
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        Background.image = UIImage(named: wrapper.stringForKey("background_filepath")!)
    }
    
    @IBAction func tappedTwitter(sender: AnyObject)
    {
        let myName = "petersenyszyn"
        
        let appURL = NSURL(string: "twitter://user?screen_name=\(myName)")!
        let webURL = NSURL(string: "https://twitter.com/\(myName)")!
        
        let application = UIApplication.sharedApplication()
        
        if (application.canOpenURL(appURL)) { application.openURL(appURL) }
            
        else { application.canOpenURL(webURL) }
    }
    
    @IBAction func tappedInstagram(sender: AnyObject)
    {
        let appURL = NSURL(string: "instagram://user?username=petersenyszyn")!
        
        if (UIApplication.sharedApplication().canOpenURL(appURL)) { UIApplication.sharedApplication().openURL(appURL) }
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
