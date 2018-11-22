//
//  SignupViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 20/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import MaterialComponents.MaterialButtons

class SignupViewController: UIViewController {
    
    lazy var firstNameTextField: SkyFloatingLabelBaseTextFieldWithIcon = {
        let textField = SkyFloatingLabelBaseTextFieldWithIcon()
        textField.title = "First Name"
        textField.placeholder = "First Name"
        textField.iconText = String.fontAwesomeIcon(name: .user)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var lastNameTextField: SkyFloatingLabelBaseTextFieldWithIcon = {
        let textField = SkyFloatingLabelBaseTextFieldWithIcon()
        textField.title = "Last Name"
        textField.placeholder = "Last Name"
        textField.iconText = String.fontAwesomeIcon(name: .user)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var emailIDTextField: SkyFloatingLabelBaseTextFieldWithIcon = {
        let textField = SkyFloatingLabelBaseTextFieldWithIcon()
        textField.title = "Email ID"
        textField.placeholder = "Email ID"
        textField.iconText = String.fontAwesomeIcon(name: .at)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: SkyFloatingLabelBaseTextFieldWithIcon = {
        let textField = SkyFloatingLabelBaseTextFieldWithIcon()
        textField.title = "Password"
        textField.placeholder = "Password"
        textField.iconText = String.fontAwesomeIcon(name: .key)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var confirmPasswordTextField: SkyFloatingLabelBaseTextFieldWithIcon = {
        let textField = SkyFloatingLabelBaseTextFieldWithIcon()
        textField.title = "Confirm Password"
        textField.placeholder = "Confirm Password"
        textField.iconText = String.fontAwesomeIcon(name: .key)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var phoneNumberTextField: SkyFloatingLabelBaseTextFieldWithIcon = {
        let textField = SkyFloatingLabelBaseTextFieldWithIcon()
        textField.title = "Phone Number"
        textField.placeholder = "Phone Number"
        textField.iconText = String.fontAwesomeIcon(name: .phone)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        textField.keyboardType = .phonePad
        return textField
    }()
    
    lazy var signUpButton: MDCButton = {
        let button = MDCButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: MDCButton = {
        let button = MDCButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        self.view.makeToast("Please sign up to continue.")
        
        title = "Sign Up"
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailIDTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
        
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: firstNameTextField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: lastNameTextField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: emailIDTextField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: passwordTextField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: confirmPasswordTextField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: phoneNumberTextField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: signUpButton)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: loginButton)
        
        view.addConstraintsWithFormat(format: "V:|-16-[v0]-16-[v1]-16-[v2]-16-[v3]-16-[v4]-16-[v5]-16-[v6(48)]-8-[v7(48)]", views: firstNameTextField, lastNameTextField, emailIDTextField, passwordTextField, confirmPasswordTextField, phoneNumberTextField, signUpButton, loginButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
    
    @objc func signUpButtonTapped() {
        view.endEditing(true)
        
        self.view.makeToastActivity(.center)
        toggleInteraction()
        
        if !(firstNameTextField.text?.isEmpty)! {
            self.view.hideToastActivity()
            toggleInteraction()
            firstNameTextField.errorMessage = "First Name empty"
            firstNameTextField.becomeFirstResponder()
            return
        }
        firstNameTextField.errorMessage = ""
        
        if !(lastNameTextField.text?.isEmpty)! {
            self.view.hideToastActivity()
            toggleInteraction()
            lastNameTextField.errorMessage = "Last Name empty"
            lastNameTextField.becomeFirstResponder()
            return
        }
        lastNameTextField.errorMessage = ""
        
        if !(emailIDTextField.text?.isValidEmail())! {
            self.view.hideToastActivity()
            toggleInteraction()
            emailIDTextField.errorMessage = "Invalid email"
            emailIDTextField.becomeFirstResponder()
            return
        }
        emailIDTextField.errorMessage = ""
        
        if !(passwordTextField.text?.isValidPassword())! {
            self.view.hideToastActivity()
            toggleInteraction()
            passwordTextField.errorMessage = "Should be atleast 6 characters"
            passwordTextField.becomeFirstResponder()
            return
        }
        passwordTextField.errorMessage = ""
        
        if confirmPasswordTextField.text! != passwordTextField.text! {
            self.view.hideToastActivity()
            toggleInteraction()
            confirmPasswordTextField.errorMessage = "Passwords do not match"
            confirmPasswordTextField.becomeFirstResponder()
            return
        }
        passwordTextField.errorMessage = ""
        
        if !(phoneNumberTextField.text?.isPhoneNumberValid())! {
            self.view.hideToastActivity()
            toggleInteraction()
            phoneNumberTextField.errorMessage = "Invalid phone no."
            phoneNumberTextField.becomeFirstResponder()
            return
        }
        phoneNumberTextField.errorMessage = ""
        
        let params = [
            Client.Keys.FirstName: firstNameTextField.text!,
            Client.Keys.LastName: lastNameTextField.text!,
            Client.Keys.Email: emailIDTextField.text!,
            Client.Keys.Password: passwordTextField.text!,
            Client.Keys.PhoneNum: phoneNumberTextField.text!
        ]
        
        Client.sharedInstance.signUpUser(params as [String : AnyObject]) { (user, success, error) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.toggleInteraction()
                if success {
                    self.view.makeToastActivity(.center)
                    Client.sharedInstance.loginUser(params as [String : AnyObject], { (user, success, message) in
                        DispatchQueue.main.async {
                            self.view.hideToastActivity()
                            self.toggleInteraction()
                            if success {
                                self.loginUser()
                            }
                        }
                    })
                }
            }
        }
        
    }
    
    @objc func loginButtonTapped() {
        let vc = LoginViewController()
        vc.fromSignUpView = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loginUser() {
        self.navigationController?.dismiss(animated: false, completion: nil)
    }
    
    func toggleInteraction() {
        firstNameTextField.isUserInteractionEnabled = !firstNameTextField.isUserInteractionEnabled
        lastNameTextField.isUserInteractionEnabled = !lastNameTextField.isUserInteractionEnabled
        emailIDTextField.isUserInteractionEnabled = !emailIDTextField.isUserInteractionEnabled
        passwordTextField.isUserInteractionEnabled = !passwordTextField.isUserInteractionEnabled
        phoneNumberTextField.isUserInteractionEnabled = !phoneNumberTextField.isUserInteractionEnabled
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let floatingField = textField as? SkyFloatingLabelTextField {
            if text.isEmpty {
                floatingField.errorMessage = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, let floatingField = textField as? SkyFloatingLabelTextField {
            if firstNameTextField == textField {
                if text.isEmpty {
                    floatingField.errorMessage = "First Name empty"
                    return false
                } else {
                    floatingField.errorMessage = ""
                    lastNameTextField.becomeFirstResponder()
                }
            } else if lastNameTextField == textField {
                if text.isEmpty {
                    floatingField.errorMessage = "Last Name empty"
                    return false
                } else {
                    emailIDTextField.becomeFirstResponder()
                    return true
                }
            } else if emailIDTextField == textField {
                if !text.isValidEmail() {
                    floatingField.errorMessage = "Invalid email"
                    return false
                } else {
                    floatingField.errorMessage = ""
                    passwordTextField.becomeFirstResponder()
                    return true
                }
            } else if passwordTextField == textField {
                if !text.isValidPassword() {
                    floatingField.errorMessage = "Should be atleast 6 characters"
                    return false
                } else {
                    floatingField.errorMessage = ""
                    confirmPasswordTextField.becomeFirstResponder()
                    return true
                }
            } else if confirmPasswordTextField == textField {
                if text != passwordTextField.text! {
                    floatingField.errorMessage = "Passwords do not match"
                    return false
                } else {
                    floatingField.errorMessage = ""
                    phoneNumberTextField.becomeFirstResponder()
                    return true
                }
            } else if phoneNumberTextField == textField {
                if !text.isPhoneNumberValid() {
                    floatingField.errorMessage = "Invalid phone no."
                    return false
                } else {
                    floatingField.errorMessage = ""
                    signUpButtonTapped()
                    return true
                }
            }
        }
        return true
    }
    
}
