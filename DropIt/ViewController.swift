//
//  ViewController.swift
//  DropIt
//
//  Created by kigi on 8/14/14.
//  Copyright (c) 2014 classroomM. All rights reserved.
//

import UIKit

let GLOBAL_DROP_SIZE = CGSize(width: 40, height: 40)

class ViewController: UIViewController, UIDynamicAnimatorDelegate {
    
// MARK: Properties
    class var DROP_SIZE : CGSize {
        return GLOBAL_DROP_SIZE
    }
    
    @IBOutlet var gameView: UIView!
    
    lazy var animator: UIDynamicAnimator = { () -> UIDynamicAnimator in
        var a = UIDynamicAnimator(referenceView: self.gameView!)
        a.delegate = self
        return a
    }()

    lazy var dropitBehavior: DropitBehavior = { () -> DropitBehavior in
        var d = DropitBehavior()
        self.animator.addBehavior(d)
        return d
    }()
    
// MARK: UIDynamicAnimatorDelegate

    /* 會需要等到整個動畫停止了，才會被 trigger */
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        self.removeCompletedRows()
    }

    func removeCompletedRows() -> Bool {
        
        var dropsToRemove = [UIView]()
        
        for (var y = self.gameView.bounds.size.height - ViewController.DROP_SIZE.height / CGFloat(2); y > 0; y -= ViewController.DROP_SIZE.height) {
            var rowIsComplete = true
            var dropsFound = [UIView]()

            for (var x  = ViewController.DROP_SIZE.width / CGFloat(2); x <= self.gameView.bounds.size.width - ViewController.DROP_SIZE.width / CGFloat(2); x += ViewController.DROP_SIZE.width) {
                if let hit = self.gameView.hitTest(CGPointMake(x, y), withEvent: nil) {
                    if hit.superview == self.gameView {
                        dropsFound.append(hit)
                    }
                    else {
                        rowIsComplete = false
                        break;
                    }
                }
            }
            
            if dropsFound.count == 0 {
                break
            }

            if rowIsComplete {
                dropsToRemove += dropsFound
            }
        }
        
        if dropsToRemove.count > 0 {
            for drop in dropsToRemove {
                self.dropitBehavior.removeItem(drop)
            }
            self.animateRevovingDrops(dropsToRemove)
        }

        return false
    }

    func animateRevovingDrops(dropsToRemove: [UIView]) {
        UIView.animateWithDuration(1.0,
            animations: {() in
                for drop in dropsToRemove {
                    let x = (Int(arc4random()) % (Int(self.gameView.bounds.size.width) * 5)) - Int(self.gameView.bounds.size.width) * 2
                    
                    let y = self.gameView.bounds.size.height;
                    drop.center = CGPointMake(CGFloat(x), -y);
                }
            },
            completion: { (finished: Bool) in
                for drop in dropsToRemove {
                    drop.removeFromSuperview()
                }
            })
    }

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
        self.dropitBehavior.addItem(dropView)
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

