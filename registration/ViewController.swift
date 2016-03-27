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
import SCLAlertView
import ALCameraViewController


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
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
    
    @IBOutlet weak var selectImgBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var backroundImage: DesignableImageView!
    let selectedImage = UIImagePickerController()
    let alert = SCLAlertView()
    var animEngine : AnimatinEngine!
    var registation = Registration()
    var isAnimating = true
    
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
    
    var index = 0
    let animationDuration: NSTimeInterval = 0.25
    let switchingInterval: NSTimeInterval = 3.0
    
    let images = [
        UIImage(named: "IMG13.png")!,
        UIImage(named: "IMG14.png")!,
        UIImage(named: "IMG15.png")!,
        UIImage(named: "IMG16.png")!,
        UIImage(named: "IMG17.png")!,
        UIImage(named: "IMG18.png")!,
        UIImage(named: "IMG19.png")!,
        UIImage(named: "IMG20.png")!,
        UIImage(named: "IMG21.png")!,
        UIImage(named: "IMG22.png")!,
        UIImage(named: "IMG23.png")!,
        UIImage(named: "IMG24.png")!,
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ViewController.nextBtnPressed(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done , target: self, action: #selector(ViewController.backPressed(_:)))
        
        backButton.enabled = false
        
        toolBar.setItems([backButton, spaceButton, nextButton], animated: false)
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
        
        if self.registation.currentPage == 0
        {
            backButton.enabled = false
        }
        else{
            backButton.enabled = true
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
        }
        else
        {
            descriptionLabel.hidden = true
        }
        

        if self.registation.RegistrationData[self.registation.currentPage] != ""
        {
            enteredData = self.registation.RegistrationData[self.registation.currentPage]
        }
        
        if currPage.FieldType == 1 // tect field type
        {
        
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string: currPage.PlaceHolder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            if enteredData != ""
            {
                textFieldOutlet.text! = enteredData
                textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
                descriptionLabel.text = currPage.PlaceHolder
                descriptionLabel.hidden = false
            }
            
            setupAppropriateKeyboardAndTextField(textfield: true, keyboard: .Alphabet, gender: false, datepicker: false)
            
            print(textFieldOutlet.text)
        }
        else if currPage.FieldType == 2 // date field type
        {
            datepickerTextField.attributedPlaceholder = NSAttributedString(string: currPage.PlaceHolder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            // datepickerTextField.text = enteredData
            
            setupAppropriateKeyboardAndTextField(textfield: false, keyboard: .Default, gender: false, datepicker: true)
        }
        else if currPage.FieldType == 3 // gender field type
        {
            genderTextFileld.attributedPlaceholder = NSAttributedString(string: currPage.PlaceHolder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            // datepickerTextField.text = enteredData
            
            setupAppropriateKeyboardAndTextField(textfield: false,  keyboard: .Default, gender: true, datepicker: false)
        }
        else if currPage.FieldType == 4 // zipcode field type
        {
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string: currPage.PlaceHolder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            
            // datepickerTextField.text = enteredData
            
            setupAppropriateKeyboardAndTextField(textfield: true,  keyboard: .DecimalPad, gender: false, datepicker: false)

        }
        else if currPage.FieldType == 5 // email
        {
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string: currPage.PlaceHolder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            
            // datepickerTextField.text = enteredData
            
            setupAppropriateKeyboardAndTextField(textfield: true,  keyboard: .EmailAddress, gender: false, datepicker: false)
            
        }
        else if currPage.FieldType == 6 // phone number
        {
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string: currPage.PlaceHolder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            
            // datepickerTextField.text = enteredData
            
            setupAppropriateKeyboardAndTextField(textfield: true,  keyboard: .DecimalPad, gender: false, datepicker: false)
            
        }
        else if currPage.FieldType == 7 // password
        {
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string: currPage.PlaceHolder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            
            // datepickerTextField.text = enteredData
            
            setupAppropriateKeyboardAndTextField(textfield: true,  keyboard: .Alphabet, gender: false, datepicker: false)
            
        }
        else if currPage.FieldType == 8 // confirm password
        {
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string: currPage.PlaceHolder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            
            
            // datepickerTextField.text = enteredData
            
            setupAppropriateKeyboardAndTextField(textfield: true,  keyboard: .Alphabet, gender: false, datepicker: false)
            
        }
        
        // Postavi group name
        titleLabel.text = currPage.PageGroupName
        
    }
    
    func setupAppropriateKeyboardAndTextField(textfield textfield: Bool, keyboard: UIKeyboardType, gender: Bool, datepicker: Bool)
    {
        textFieldOutlet.hidden = !textfield
        genderTextFileld.hidden = !gender
        datepickerTextField.hidden = !datepicker
        
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
            genderTextFileld.becomeFirstResponder()
            lastTextField = genderTextFileld
        }
        else
        {
            genderTextFileld.resignFirstResponder()
        }
        
        if datepicker
        {
            datepickerTextField.becomeFirstResponder()
            lastTextField = datepickerTextField
        }
        else
        {
            datepickerTextField.resignFirstResponder()
        }

        animate([lastTextField])
    }
    
    func animateImageView() {
        
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                if self.isAnimating == true {
                    self.animateImageView()
                }
                
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        /*
         transition.type = kCATransitionPush
         transition.subtype = kCATransitionFromRight
         */
        backroundImage.layer.addAnimation(transition, forKey: kCATransition)
        backroundImage.image = images[index]
        
        CATransaction.commit()
        
        //TODO: WTF
        index = index < images.count - 1 ? index + 1 : 0
        
        
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
            textfield.force = 2.9
            textfield.duration = 1
            textfield.delay = 0.1
            textfield.damping = 0.7
            textfield.velocity = 0.5
            textfield.animate()
        }
    }
    @IBAction func selectPictureFromUserLibaryButton(sender: AnyObject) {
        textFieldOutlet.resignFirstResponder()
        selectedImage.delegate = self
        
        let alertNew =  SCLAlertView()
        alertNew.addButton("Photo Library", action: { () -> Void in
            print("Photo Library pressed")
            let libraryViewController = ALCameraViewController.imagePickerViewController(true) { (image) -> Void in
                self.backroundImage.image = image
                registration.Registration().postImage = image
                
                self.textFieldOutlet.becomeFirstResponder()
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
                    self.textFieldOutlet.becomeFirstResponder()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                self.presentViewController(cameraViewController, animated: true, completion: nil)
            }else{
                print("No camera")
                self.noCamera()
            }
            
        })
        
        alertNew.showCloseButton = true
        alertNew.showSuccess("Change profile image", subTitle: "Choose image source", closeButtonTitle: "Cancel", duration: 20.0, colorStyle: 0x009933, colorTextButton: 0xFFFFFF)
        
    }
    // if no Camera!!
    func noCamera()
    {
        alert.showWarning("No Camera!", subTitle: "Try diferent source.")
    }
    
    
    func refresh(){
        print("firstname is: \(registation.firsName)")
        print("last name is: \(registation.lastName)")
        print("date of birth is:\(registation.dateOfBirth)")
        print("gender is: \(registation.gender)")
        print("address is: \(registation.address)")
        print("zipCode is: \(registation.zipCode)")
        print("email is: \(registation.email)")
        print("phoneNumber is: \(registation.phoneNumber)")
        print("username is: \(registation.username)")
        print("password is: \(registation.password)")
        print("confirmPassword is: \(registation.confirmPassword)")
        print("Image is: \(registation.postImage)")
        print("textfield tag is\(textFieldOutlet.tag)")
    }
    
    func configureCase (dataModel data: Registration!, descriptionLabel: UILabel, descriptionLabelhidden: Bool,  atributePlaceholder: String, textField: DesignableTextField, currentCase: Int, NextTag: Int, backbutton: UIBarButtonItem, backBntHidden: Bool, userImage: UIImageView, userImageHidden: Bool, selectedImg: UIButton, selectedImgHidden : Bool)
    {
        
        descriptionLabel.hidden = descriptionLabelhidden
        textField.attributedPlaceholder = NSAttributedString(string: atributePlaceholder, attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
        textField.tag = NextTag
        
        backbutton.enabled = backBntHidden
        userImage.hidden = userImageHidden
        selectedImg.hidden = selectedImgHidden
        
        switch currentCase{
        case 0: data.firsName = textField.text!
        textField.text = ""
            break
        case 1: data.lastName = textField.text!
        textField.text = ""
            break
        case 2: data.dateOfBirth = textField.text!
        textField.text = ""
            break
        case 3: data.gender = textField.text!
        textField.text = ""
            break
        case 4: data.address = textField.text!
        textField.text = ""
            break
        case 5: data.zipCode = textField.text!
        textField.text = ""
            break
        case 6: data.email = textField.text!
        textField.text = ""
            break
        case 7: data.phoneNumber = textField.text!
        textField.text = ""
            break
        case 8: data.username = textField.text!
        textField.text = ""
            break
        case 9: data.password = textField.text!
        textField.text = ""
            break
        case 10: data.confirmPassword = textField.text!
        textField.text = ""
            break
            
        default:
            break
        }
        
    }
    
    @IBAction func nextBtnPressed(sender: customButton)
    {
        self.PrepareForm(self.registation.NextPage(lastTextField.text!))
        
        lastTextField.text = ""
        
       
    }
    
    
    @IBAction func backPressed(sender: customButton) {
        
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


