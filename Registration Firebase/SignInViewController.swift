//
//  SignInViewController.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 06/03/22.
//

import UIKit
import FirebaseAuth
import ProgressHUD
class SignInViewController: UIViewController {

    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    let email = ""
    let password = ""
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
        passwordField.placeholder = "Password (8+ Characters)"
        passwordField.borderStyle = .none
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(named: "silver")?.cgColor
        passwordContainerView.layer.cornerRadius = 5
        
        signinButton.setTitle("Sign In", for: .normal)
        signinButton.tintColor = UIColor.white
        signinButton.layer.cornerRadius = 5
    }
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func signupPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func closePressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signInPressed(_ sender: UIButton) {
        
        self.userSignIn {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainPageViewController") as! MainPageViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } onError: { errorMessage in
            print(errorMessage)
        }

    }
    func validateFields(){
        guard let email = self.emailField.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        
        guard let password = self.passwordField.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
    }
    
    func userSignIn(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        ProgressHUD.show()
        if let email = emailField.text, let password = passwordField.text {
            let user = UserAPI()
            user.signIn(withEmail: email, password: password) {
                onSuccess()
                ProgressHUD.dismiss()
            } onError: { errorMessage in
                print("ERROR SIGNING IN")
                onError(errorMessage)
                ProgressHUD.dismiss()
            }

        }
    }
}
