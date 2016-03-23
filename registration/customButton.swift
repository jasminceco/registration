//
//  customButton.swift
//  registration
//
//  Created by Jasmin Ceco on 23/03/16.
//  Copyright © 2016 Jasmin Ceco. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class customButton: UIButton {
    @IBInspectable var corner: CGFloat = 0.0 {
        didSet{
            setUpView()
        }
    }
    
    @IBInspectable var fontColor: UIColor = UIColor.whiteColor(){
        didSet{
            self.tintColor = fontColor
        }
    }
    override func awakeFromNib() {
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    func setUpView() {
        self.layer.cornerRadius = corner
        self.addTarget(self, action: "scaleToSmall", forControlEvents: .TouchDown)
        self.addTarget(self, action: "scaleToSmall", forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: "scaleAnimation", forControlEvents: .TouchUpInside)
        self.addTarget(self, action: "scaleDefault", forControlEvents: .TouchDragExit)
    }
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
        
    }
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        scaleAnim.springBounciness = 18
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleDefaultAnimation")
        
    }
}
