//
//  ProfileViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 20/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ProfileViewController: UIViewController {
    
    var drawerOpen = false
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        iv.image = UIImage(named: "placeholder")
//        iv.tintColor = .black
        return iv
    }()
    
    let firstNameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "First Name"
        textField.title = "First Name"
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.autocapitalizationType = .none
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let lastNameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Last Name"
        textField.title = "Last Name"
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.autocapitalizationType = .none
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let emailIDTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Email ID"
        textField.title = "Email ID"
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.autocapitalizationType = .none
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Password"
        textField.title = "Password"
        textField.text = "drowssap"
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.isUserInteractionEnabled = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setValues()
    }
    
    func configureView() {
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        title = "Profile"
        
        view.addSubview(imageView)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        
        let widthForFrame = (self.view.frame.width / 2) - 16
        
        if let _ = appDelegate.currentUser {
            view.addSubview(passwordTextField)
            view.addSubview(emailIDTextField)
            view.addConstraintsWithFormat(format: "V:|[v0(\(widthForFrame - 16))]-16-[v1]-16-[v2]-16-[v3]-16-[v4]", views: imageView, firstNameTextField, lastNameTextField, emailIDTextField, passwordTextField)
            view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: passwordTextField)
            view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: emailIDTextField)
        } else {
            view.addConstraintsWithFormat(format: "V:|-8-[v0(\(widthForFrame - 16))]-16-[v1]-16-[v2]", views: imageView, firstNameTextField, lastNameTextField)
        }
        
//        view.addConstraintsWithFormat(format: "V:|-\(8 + 16 + widthForFrame - 16)-[v0]-32-[v1]", views: firstNameTextField, lastNameTextField)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
//        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.tableView, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: firstNameTextField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: lastNameTextField)
        
//        imageView.layer.cornerRadius = (widthForFrame - 16) / 2
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openDrawer))
        
        if let _ = appDelegate.currentUser {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditView))
        }
    }
    
    @objc func openDrawer() {
        if drawerOpen {
            appDelegate.centerContainer?.closeDrawer(animated: true, completion: nil)
        } else {
            appDelegate.centerContainer?.open(.left, animated: true, completion: nil)
        }
        drawerOpen = !drawerOpen
    }
    
    func setValues() {
        if let user = appDelegate.currentUser {
            firstNameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
            emailIDTextField.text = user.emailID
        } else {
            firstNameTextField.text = "Guest"
            lastNameTextField.text = "User"
        }
    }
    
    @objc func toggleEditView() {
        toggleFields()
    }
    
    func toggleFields() {
        firstNameTextField.isUserInteractionEnabled = !firstNameTextField.isUserInteractionEnabled
        lastNameTextField.isUserInteractionEnabled = !lastNameTextField.isUserInteractionEnabled
        passwordTextField.isUserInteractionEnabled = !passwordTextField.isUserInteractionEnabled
        if let _ = appDelegate.currentUser {
            if firstNameTextField.isUserInteractionEnabled {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(updateProfile))
            } else {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditView))
            }
        }
        if firstNameTextField.isUserInteractionEnabled {
            view.endEditing(true)
        }
    }
    
    @objc func updateProfile() {
        toggleFields()
        if !fieldsValid() {
            return
        }
        
        var params = [
            Client.Keys.First_Name: firstNameTextField.text!,
            Client.Keys.Last_Name: lastNameTextField.text!,
            Client.Keys.Email: appDelegate.currentUser!.emailID,
            Client.Keys.Token: appDelegate.currentUser!.accessToken
        ]
        
        if passwordTextField.text != "drowssap" {
            params[Client.Keys.Password] = passwordTextField.text!
        }
        
        self.view.makeToastActivity(.center)
        Client.sharedInstance.updateUserProfile(params as [String : AnyObject]) { (success, message) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                if success {
                    self.view.makeToast("Profile updated successfully.")
                    if let currentUserData = UserDefaults.standard.object(forKey: "currentUser") as? Data, var user = NSKeyedUnarchiver.unarchiveObject(with: currentUserData) as? [String : AnyObject] {
                        
                        user[Client.Keys.FirstName] = self.firstNameTextField.text! as AnyObject
                        user[Client.Keys.LastName] = self.lastNameTextField.text! as AnyObject
                        
                        if self.passwordTextField.text != "drowssap" {
                            user[Client.Keys.Password] = self.passwordTextField.text! as AnyObject
                        }
//                        self.appDelegate.currentUser = User(dictionary: user)
                        let data = NSKeyedArchiver.archivedData(withRootObject: user)
                        UserDefaults.standard.setValue(data, forKey: "currentUser")
                    }
                }
            }
        }
    }
    
    @objc func fieldsValid() -> Bool {
        if let firstName = firstNameTextField.text, firstName.isEmpty {
            self.view.makeToast("First Name is empty")
//            firstNameTextField.becomeFirstResponder()
            return false
        } else if let lastName = lastNameTextField.text, lastName.isEmpty {
            self.view.makeToast("Last Name is empty")
            lastNameTextField.becomeFirstResponder()
            return false
        } else if let password = passwordTextField.text, !password.isValidPassword() {
            self.view.makeToast("Password length < 6 characters.")
//            passwordTextField.becomeFirstResponder()
            return false
        }
        return true
    }

}
