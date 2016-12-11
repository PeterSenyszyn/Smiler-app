//
//  StoreViewController.swift
//  RainTap
//
//  Created by Peter Senyszyn on 6/30/16.
//  Copyright © 2016 Peter Senyszyn. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SwiftyStoreKit

import GoogleMobileAds

class StoreViewController: UIViewController, GADBannerViewDelegate
{
    //Banner advertisement for pause menu
    var skView: SKView!
    
    @IBOutlet var bannerView: GADBannerView!
    
    @IBOutlet weak var Background: UIImageView!
    
    @IBOutlet weak var Points: UILabel!
    
    @IBOutlet weak var Background1: UIButton!
    @IBOutlet weak var Background2: UIButton!
    @IBOutlet weak var Background3: UIButton!
    @IBOutlet weak var Background4: UIButton!
    
    @IBOutlet weak var RemoveAds: UIButton!
    @IBOutlet weak var Restore: UIButton!
    
    @IBOutlet weak var Info: UILabel!
    
    @IBOutlet weak var BackWithAd: UIButton!
    @IBOutlet weak var BackNoAd: UIButton!
    
    let BG2_COST = 300
    let BG3_COST = 600
    let BG4_COST = 1000
    
    let wrapper: KeychainWrapper = KeychainWrapper(serviceName: "game")
    
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
        
        refreshBackgroundInfo()
        
        Points.text = "Points: \(wrapper.integerForKey("points")!)"
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    func refreshBackgroundInfo()
    {
        Background.image = UIImage(named: wrapper.stringForKey("background_filepath")!)
        
        //******************************************************************************************************************
        
        if (wrapper.stringForKey("background_filepath")! == "Background1") { Background1.setTitle("Background 1 (*)", forState: .Normal)  }
            
        else if (wrapper.stringForKey("background_filepath")! == "Background2") { Background2.setTitle("Background 2 (*)", forState: .Normal) }
            
        else if (wrapper.stringForKey("background_filepath")! == "Background3") { Background3.setTitle("Background 3 (*)", forState: .Normal) }
            
        else if (wrapper.stringForKey("background_filepath")! == "Background4") { Background4.setTitle("Background 4 (*)", forState: .Normal) }
        
        //******************************************************************************************************************
        
        if (wrapper.boolForKey("ownsBG1")! && wrapper.stringForKey("background_filepath")! != "Background1") { Background1.setTitle("Background 1", forState: .Normal) }
        
        if (wrapper.boolForKey("ownsBG2")! && wrapper.stringForKey("background_filepath")! != "Background2") { Background2.setTitle("Background 2", forState: .Normal) }
        
        if (wrapper.boolForKey("ownsBG3")! && wrapper.stringForKey("background_filepath")! != "Background3") { Background3.setTitle("Background 3", forState: .Normal) }
        
        if (wrapper.boolForKey("ownsBG4")! && wrapper.stringForKey("background_filepath")! != "Background4") { Background4.setTitle("Background 4", forState: .Normal) }
    }
    
    func resetInfo()
    {
        Info.text = ""
        Info.hidden = true
    }
    
    @IBAction func tappedBG1(sender: AnyObject)
    {
        _ = wrapper.setString("Background1", forKey: "background_filepath")
        
        refreshBackgroundInfo()
    }
    
    @IBAction func tappedBG2(sender: AnyObject)
    {
        if (wrapper.boolForKey("ownsBG2")!)
        {
            _ = wrapper.setString("Background2", forKey: "background_filepath")
            refreshBackgroundInfo()
        }
        
        else
        {
            if (wrapper.integerForKey("points")! < BG2_COST)
            {
                Info.text = "You cannot afford this item!"
                Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(resetInfo), userInfo: nil, repeats: false)
            }
            
            else
            {
                _ = wrapper.setString("Background2", forKey: "background_filepath")
                _ = wrapper.setBool(true, forKey: "ownsBG2")
                
                refreshBackgroundInfo()
                
                let numPoints = wrapper.integerForKey("points")! - BG2_COST
                
                _ = wrapper.setInteger(numPoints, forKey: "points")
                
                Info.text = "Successfully purchased!"
                Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(resetInfo), userInfo: nil, repeats: false)
            }
        }
    }
    
    @IBAction func tappedBG3(sender: AnyObject)
    {
        if (wrapper.boolForKey("ownsBG3")!)
        {
            _ = wrapper.setString("Background3", forKey: "background_filepath")
            refreshBackgroundInfo()
        }
            
        else
        {
            if (wrapper.integerForKey("points")! < BG3_COST)
            {
                Info.text = "You cannot afford this item!"
                Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(resetInfo), userInfo: nil, repeats: false)
            }
                
            else
            {
                _ = wrapper.setString("Background3", forKey: "background_filepath")
                _ = wrapper.setBool(true, forKey: "ownsBG3")
                
                refreshBackgroundInfo()
                
                let numPoints = wrapper.integerForKey("points")! - BG3_COST
                
                _ = wrapper.setInteger(numPoints, forKey: "points")
                
                Info.text = "Successfully purchased!"
                Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(resetInfo), userInfo: nil, repeats: false)
            }
        }
    }
    
    @IBAction func tappedBG4(sender: AnyObject)
    {
        if (wrapper.boolForKey("ownsBG4")!)
        {
            _ = wrapper.setString("Background4", forKey: "background_filepath")
            refreshBackgroundInfo()
        }
            
        else
        {
            if (wrapper.integerForKey("points")! < BG4_COST)
            {
                Info.text = "You cannot afford this item!"
                Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(resetInfo), userInfo: nil, repeats: false)
            }
                
            else
            {
                _ = wrapper.setString("Background4", forKey: "background_filepath")
                _ = wrapper.setBool(true, forKey: "ownsBG4")
                
                refreshBackgroundInfo()
                
                let numPoints = wrapper.integerForKey("points")! - BG4_COST
                
                _ = wrapper.setInteger(numPoints, forKey: "points")
                
                Info.text = "Successfully purchased!"
                Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(resetInfo), userInfo: nil, repeats: false)
            }
        }
    }
    
    @IBAction func tappedRemoveAds(sender: AnyObject)
    {
        SwiftyStoreKit.purchaseProduct("RemoveAds") { result in
            switch result
            {
            case .Success(let productId):
                print("Purchase success: \(productId)")
                _ = self.wrapper.setBool(true, forKey: "removeads")
                
                self.Info.text = "Success! Restart app to remove ads."
                self.Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.resetInfo), userInfo: nil, repeats: false)
                
            case .Error(let error):
                print("Purchase failed: \(error)")
            }
        }
    }
    
    @IBAction func tappedRestore(sender: AnyObject)
    {
        SwiftyStoreKit.restorePurchases() { results in
            if results.restoreFailedProducts.count > 0
            {
                self.Info.text = "Restore failed."
                self.Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.resetInfo), userInfo: nil, repeats: false)
            }
            else if results.restoredProductIds.count > 0
            {
                self.Info.text = "Restore success! Restart apps to remove ads."
                self.Info.hidden = false
                
                _ = self.wrapper.setBool(true, forKey: "removeads")
                
                _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.resetInfo), userInfo: nil, repeats: false)
            }
            else
            {
                self.Info.text = "Nothing to restore!"
                self.Info.hidden = false
                
                _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.resetInfo), userInfo: nil, repeats: false)
            }
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