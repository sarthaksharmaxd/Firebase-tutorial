//
//  ForgotPasswordViewController.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 07/03/22.
//

import UIKit
import Firebase
import ProgressHUD
class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()
        
    }
    func customisation(){
        emailField.placeholder = "Email Address"
        emailField.borderStyle = .none
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(named: "silver")?.cgColor
        emailContainerView.layer.cornerRadius = 5
        
        resetButton.setTitle("RESET MY PASSWORD", for: .normal)
        resetButton.layer.cornerRadius = 5
        resetButton.tintColor = UIColor.white
    }
    @IBAction func closePressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton){
        
        guard let email = emailField.text, email != "" else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL_RESET)
            return
        }
        UserAPI().resetPassword(withEmail: email) {
            ProgressHUD.showSuccess(SUCCESS_STRING)
        } onError: { errorMessage in
            ProgressHUD.showError(errorMessage)
        }

    }
}
