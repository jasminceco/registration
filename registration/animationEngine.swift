//
//  animationEngine.swift
//  registration
//
//  Created by Jasmin Ceco on 23/03/16.
//  Copyright © 2016 Jasmin Ceco. All rights reserved.
//

import UIKit
import pop

class AnimatinEngine {
    
    class var offScreenRigthPosition : CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition : CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    class var offScreenCenterPosition : CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    var originalConstants = [CGFloat]()
    var constraints : [NSLayoutConstraint]!
    var delay: Int = 1
    
    init(constraints: [NSLayoutConstraint]){
        for con in constraints{
            self.originalConstants.append(con.constant)
            con.constant = AnimatinEngine.offScreenLeftPosition.x
        }
        self.constraints = constraints
    }
   
    
    func animateOfSreen(delay: Int)
    {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_MSEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            var index = 0
            
            repeat{
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                index = index + 1
                
            }while(index < self.constraints.count)
        }
        
    }
        
}
