//
//  Registration.swift
//  registration
//
//  Created by Jasmin Ceco on 23/03/16.
//  Copyright © 2016 Jasmin Ceco. All rights reserved.
//

import UIKit


class Registration {
    static let TextFieldType = 1
    static let DateFieldType = 2
    static let GenderFieldType = 3
    static let ZipCodeType = 4
    static let EmailType = 5
    static let PhoneNumberType = 6
    static let PasswordType = 7
    static let ConfirmPasswordType = 8
    
    var currentPage: Int = 0
    private let errorMessage: [String] = ["First name is mandatory!",
                                          "Last name is mandatory!",
                                          "",
                                          "",
                                          "Home adress is mandatory",
                                          "",
                                          "Email adress is mandatory",
                                          "Phone number is mandatory field",
                                          "User name is mandatory field",
                                          "Password is mandatory",
                                          "Password do not match"]
    
    private let isTxtFieldMandatory: [Bool] = [true,
                                               true,
                                               false,
                                               false,
                                               true,
                                               false,
                                               true,
                                               true,
                                               true,
                                               true,
                                               true]
    
    private let fieldType: [Int] = [TextFieldType,
                                    TextFieldType,
                                    DateFieldType,
                                    GenderFieldType,
                                    TextFieldType,
                                    ZipCodeType,
                                    EmailType,
                                    PhoneNumberType,
                                    TextFieldType,
                                    PasswordType,
                                    ConfirmPasswordType]
    
    private let textFieldPlaceHolder: [String] = ["Enter first name",
                                                  "Enter last name",
                                                  "Enter date of birth",
                                                  "Enter gender",
                                                  "Enter home address",
                                                  "Enter zip code",
                                                  "Enter email",
                                                  "Enter phone number",
                                                  "Enter username",
                                                  "Enter password",
                                                  "Confirm password"]
    
    private let currentPageGroup: [Int] = [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2]
    
    
    private let groupDetails: [String] = ["Personal data", "Contact data", "Security data"]
    
    struct CurrentPageData {
        var PageGroupName: String = ""
        var PlaceHolder: String = ""
        var FieldType: Int = 1
        var Mandatory: Bool = true
        var ErrorMessage: String = ""
        var NotEnteredMandatoryField = false
    }
    
    var RegistrationData: [String] = ["", "", "", "", "", "", "", "", "", "", ""]
    
    var firsName: String = ""
    var lastName: String = ""
    var dateOfBirth: String = ""
    var gender : String = ""
    var address: String = ""
    var zipCode: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var username: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var postImage: UIImage!
    
    func NextPage(currentData: String) -> CurrentPageData
    {
        if self.isTxtFieldMandatory[currentPage]
        {
            if currentData == ""
            {
                var currData = GetCurrentPage()
                currData.NotEnteredMandatoryField = true
                return currData
            }
        }
        
        self.RegistrationData[currentPage] = currentData
        print("Registration data for index \(currentPage), data: \(self.RegistrationData[currentPage])")
        
        if (currentPage < errorMessage.count - 1)
        {
            currentPage = currentPage + 1
        }
        
        return GetCurrentPage()
    }
    
    func PreviousPage()  -> CurrentPageData
    {
        if currentPage > 0
        {
            currentPage = currentPage - 1
        }
        return GetCurrentPage()
    }
    
    func GetCurrentPage() -> CurrentPageData
    {
        var currPage: CurrentPageData = CurrentPageData()
        
        currPage.ErrorMessage = errorMessage[self.currentPage]
        currPage.FieldType = fieldType[self.currentPage]
        currPage.PageGroupName = groupDetails[currentPageGroup[self.currentPage]]
        currPage.PlaceHolder = textFieldPlaceHolder[self.currentPage]
        currPage.Mandatory = isTxtFieldMandatory[self.currentPage]
        
        return currPage
    }
}
