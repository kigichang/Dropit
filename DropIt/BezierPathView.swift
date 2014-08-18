//
//  BezierPathView.swift
//  DropIt
//
//  Created by kigi on 8/18/14.
//  Copyright (c) 2014 classroomM. All rights reserved.
//

import UIKit

class BezierPathView: UIView {
    
    var path: UIBezierPath? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        if let p = path {
            p.stroke()
        }
    }
}
