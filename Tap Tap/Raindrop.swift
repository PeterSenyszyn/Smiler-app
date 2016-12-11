//
//  Raindrop.swift
//  Tap Tap
//
//  Created by Peter Senyszyn on 6/16/16.
//  Copyright © 2016 Peter Senyszyn. All rights reserved.
//

import Foundation
import SpriteKit

class Raindrop : SKSpriteNode
{
    var offScreen: Bool = false
    
    var touchedTooEarly: Bool = false
    var touchedCorrectly: Bool = false
    
    let recognizer = UITapGestureRecognizer()
    
    weak var barSpriteRef: SKSpriteNode?
    
    init(scene: SKScene, barSprite: SKSpriteNode)
    {
        let texture = SKTexture(imageNamed: "RainDrop")
        
        super.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        barSpriteRef = barSprite
        
        self.userInteractionEnabled = true
        
        let width = scene.view!.frame.width
        
        let randomPos = CGPointMake(CGFloat(arc4random()) % width, UIScreen.mainScreen().bounds.height + 50)
        
        self.position = randomPos
        self.zPosition = 1
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        scene.addChild(self)
        
        let moveDown = SKAction.moveToY(-UIScreen.mainScreen().bounds.height, duration: 8)
        self.runAction(moveDown)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent: UIEvent?)
    {
        let pos = self.position
        
        if ((pos.y) + (self.frame.height / 2) + 16 > barSpriteRef!.position.y + barSpriteRef!.frame.height / 2)
        {
            touchedTooEarly = true
        }
        
        else
        {
            touchedCorrectly = true
        }
    }
    
    func update()
    {
        if ((self.position.y) + (self.frame.height / 2) + 16 < -self.frame.height)
        {
            kill()
            
            if (!touchedCorrectly && !touchedTooEarly) { offScreen = true; }
        }
    }
    
    func kill()
    {
        self.removeAllActions()
        self.removeFromParent()
    }
}