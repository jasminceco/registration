//
//  ViewController.swift
//  registration
//
//  Created by Jasmin Ceco on 23/03/16.
//  Copyright © 2016 Jasmin Ceco. All rights reserved.
//

import UIKit
import pop


class ViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateTopConst: NSLayoutConstraint!
    @IBOutlet weak var genderTopConst: NSLayoutConstraint!
    
    @IBOutlet weak var textfieldCenter: NSLayoutConstraint!
    
    @IBOutlet weak var genderCentarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dateCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var genderTextFileld: CustomTextFields!
    
    @IBOutlet weak var datepickerTextField: CustomTextFields!
    @IBOutlet weak var textFieldOutlet: CustomTextFields!
    var animEngine : AnimatinEngine!
    var registation = Registration()
    
    var genderOption = ["Male", "Female", "I would rather Not Say"]
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registation = Registration()
        descriptionLabel.hidden = true
        textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"first name", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
        // SETING PICKER FOR GENDER TEXT FIELD //
        pickerView.backgroundColor = UIColor.whiteColor()
        pickerView.alpha = 0.95
        pickerView.delegate = self
        genderTextFileld.inputView = pickerView
        
        genderTextFileld.hidden = true
        datepickerTextField.hidden = true
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.alpha = 0.95
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Done, target: self, action: "nextBtnPressed:")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done , target: self, action: "backPressed:")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        toolBar.backgroundColor = UIColor.darkGrayColor()
        textFieldOutlet.inputAccessoryView = toolBar
        genderTextFileld.inputAccessoryView = toolBar
        datepickerTextField.inputAccessoryView = toolBar
        
        
    }
    
    @IBAction func DateOfBirthPicker(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.backgroundColor = UIColor.whiteColor()
        datePickerView.alpha = 0.95
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"),forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        datepickerTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    // GENDER FIELD PICKER //
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return genderOption.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return genderOption[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        genderTextFileld.text = genderOption[row]
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text =  genderOption[row]
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    func animate() {
        self.animEngine = AnimatinEngine(constraints: [textfieldCenter, genderCentarConstraint, dateCenterConstraint])
        
        self.animEngine.animateOfSreen(5)
        
    }
    func refresh(){
        print("firstname is: \(registration.Registration.personalDetails.firsName)")
        print("last name is: \(registration.Registration.personalDetails.lastName)")
        print("date of birth is:\(registration.Registration.personalDetails.dateOfBirth)")
        print("gender is: \(registration.Registration.personalDetails.gender)")
        print("address is: \(registration.Registration.ContactDetails.address)")
        print("textfield tag is\(textFieldOutlet.tag)")
    }
    
    
    
    @IBAction func nextBtnPressed(sender: customButton) {
        
        refresh()
        animate()
        switch textFieldOutlet.tag {
        case 0:
            if textFieldOutlet.text == ""
            {
                descriptionLabel.hidden = false
                descriptionLabel.text = "First Name is mandatory!"
            }
            else
            {
                descriptionLabel.hidden = true
                
                textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter last name", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
                registration.Registration.personalDetails.firsName = textFieldOutlet.text!
                textFieldOutlet.text = ""
                textFieldOutlet.tag = 1
            }
        case 1:
            if textFieldOutlet.text == ""
            {
                descriptionLabel.hidden = false
                descriptionLabel.text = "Last Name is mandatory!"
            }
            else
            {
                descriptionLabel.hidden = true
                datepickerTextField.attributedPlaceholder = NSAttributedString(string:"enter date of birth", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
                registration.Registration.personalDetails.lastName = textFieldOutlet.text!
                dateTopConst.constant = 280
                textFieldOutlet.text = ""
                textFieldOutlet.tag = 2
                textFieldOutlet.hidden = true
                genderTextFileld.hidden = true
                datepickerTextField.hidden = false
                textFieldOutlet.resignFirstResponder()
                datepickerTextField.becomeFirstResponder()
            }
            
        case 2:
            genderTextFileld.attributedPlaceholder = NSAttributedString(string:"enter gender", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            registration.Registration.personalDetails.dateOfBirth = datepickerTextField.text!
            textFieldOutlet.text = ""
            textFieldOutlet.tag = 3
            datepickerTextField.hidden = true
            datepickerTextField.resignFirstResponder()
            genderTextFileld.becomeFirstResponder()
            genderTopConst.constant = 280
            genderTextFileld.hidden = false
        case 3:
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter home address", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            registration.Registration.personalDetails.gender = genderTextFileld.text!
            textFieldOutlet.text = ""
            textFieldOutlet.tag = 4
            textFieldOutlet.hidden = false
            genderTextFileld.hidden = true
            textFieldOutlet.becomeFirstResponder()
            genderTextFileld.resignFirstResponder()
            titleLabel.text = "ContactDetails"
            
        case 4:
            if textFieldOutlet.text == ""
            {
                descriptionLabel.hidden = false
                descriptionLabel.text = "Home address is mandatory!"
            }
            else
            {
                descriptionLabel.hidden = true
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter zip code", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            registration.Registration.ContactDetails.address = textFieldOutlet.text!
            textFieldOutlet.text = ""
            textFieldOutlet.tag = 5
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.DecimalPad
            textFieldOutlet.becomeFirstResponder()
            }
            
        case 5:
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter email", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            registration.Registration.ContactDetails.zipCode = textFieldOutlet.text!
            textFieldOutlet.text = ""
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
            textFieldOutlet.tag = 6
            
            
        case 6:
            if textFieldOutlet.text == ""
            {
                descriptionLabel.hidden = false
                descriptionLabel.text = "Email is mandatory!"
            }
            else
            {
                descriptionLabel.hidden = true
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter phone Number", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            registration.Registration.ContactDetails.email = textFieldOutlet.text!
            textFieldOutlet.text = ""
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.DecimalPad
            textFieldOutlet.becomeFirstResponder()
            
            textFieldOutlet.tag = 7
            }
        case 7:
            if textFieldOutlet.text == ""
            {
                descriptionLabel.hidden = false
                descriptionLabel.text = "Phone number is mandatory!"
            }
            else
            {
                descriptionLabel.hidden = true
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter username", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            registration.Registration.ContactDetails.phoneNumber = textFieldOutlet.text!
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
            textFieldOutlet.text = ""
            titleLabel.text = "Security Details"
            textFieldOutlet.tag = 8
            }
        case 8:
            
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter password", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            registration.Registration.securityDetails.username = textFieldOutlet.text!
            
            textFieldOutlet.text = ""
            textFieldOutlet.tag = 9
            
            
        case 9:
            if textFieldOutlet.text == ""
            {
                descriptionLabel.hidden = false
                descriptionLabel.text = "Password is mandatory!"
            }
            else
            {
                descriptionLabel.hidden = true
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"confirm password", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            registration.Registration.securityDetails.password = textFieldOutlet.text!
            
            textFieldOutlet.text = ""
            textFieldOutlet.tag = 10
            }
            
        case 10:
            if textFieldOutlet.text != registration.Registration.securityDetails.password
            {
                descriptionLabel.hidden = false
                descriptionLabel.text = "password do not macth!"
              
            }else{
                descriptionLabel.hidden = true
                registration.Registration.securityDetails.confirmPassword = textFieldOutlet.text!
                
                /// sada sve treba poslati na server
            }
        default:
            break
            
        }
        
    }
    
    
    @IBAction func backPressed(sender: customButton) {
        
        
        if textFieldOutlet.tag >= 0 {
            textFieldOutlet.tag = textFieldOutlet.tag - 1
        }
        
        animate()
        
        switch textFieldOutlet.tag {
        case 0:
            textFieldOutlet.text = registration.Registration.personalDetails.firsName
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter First Name"
            titleLabel.text = "Personal details"
            
        case 1:
            textFieldOutlet.text = registration.Registration.personalDetails.lastName
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Personal details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Last Name"
            textFieldOutlet.hidden = false
            datepickerTextField.hidden = true
            genderTextFileld.hidden = true
            textFieldOutlet.becomeFirstResponder()
        case 2:
            datepickerTextField.text = registration.Registration.personalDetails.dateOfBirth
            datepickerTextField.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Personal details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Date of Birth"
            textFieldOutlet.hidden = true
            datepickerTextField.hidden = false
            datepickerTextField.becomeFirstResponder()
        case 3:
            textFieldOutlet.text = registration.Registration.personalDetails.gender
            genderTextFileld.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Personal details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Gender"
            textFieldOutlet.hidden = false
            datepickerTextField.hidden = true
            genderTextFileld.becomeFirstResponder()
        case 4:
            textFieldOutlet.text = registration.Registration.ContactDetails.address
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Contact details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Home Address"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
        case 5:
            textFieldOutlet.text = registration.Registration.ContactDetails.zipCode
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Contact details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Zip Code"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.DecimalPad
            textFieldOutlet.becomeFirstResponder()
        case 6:
            textFieldOutlet.text = registration.Registration.ContactDetails.email
            titleLabel.text = "Contact details"
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter email"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
        case 7:
            textFieldOutlet.text = registration.Registration.ContactDetails.phoneNumber
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Contact details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Phone Number"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.DecimalPad
            textFieldOutlet.becomeFirstResponder()
        case 8:
            textFieldOutlet.text = registration.Registration.securityDetails.username
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Security details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter username"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
        case 9:
            textFieldOutlet.text = registration.Registration.securityDetails.password
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Security details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter password"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
        default:
            break
            
        }
    }
}

