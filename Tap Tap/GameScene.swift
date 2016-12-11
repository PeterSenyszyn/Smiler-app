//
//  GameScene.swift
//  Tap Tap
//
//  Created by Peter Senyszyn on 6/15/16.
//  Copyright © 2016 Peter Senyszyn. All rights reserved.
//

import SpriteKit
import GameplayKit

import GoogleMobileAds

class GameScene: SKScene
{
    private var intScore: Int = 0
    
    private var gameLostCalled: Bool = false
    
    var isActive: Bool = false
    
    var rainSpawner: NSTimer!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    let DIFFICULTY_MULTIPLER = 0.97
    
    var currentDifficultyTime: Double = 3.0
    
    var needsDifficultyIncrease = false
    
    let wrapper = KeychainWrapper(serviceName: "game")
    
    weak var viewController: PlayViewController?
    
    var background: SKSpriteNode?
    var bar: SKSpriteNode?
    var points: SKLabelNode?
    
    //Hold all of the raindrop sets
    var raindrops = Set<Raindrop>()

    override func didMoveToView(view: SKView)
    {
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(GameScene.hideInstructions), userInfo: nil, repeats: false)
        
        rainSpawner = NSTimer.scheduledTimerWithTimeInterval(currentDifficultyTime, target: self, selector: #selector(GameScene.createRaindrops), userInfo: nil, repeats: true)
        
        background = self.childNodeWithName("Background") as? SKSpriteNode
        background = SKSpriteNode(imageNamed: wrapper.stringForKey("background_filepath")!)
        
        bar = self.childNodeWithName("Bar") as? SKSpriteNode
        bar = SKSpriteNode(imageNamed: "Bar")
        bar?.position.x = view.bounds.size.width * 0.5
        bar?.position.y = view.bounds.size.height * 0.12
        bar?.size = CGSize(width: view.bounds.size.width, height: 20)
        bar?.zPosition = 1
        bar?.userInteractionEnabled = false
        bar?.name = "bar"
        
        points = self.childNodeWithName("Points") as? SKLabelNode
        
        self.addChild(background!)
        self.addChild(bar!)
        
        isActive = true
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        for raindrop in raindrops
        {
            raindrop.update()
            
            if (raindrop.touchedCorrectly)
            {
                intScore += 1
                
                points?.text = "\(intScore)"
                
                raindrops.remove(raindrop)
                
                if (prefs.boolForKey("soundOn")) { self.runAction(SKAction.playSoundFileNamed("raindrop.wav", waitForCompletion: false)) }
            }
            
            if (raindrop.touchedTooEarly || raindrop.offScreen) { gameLost() }
        }
        
        if (!needsDifficultyIncrease && intScore % 20 == 0 && intScore != 0)
        {
            needsDifficultyIncrease = true
            
            gettingHarder()
        }
    }
    
    func createRaindrops()
    {
        raindrops.insert(Raindrop(scene: self, barSprite: bar!))
    }

    func hideInstructions()
    {
        viewController?.Instructions.hidden = true
    }
    
    func gettingHarder()
    {
        viewController?.Instructions.text = "Difficulty increasing!"
        viewController?.Instructions.hidden = false
        
        currentDifficultyTime *= DIFFICULTY_MULTIPLER
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(GameScene.hideGettingHarder), userInfo: nil, repeats: false)
        
        rainSpawner = NSTimer.scheduledTimerWithTimeInterval(currentDifficultyTime, target: self, selector: #selector(GameScene.createRaindrops), userInfo: nil, repeats: true)
    }
    
    func hideGettingHarder()
    {
        viewController?.Instructions.hidden = true
    }
    
    func gameLost()
    {
        if (!gameLostCalled)
        {
            viewController?.Points.text = "You lost! Final score: \(intScore)"
        
            let wrapper = KeychainWrapper(serviceName: "game")
        
            let previousPoints = wrapper.integerForKey("points")!
            
            if (intScore > wrapper.integerForKey("topscore")!) { _ = wrapper.setInteger(intScore, forKey: "topscore") }
            
            _ = wrapper.setInteger(intScore + previousPoints, forKey: "points")
        
            rainSpawner = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(GameScene.goHome), userInfo: nil, repeats: false)
        
            gameLostCalled = true
        }
    }
    
    
    
    func goHome()
    {
        rainSpawner.invalidate()
        
        removeRaindrops()
        
        self.removeFromParent()
        self.view?.presentScene(nil)
        
        isActive = false
        
        self.viewController?.performSegueWithIdentifier("backToMainMenu", sender: self)
    }
    
    func removeRaindrops()
    {
        for raindrop in raindrops
        {
            raindrop.kill()
        }
        
        raindrops.removeAll()
    }
    
    func convert(point: CGPoint)->CGPoint
    {
        return self.view!.convertPoint(CGPoint(x: point.x, y:self.view!.frame.height-point.y), toScene:self)
    }
}
