//
//  ViewController.swift
//  registration
//
//  Created by Jasmin Ceco on 23/03/16.
//  Copyright © 2016 Jasmin Ceco. All rights reserved.
//

import UIKit
import Spring
import SCLAlertView
import ALCameraViewController


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var genderTextFileld: DesignableTextField!
    @IBOutlet weak var datepickerTextField: DesignableTextField!
    @IBOutlet weak var textFieldOutlet: DesignableTextField!
    
    @IBOutlet weak var selectImgBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var backroundImage: DesignableImageView!
    
    let alert = SCLAlertView()
    var registation = Registration()
    
    var lastTextField: DesignableTextField!
    
    struct animation
    {
        static var swipeRight: String = "squeezeRight"
        static var flipY:String = "flipY"
        
        struct type
        {
            static var spring: String = "spring"
            static var easeInBack: String = "easeInBack"
        }
    }
    
    var genderOption = ["Male", "Female", "I would rather Not Say"]
    
    let pickerView = UIPickerView()
    var backButton = UIBarButtonItem()
    var nextButton = UIBarButtonItem()
    let toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastTextField = textFieldOutlet
        
        // SETING PICKER FOR GENDER TEXT FIELD //
        pickerView.backgroundColor = UIColor.whiteColor()
        pickerView.alpha = 0.95
        pickerView.delegate = self
        genderTextFileld.inputView = pickerView
        
        // SETING TOOLBAR FOR ACTIVE TEXT FIELDs //
        toolBar.barStyle = UIBarStyle.Black
        toolBar.translucent = true
        toolBar.alpha = 0.95
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.sizeToFit()
        
        nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ViewController.nextBtnPressed(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done , target: self, action: #selector(ViewController.backPressed(_:)))
        
        backButton.enabled = false
        
        toolBar.setItems([backButton, spaceButton, nextButton], animated: true)
        toolBar.userInteractionEnabled = true
        toolBar.backgroundColor = UIColor.darkGrayColor()
        textFieldOutlet.inputAccessoryView = toolBar
        genderTextFileld.inputAccessoryView = toolBar
        datepickerTextField.inputAccessoryView = toolBar
        
        PrepareForm(self.registation.GetCurrentPage())
        
    }
    
    func PrepareForm(currPage: Registration.CurrentPageData)
    {
        // var currPage = self.registation.GetCurrentPage()
        var enteredData:  String = ""
        let confirmPassField: Int = 10
        
        
        if self.registation.currentPage == 0
        {
            backButton.enabled = false
            selectImgBtn.hidden = false
            userImage.hidden = false
        }
        else{
            backButton.enabled = true
        }
        
        if self.registation.currentPage == 1
        {
            selectImgBtn.hidden = true
            userImage.hidden = true
        }
        
        if self.registation.currentPage == self.registation.RegistrationData.count-1
        {
            nextButton.title = "Save"
            
        }
        else{
            nextButton.title = "Next"
        }
        
        if currPage.NotEnteredMandatoryField
        {
            descriptionLabel.text = currPage.ErrorMessage
            descriptionLabel.hidden = false
            lastTextField.borderColor = UIColor.redColor()
            lastTextField.borderWidth = 1.0
        }
        else
        {
            descriptionLabel.hidden = true
            lastTextField.borderColor = UIColor.clearColor()
            lastTextField.borderWidth = 0.0
        }
        
        
        if self.registation.RegistrationData[self.registation.currentPage] != ""
        {
            enteredData = self.registation.RegistrationData[self.registation.currentPage]
            
            if self.registation.currentPage == confirmPassField {
                if self.registation.RegistrationData[confirmPassField] !=  self.registation.RegistrationData[confirmPassField - 1]{
                    descriptionLabel.text = currPage.ErrorMessage
                    descriptionLabel.hidden = false
                    lastTextField.borderColor = UIColor.redColor()
                    lastTextField.borderWidth = 1.0
                    
                }
            }
        }
        
        if currPage.FieldType == 1 // tect field type
        {
            if enteredData != ""
            {
                ifEnterdDataExist(Data: enteredData, titleMsg: currPage.PlaceHolder)
            }
            
            setupAppropriateKeyboardAndTextField(textfield: true, gender: false, datepicker: false, placeHoleder: currPage.PlaceHolder, keyboard: .Alphabet, secure: false)
            
        }
        else if currPage.FieldType == 2 // date field type
        {
            setupAppropriateKeyboardAndTextField(textfield: false, gender: false, datepicker: true, placeHoleder: currPage.PlaceHolder, keyboard: .Default, secure: false)
        }
        else if currPage.FieldType == 3 // gender field type
        {
            setupAppropriateKeyboardAndTextField(textfield: false, gender: true, datepicker: false, placeHoleder: currPage.PlaceHolder,  keyboard: .Default, secure: false)
        }
        else if currPage.FieldType == 4 // zipcode field type
        {
            if enteredData != ""
            {
                ifEnterdDataExist(Data: enteredData, titleMsg: currPage.PlaceHolder)
            }
            setupAppropriateKeyboardAndTextField(textfield: true, gender: false, datepicker: false, placeHoleder: currPage.PlaceHolder, keyboard: .NumberPad , secure: false)
            
        }
        else if currPage.FieldType == 5 // email
        {
            if enteredData != ""
            {
                ifEnterdDataExist(Data: enteredData, titleMsg: currPage.PlaceHolder)
            }
            setupAppropriateKeyboardAndTextField(textfield: true, gender: false, datepicker: false, placeHoleder: currPage.PlaceHolder,  keyboard: .EmailAddress, secure: false)
            
        }
        else if currPage.FieldType == 6 // phone number
        {
            
            if enteredData != ""
            {
                ifEnterdDataExist(Data: enteredData, titleMsg: currPage.PlaceHolder)
            }
            setupAppropriateKeyboardAndTextField(textfield: true, gender: false, datepicker: false, placeHoleder: currPage.PlaceHolder,  keyboard: .PhonePad, secure: false)
            
        }
        else if currPage.FieldType == 7 // password
        {
            if enteredData != ""
            {
                ifEnterdDataExist(Data: enteredData, titleMsg: currPage.PlaceHolder)
            }
            setupAppropriateKeyboardAndTextField(textfield: true, gender: false, datepicker: false, placeHoleder: currPage.PlaceHolder,  keyboard: .Alphabet, secure: true)
            
        }
        else if currPage.FieldType == 8 // confirm password
        {
            
            setupAppropriateKeyboardAndTextField(textfield: true, gender: false, datepicker: false, placeHoleder: currPage.PlaceHolder,  keyboard: .Alphabet, secure: true )
            
        }
        
        // Postavi group name
        titleLabel.text = currPage.PageGroupName
        
    }
    
    func ifEnterdDataExist(Data enteredData: String, titleMsg: String){
        lastTextField.text! = enteredData
        textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
        descriptionLabel.text = titleMsg
        descriptionLabel.hidden = false
    }
    
    func setupAppropriateKeyboardAndTextField(textfield textfield: Bool,gender: Bool, datepicker: Bool, placeHoleder: String, keyboard: UIKeyboardType, secure: Bool)
    {
        textFieldOutlet.hidden = !textfield
        genderTextFileld.hidden = !gender
        datepickerTextField.hidden = !datepicker
        lastTextField.secureTextEntry = secure
        
        if textfield
        {
            textFieldOutlet.resignFirstResponder()
            textFieldOutlet.keyboardType = keyboard
            textFieldOutlet.becomeFirstResponder()
            lastTextField = textFieldOutlet
        }
        else
        {
            textFieldOutlet.resignFirstResponder()
        }
        
        if gender
        {
            lastTextField = genderTextFileld
            genderTextFileld.becomeFirstResponder()
        }
        else
        {
            genderTextFileld.resignFirstResponder()
        }
        
        if datepicker
        {
            lastTextField = datepickerTextField
            datepickerTextField.becomeFirstResponder()
        }
        else
        {
            datepickerTextField.resignFirstResponder()
        }
        
        lastTextField.attributedPlaceholder = NSAttributedString(string: placeHoleder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
        
        animate([lastTextField])
    }
    
    @IBAction func DateOfBirthPicker(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.backgroundColor = UIColor.whiteColor()
        datePickerView.alpha = 0.95
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged(_:)),forControlEvents: UIControlEvents.ValueChanged)
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
        
        for textfield in textfields{
            textfield.animation = animation.swipeRight
            textfield.curve = animation.type.spring
            textfield.force = 1.9
            textfield.duration = 0.5
            textfield.delay = 0.1
            textfield.damping = 0.7
            textfield.velocity = 0.5
            textfield.animate()
        }
    }
    
    @IBAction func selectPictureFromUserLibaryButton(sender: AnyObject) {
        textFieldOutlet.resignFirstResponder()
        
        let alertNew =  SCLAlertView()
        alertNew.addButton("Photo Library", action: { () -> Void in
            print("Photo Library pressed")
            let libraryViewController = ALCameraViewController.imagePickerViewController(true) { (image) -> Void in
                self.backroundImage.image = image
                registration.Registration().postImage = image
                
                self.lastTextField.becomeFirstResponder()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            self.presentViewController(libraryViewController, animated: true, completion: nil)
            
        })
        
        alertNew.addButton("Camera", action: { () -> Void in
            print("Camera pressed")
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil{
                let cameraViewController = ALCameraViewController(croppingEnabled: true, allowsLibraryAccess: true) { (image) -> Void in
                    self.backroundImage.image = image
                    registration.Registration().postImage = image
                    self.lastTextField.becomeFirstResponder()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                self.presentViewController(cameraViewController, animated: true, completion: nil)
            }else{
                print("No camera")
                self.noCamera()
            }
            
        })
        
        alertNew.showCloseButton = true
        alertNew.showSuccess("Set profile image", subTitle: "Choose image source", closeButtonTitle: "Cancel", duration: 20.0, colorStyle: 0x009933, colorTextButton: 0xFFFFFF)
        
    }
    // if no Camera!!
    func noCamera()
    {
        alert.showWarning("No Camera!", subTitle: "Try diferent source.")
    }
    
    
    
    @IBAction func nextBtnPressed(sender: UIButton)
    {
        self.PrepareForm(self.registation.NextPage(lastTextField.text!))
        
        lastTextField.text = ""
        
    }
    
    
    @IBAction func backPressed(sender: UIButton) {
        
        self.PrepareForm(self.registation.PreviousPage())
        
    }
}

//////***************************************************////
//                 |                                 |     //
//                 v  ovo se sada ne koristi_        v     //
//                                                         //
//////***************************************************////

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    // postavljanje izabrane slike na Avatar (prezentovanje korisniku i slanje na server)
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage selectedImage: UIImage, editingInfo: [String : AnyObject]?) {
        
        let alertNew =  SCLAlertView()
        alertNew.addButton("Save Image", action: { () -> Void in
            print("Save Image pressed")
            
            //TODO: -SAVE Profile Image to server
            
            //here you save image and place the selectedImage on screen
            
            // for now selectedImage it will be only shown on the screen
            
            // use this one to Resize Image, Store New profile image and Send it to Server
            self.registation.postImage = self.ResizeImage(selectedImage, targetSize: CGSize(width: 200, height: 200))
            self.userImage.hidden = true
            
            self.backroundImage.image = self.registation.postImage
            
            self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
            self.userImage.clipsToBounds = true
            self.dismissViewControllerAnimated(true, completion: nil)
            self.textFieldOutlet.becomeFirstResponder()
            
            //            if let imageData = UIImagePNGRepresentation(self.userImage.image!)
            //            {
            //                let base64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            //
            //              //  FBZClient.sharedInstance.SetAvatarPicture(base64String)
            //            }
        })
        alertNew.showCloseButton = true
        alertNew.showSuccess("New image selected!", subTitle: "Do you wont to save it?", closeButtonTitle: "Choose different image")
        
    }
    
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
}


