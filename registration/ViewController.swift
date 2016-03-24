//
//  ViewController.swift
//  registration
//
//  Created by Jasmin Ceco on 23/03/16.
//  Copyright © 2016 Jasmin Ceco. All rights reserved.
//

import UIKit
import pop
import Spring

class ViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateTopConst: NSLayoutConstraint!
    @IBOutlet weak var genderTopConst: NSLayoutConstraint!
    @IBOutlet weak var textfieldCenter: NSLayoutConstraint!
    @IBOutlet weak var genderCentarConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genderTextFileld: DesignableTextField!
    @IBOutlet weak var datepickerTextField: DesignableTextField!
    @IBOutlet weak var textFieldOutlet: DesignableTextField!
    
    var animEngine : AnimatinEngine!
    var registation = Registration()
    
    var genderOption = ["Male", "Female", "I would rather Not Say"]
    
    let pickerView = UIPickerView()
    var backButton = UIBarButtonItem()
    var nextButton = UIBarButtonItem()
    let toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registation = Registration()
        textFieldOutlet.becomeFirstResponder()
        descriptionLabel.hidden = true
        textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"first name", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
        // SETING PICKER FOR GENDER TEXT FIELD //
        pickerView.backgroundColor = UIColor.whiteColor()
        pickerView.alpha = 0.95
        pickerView.delegate = self
        genderTextFileld.inputView = pickerView
        
        genderTextFileld.hidden = true
        datepickerTextField.hidden = true
        
        
        toolBar.barStyle = UIBarStyle.Black
        toolBar.translucent = true
        toolBar.alpha = 0.95
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.sizeToFit()
        
        
        nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Done, target: self, action: "nextBtnPressed:")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done , target: self, action: "backPressed:")
        
        backButton.enabled = false
        
        toolBar.setItems([backButton, spaceButton, nextButton], animated: false)
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
    func isValidEmail(testStr:String) -> Bool {
        
        
        print("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
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
    
    func animate(textfields:[DesignableTextField]) {
        //        self.animEngine = AnimatinEngine(constraints: [textfieldCenter, genderCentarConstraint, dateCenterConstraint])
        //
        //        self.animEngine.animateOfSreen(5)
        for textfield in textfields{
            textfield.animation = "squeezeRight"
            textfield.curve = "easeInBack"
            textfield.force = 2.9
            textfield.duration = 0.5
            textfield.delay = 0.1
            textfield.damping = 0.7
            textfield.velocity = 0.5
            textfield.animate()
        }
        
        func animateOnMisstype(textfields: [DesignableTextField])
        {
            for textfield in textfields{
                textfield.animation = "shake"
                textfield.curve = "easeOutSine"
                textfield.force = 1.7
                textfield.duration = 0.7
                textfield.animate()
            }
            
            
        }
    }
    func refresh(){
        print("firstname is: \(registration.Registration.firsName)")
        print("last name is: \(registration.Registration.lastName)")
        print("date of birth is:\(registration.Registration.dateOfBirth)")
        print("gender is: \(registration.Registration.gender)")
        print("address is: \(registration.Registration.address)")
        print("zipCode is: \(registration.Registration.zipCode)")
        
          print("email is: \(registration.Registration.email)")
          print("phoneNumber is: \(registration.Registration.phoneNumber)")
          print("username is: \(registration.Registration.username)")
          print("password is: \(registration.Registration.password)")
        print("confirmPassword is: \(registration.Registration.confirmPassword)")
        print("textfield tag is\(textFieldOutlet.tag)")
    }
    
    
    
    @IBAction func nextBtnPressed(sender: customButton) {
        
        
        animate([textFieldOutlet, datepickerTextField, genderTextFileld])
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
                registration.Registration.firsName = textFieldOutlet.text!
                textFieldOutlet.text = ""
                textFieldOutlet.tag = 1
                backButton.enabled = true
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
                registration.Registration.lastName = textFieldOutlet.text!
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
            registration.Registration.dateOfBirth = datepickerTextField.text!
            textFieldOutlet.text = ""
            textFieldOutlet.tag = 3
            datepickerTextField.hidden = true
            datepickerTextField.resignFirstResponder()
            genderTextFileld.becomeFirstResponder()
            genderTopConst.constant = 280
            genderTextFileld.hidden = false
        case 3:
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter home address", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            registration.Registration.gender = genderTextFileld.text!
            textFieldOutlet.text = ""
            textFieldOutlet.tag = 4
            textFieldOutlet.hidden = false
            genderTextFileld.hidden = true
            textFieldOutlet.becomeFirstResponder()
            genderTextFileld.resignFirstResponder()
            titleLabel.text = "Contact details"
            
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
                registration.Registration.address = textFieldOutlet.text!
                textFieldOutlet.text = ""
                textFieldOutlet.tag = 5
                textFieldOutlet.resignFirstResponder()
                textFieldOutlet.keyboardType = UIKeyboardType.DecimalPad
                textFieldOutlet.becomeFirstResponder()
            }
            
        case 5:
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter email", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            registration.Registration.zipCode = textFieldOutlet.text!
            textFieldOutlet.text = ""
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
            textFieldOutlet.tag = 6
            
            
        case 6:
            if !isValidEmail(textFieldOutlet.text!)
            {
                
                descriptionLabel.hidden = false
                descriptionLabel.text = "Not valid email address!"
            }
            else
            {
                
                descriptionLabel.hidden = true
                textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter phone Number", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
                registration.Registration.email = textFieldOutlet.text!
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
                
                registration.Registration.phoneNumber = textFieldOutlet.text!
                textFieldOutlet.resignFirstResponder()
                textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
                textFieldOutlet.becomeFirstResponder()
                textFieldOutlet.text = ""
                titleLabel.text = "Security details"
                textFieldOutlet.tag = 8
            }
        case 8:
            
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"enter password", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            registration.Registration.username = textFieldOutlet.text!
            
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
                
                registration.Registration.password = textFieldOutlet.text!
                
                textFieldOutlet.text = ""
                textFieldOutlet.tag = 10
                refresh()
            }
            
        case 10:
            if textFieldOutlet.text != registration.Registration.password
            {
                descriptionLabel.hidden = false
                descriptionLabel.text = "password do not macth!"
                
            }else{
                descriptionLabel.hidden = true
                registration.Registration.confirmPassword = textFieldOutlet.text!
                
                /// sada sve treba poslati na server
            }
        default:
            break
            
        }
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if textFieldOutlet.tag < 0{
            backButton.enabled = false
            textFieldOutlet.tag = textFieldOutlet.tag + 1
        }
        if textFieldOutlet.tag > 10{
            nextButton.enabled = false
            textFieldOutlet.tag = textFieldOutlet.tag - 1
        }
    }
    
    
    @IBAction func backPressed(sender: customButton) {
        
        
        if textFieldOutlet.tag >= 0 {
            textFieldOutlet.tag = textFieldOutlet.tag - 1
            
        }
        
        animate([textFieldOutlet, datepickerTextField, genderTextFileld])
        
        switch textFieldOutlet.tag {
        case 0:
            textFieldOutlet.text = registration.Registration.firsName
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter First Name"
            titleLabel.text = "Personal details"
            
        case 1:
            textFieldOutlet.text = registration.Registration.lastName
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Personal details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Last Name"
            textFieldOutlet.hidden = false
            datepickerTextField.hidden = true
            genderTextFileld.hidden = true
            textFieldOutlet.becomeFirstResponder()
        case 2:
            datepickerTextField.text = registration.Registration.dateOfBirth
            datepickerTextField.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Personal details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Date of Birth"
            textFieldOutlet.hidden = true
            datepickerTextField.hidden = false
            datepickerTextField.becomeFirstResponder()
        case 3:
            textFieldOutlet.text = registration.Registration.gender
            genderTextFileld.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Personal details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Gender"
            textFieldOutlet.hidden = false
            datepickerTextField.hidden = true
            genderTextFileld.becomeFirstResponder()
        case 4:
            textFieldOutlet.text = registration.Registration.address
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Contact details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Home Address"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
        case 5:
            textFieldOutlet.text = registration.Registration.zipCode
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Contact details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Zip Code"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.DecimalPad
            textFieldOutlet.becomeFirstResponder()
        case 6:
            textFieldOutlet.text = registration.Registration.email
            titleLabel.text = "Contact details"
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter email"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
        case 7:
            textFieldOutlet.text = registration.Registration.phoneNumber
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Contact details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter Phone Number"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.DecimalPad
            textFieldOutlet.becomeFirstResponder()
        case 8:
            textFieldOutlet.text = registration.Registration.username
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            titleLabel.text = "Security details"
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter username"
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = UIKeyboardType.Alphabet
            textFieldOutlet.becomeFirstResponder()
        case 9:
            textFieldOutlet.text = registration.Registration.password
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

