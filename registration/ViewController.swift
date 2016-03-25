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
        
        
    }
    
    func animateImageView() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.animateImageView()
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
        //        self.animEngine = AnimatinEngine(constraints: [textfieldCenter, genderCentarConstraint, dateCenterConstraint])
        //
        //        self.animEngine.animateOfSreen(5)
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
            let sourceType:UIImagePickerControllerSourceType? = UIImagePickerControllerSourceType.PhotoLibrary
            self.selectedImage.sourceType = sourceType!
            self.selectedImage.allowsEditing = false
            self.presentViewController(self.selectedImage, animated: true, completion: nil)
        })
        
        alertNew.addButton("Camera", action: { () -> Void in
            print("Camera pressed")
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil{
                let sourceType:UIImagePickerControllerSourceType? = UIImagePickerControllerSourceType.Camera
                self.selectedImage.sourceType = sourceType!
                self.selectedImage.allowsEditing = false
                self.presentViewController(self.selectedImage, animated: true, completion: nil)
            }else{
                print("No camera")
                self.noCamera()
            }
            
        })
        
        alertNew.showCloseButton = true
        alertNew.showSuccess("Change profile image", subTitle: "Choose image source", closeButtonTitle: "Cancel")
    }
    // if no Camera!!
    func noCamera()
    {
        alert.showWarning("No Camera!", subTitle: "Try diferent source.")
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
                userImage.hidden = true
                selectImgBtn.hidden = true
                
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
                //  dateTopConst.constant = 280
                textFieldOutlet.text = ""
                textFieldOutlet.tag = 2
                textFieldOutlet.hidden = true
                genderTextFileld.hidden = true
                datepickerTextField.hidden = false
                textFieldOutlet.resignFirstResponder()
                datepickerTextField.becomeFirstResponder()
                backroundImage.image = images[index + 1]
                animateImageView()
            }
            
        case 2:
            genderTextFileld.attributedPlaceholder = NSAttributedString(string:"enter gender", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()] )
            registration.Registration.dateOfBirth = datepickerTextField.text!
            textFieldOutlet.text = ""
            textFieldOutlet.tag = 3
            datepickerTextField.hidden = true
            datepickerTextField.resignFirstResponder()
            genderTextFileld.becomeFirstResponder()
            // genderTopConst.constant = 280
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
    
    
    @IBAction func backPressed(sender: customButton) {
        
        if textFieldOutlet.tag >= 0 {
            textFieldOutlet.tag = textFieldOutlet.tag - 1
        }
        
        animate([textFieldOutlet, datepickerTextField, genderTextFileld])
        
        switch textFieldOutlet.tag {
            
        case 0:
            backButton.enabled = false
            textFieldOutlet.text = registration.Registration.firsName
            textFieldOutlet.attributedPlaceholder = NSAttributedString(string:"")
            descriptionLabel.hidden = false
            descriptionLabel.text = "Enter First Name"
            titleLabel.text = "Personal details"
            userImage.hidden = false
            selectImgBtn.hidden = false
            
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
            registration.Registration.postImage = self.ResizeImage(selectedImage, targetSize: CGSize(width: 200, height: 200))
            self.userImage.hidden = true
            
            self.backroundImage.image = registration.Registration.postImage
            
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


