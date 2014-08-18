//
//  DropitBehavior.swift
//  DropIt
//
//  Created by kigi on 8/14/14.
//  Copyright (c) 2014 classroomM. All rights reserved.
//

import UIKit

class DropitBehavior: UIDynamicBehavior {

// MARK: Properties

    lazy var gravity: UIGravityBehavior = { () -> UIGravityBehavior in
        var g = UIGravityBehavior()
        g.magnitude = 1.0
        return g
    }()


    lazy var collider: UICollisionBehavior = { () -> UICollisionBehavior in
        var c = UICollisionBehavior()
        c.translatesReferenceBoundsIntoBoundary = true
        return c
    }()
    
    lazy var animationOptions: UIDynamicItemBehavior = { () -> UIDynamicItemBehavior in
        var a = UIDynamicItemBehavior()
        a.allowsRotation = false
        return a
    }()

    override init() {
        super.init()
        self.addChildBehavior(self.gravity)
        self.addChildBehavior(self.collider)
        self.addChildBehavior(self.animationOptions)
    }

    // TODO:
    func addItem(item: UIDynamicItem) {
        self.gravity.addItem(item)
        self.collider.addItem(item)
        self.animationOptions.addItem(item)
    }
    
    // TODO:
    func removeItem(item: UIDynamicItem) {
        self.gravity.removeItem(item)
        self.collider.removeItem(item)
        self.animationOptions.removeItem(item)
    }
}
