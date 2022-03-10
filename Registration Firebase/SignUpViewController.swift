//
//  SignUpViewController.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 06/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD
class SignUpViewController: UIViewController {
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var signinButton: UIButton!
    
    var image: UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        customisation()
        avatar.layer.cornerRadius = avatar.frame.size.width / 2
        avatar.contentMode = .scaleAspectFit
        avatar.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(tapGestureRecognizer)
        
    }
    func customisation(){
        nameField.placeholder = "Full Name"
        nameField.borderStyle = .none
        nameContainerView.layer.borderWidth = 1
        nameContainerView.layer.borderColor = UIColor(named: "silver")?.cgColor
        nameContainerView.layer.cornerRadius = 5
        emailField.placeholder = "Email Address"
        emailField.borderStyle = .none
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(named: "silver")?.cgColor
        emailContainerView.layer.cornerRadius = 5
        passwordField.placeholder = "Password (8+ Characters)"
        passwordField.borderStyle = .none
        passwordField.isSecureTextEntry = false
     //   passwordField.textContentType = .oneTimeCode
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(named: "silver")?.cgColor
        passwordContainerView.layer.cornerRadius = 5
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.tintColor = UIColor.white
        signupButton.layer.cornerRadius = 5
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true) {
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func signinButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.validateFields()
        self.userSignUP {
            print("HELLO")
        } onError: { errorMessage in
            print("Error\(errorMessage)")
        }



        
        
        
        
        
        
    }
    func userSignUP(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
      //  ProgressHUD.show()
        if let username = nameField.text, let email = emailField.text, let password = passwordField.text  {
            print("before signup")
           // let user = UserAPI()
            UserAPI().signUP(withUsername: username, email: email, password: password, image: image)
            {   onSuccess()
            } onError: { errorMessage in
                onError(errorMessage)
                
            }


            print("func signup success111")
            
        }
        print("func signup success2")
    }
    func validateFields(){
        guard let username = self.nameField.text, !username.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_USERNAME)
            return
        }
        
        guard let email = self.emailField.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        
        guard let password = self.passwordField.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
    }
}
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[.editedImage] as? UIImage{
            image = imageSelected
            avatar.image = imageSelected
            avatar.contentMode = .scaleAspectFill
            
        }
        if let imageOriginal = info[.originalImage] as? UIImage{
            image = imageOriginal
            avatar.image = imageOriginal
            avatar.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true, completion: nil)
        
        
    }
}
extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
