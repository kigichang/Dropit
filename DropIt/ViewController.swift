//
//  ViewController.swift
//  DropIt
//
//  Created by kigi on 8/14/14.
//  Copyright (c) 2014 classroomM. All rights reserved.
//

import UIKit

let GLOBAL_DROP_SIZE = CGSize(width: 40, height: 40)

class ViewController: UIViewController {
    
// MARK: Properties
    class var DROP_SIZE : CGSize {
        return GLOBAL_DROP_SIZE
    }
    
    @IBOutlet var gameView: UIView!
    
    lazy var animator: UIDynamicAnimator = { () -> UIDynamicAnimator in
        return UIDynamicAnimator(referenceView: self.gameView!)
    }()

    lazy var gravity: UIGravityBehavior = { () -> UIGravityBehavior in
        var g = UIGravityBehavior()
        g.magnitude = 0.9
        self.animator.addBehavior(g)
        return g
    }()


    lazy var collider: UICollisionBehavior = { () -> UICollisionBehavior in
        var c = UICollisionBehavior()
        c.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(c)
        return c
    }()
    
// MARK: Gesture Action
    
    @IBAction func tap(sender: UITapGestureRecognizer) {
        self.drop()
    }
    
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: ViewController.DROP_SIZE)
        let x = Int(arc4random()) % Int(self.gameView.bounds.size.width) / Int(ViewController.DROP_SIZE.width)
        frame.origin.x = CGFloat(x) * ViewController.DROP_SIZE.width
        
        var dropView = UIView(frame: frame)
        dropView.backgroundColor = self.randomColor()
        
        self.gameView.addSubview(dropView)
        self.gravity.addItem(dropView)
        self.collider.addItem(dropView)
    }
    
    
    func randomColor() -> UIColor {
        switch arc4random() % 5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }

// MARK: Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

