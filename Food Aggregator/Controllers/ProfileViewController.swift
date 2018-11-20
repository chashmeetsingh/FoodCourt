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
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .red
        iv.image = UIImage(named: "person-1")
        return iv
    }()
    
    let firstNameField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "First Name"
        textField.title = "First Name"
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let lastNameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "First Name"
        textField.title = "First Name"
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let emailIDTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "First Name"
        textField.title = "First Name"
        textField.tintColor = Client.Colors.overcastBlueColor
        textField.selectedTitleColor = Client.Colors.overcastBlueColor
        textField.selectedLineColor = Client.Colors.overcastBlueColor
        textField.errorColor = .red
        textField.autocapitalizationType = .none
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func configureView() {
        view.addSubview(imageView)
        view.addSubview(firstNameField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailIDTextField)
        
        
    }

}
