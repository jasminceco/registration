//
//  customTextFields.swift
//  registration
//
//  Created by Jasmin Ceco on 23/03/16.
//  Copyright © 2016 Jasmin Ceco. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextFields: UITextField{
    
    @IBInspectable var inset: CGFloat = 0
    
    @IBInspectable var corner: CGFloat = 0 {
        didSet {
            setUpView()
        }
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = corner
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView()
    {
        self.layer.cornerRadius = corner
    }
}
