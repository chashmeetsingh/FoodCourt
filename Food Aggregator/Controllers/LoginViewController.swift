//
//  LoginViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 13/11/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FontAwesome_swift
import MaterialComponents.MaterialButtons
import Toast_Swift
import MMDrawerController

class LoginViewController: UIViewController {
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    lazy var emailField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        textField.placeholder = "Email ID"
        textField.title = "Your email id"
        textField.iconFont = UIFont.fontAwesome(ofSize: 15, style: .solid)
        textField.iconText = String.fontAwesomeIcon(name: .at)
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.iconMarginBottom = 0
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        textField.placeholder = "Password"
        textField.title = "Password"
        textField.isSecureTextEntry = true
        textField.iconFont = UIFont.fontAwesome(ofSize: 15, style: .solid)
        textField.iconText = String.fontAwesomeIcon(name: .key)
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.iconMarginBottom = 0
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var loginButton: MDCButton = {
       let button = MDCButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(hex: "#00C853")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Login"
        configureView()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back_arrow"), style: .plain, target: self, action: #selector(dismissController))
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureView() {
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: emailField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: passwordField)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: loginButton)
        view.addConstraintsWithFormat(format: "V:|-16-[v0]-16-[v1]-16-[v2(48)]", views: emailField, passwordField, loginButton)
    }
    
    @objc func dismissController() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func loginButtonTapped() {
        view.endEditing(true)
        
        self.view.makeToastActivity(.center)
        toggleInteraction()
        
        if !(emailField.text?.isValidEmail())! {
            self.view.hideToastActivity()
            toggleInteraction()
            emailField.errorMessage = "Invalid email"
            emailField.becomeFirstResponder()
            return
        }
        emailField.errorMessage = ""
        
        if !(passwordField.text?.isValidPassword())! {
            self.view.hideToastActivity()
            toggleInteraction()
            passwordField.errorMessage = "Should be atleast 6 characters"
            passwordField.becomeFirstResponder()
            return
        }
        passwordField.errorMessage = ""
        
        let params = [
            Client.Keys.Email: emailField.text!,
            Client.Keys.Password: passwordField.text!
        ]
        
        Client.sharedInstance.loginUser(params as [String : AnyObject]) { (user, results, success, error) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                self.toggleInteraction()
                if success {
                    self.completeLogin()
                }
            }
        }
        
    }
    
    func completeLogin() {
        self.navigationController?.dismiss(animated: false, completion: nil)
        let mainController = ClientHomeViewController()
        let nvc = UINavigationController(rootViewController: mainController)
        let drawerViewController = DrawerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        self.appDelegate.centerContainer = MMDrawerController(center: nvc, leftDrawerViewController: drawerViewController)
        self.appDelegate.centerContainer!.openDrawerGestureModeMask = .panningCenterView
        self.appDelegate.centerContainer!.closeDrawerGestureModeMask = .panningCenterView
        self.appDelegate.centerContainer?.setDrawerVisualStateBlock(MMDrawerVisualState.slideAndScaleBlock())
        
        self.presentingViewController?.present(self.appDelegate.centerContainer!, animated: true, completion: nil)
    }
    
    func toggleInteraction() {
        self.emailField.isUserInteractionEnabled = !self.emailField.isUserInteractionEnabled
        self.passwordField.isUserInteractionEnabled = !self.passwordField.isUserInteractionEnabled
        self.loginButton.isUserInteractionEnabled = !self.loginButton.isUserInteractionEnabled
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let floatingField = textField as? SkyFloatingLabelTextField {
            if text.isEmpty {
                floatingField.errorMessage = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, let floatingField = textField as? SkyFloatingLabelTextField {
            if emailField == textField {
                if !text.isValidEmail() {
                    floatingField.errorMessage = "Invalid email"
                    return false
                } else {
                    floatingField.errorMessage = ""
                    passwordField.becomeFirstResponder()
                    return true
                }
            } else {
                if !text.isValidPassword() {
                    floatingField.errorMessage = "Should be atleast 6 characters"
                    return false
                } else {
                    floatingField.errorMessage = ""
                    loginButtonTapped()
                    return true
                }
            }
        }
        return true
    }
    
}
