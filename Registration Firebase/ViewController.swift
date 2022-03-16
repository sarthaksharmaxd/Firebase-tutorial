//
//  ViewController.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 04/03/22.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import FirebaseAuth
import GoogleSignIn
class ViewController: UIViewController {
    @IBOutlet weak var newButton: FBLoginButton!
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        customiseButtons()
        additionalStyling()
        // Do any additional setup after loading the view.

        setTermsOfService()
        
//        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
//            print("Already Logged In")
//        }
    }
    
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//    }

    
    func setTermsOfService(){
        let termsString = "By clicking Create a new account you agree to our Terms of Service"
        
        let attributedString = NSMutableAttributedString(string: termsString)
        let termsRange = (termsString as NSString).range(of: "Terms of Service", options: .caseInsensitive)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemTeal, range: termsRange)
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(termsTapped(gesture: )))
        termsLabel.addGestureRecognizer(tap)
        termsLabel.isUserInteractionEnabled = true
        termsLabel.attributedText = attributedString
    }
    @objc func termsTapped(gesture: UITapGestureRecognizer){
        let labelString = "By clicking Create a new account you agree to our Terms of Service"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: labelString)
        let termsRange = attributedString.mutableString.range(of: "Terms of Service", options: .caseInsensitive)
        

        if gesture.didTapAttributedTextInLabel(label: termsLabel, inRange: termsRange) {
            print("Terms Tapped")
        } else {
            print("Tapped none")
        }
        
    }
    func customiseButtons(){
        var fbConfig = FBLoginButton.Configuration.filled()

        fbConfig.title = "Sign in with Facebook"
        fbConfig.image = UIImage(named: "fb-logo")
        fbConfig.background.backgroundColor = UIColor(named: "fb-logo-color")
        fbConfig.imagePadding = 10
        fbConfig.cornerStyle = .fixed
        fbConfig.background.cornerRadius = 10

        fbButton.configuration = fbConfig
//
        var googleConfig = UIButton.Configuration.filled()
        googleConfig.image = UIImage(named: "google-logo")
        googleConfig.title = "Sign in with Google"
        googleConfig.imagePadding = 10
        googleConfig.cornerStyle = .fixed
        googleConfig.background.cornerRadius = 10
        googleConfig.background.backgroundColor = UIColor(named: "google-color")
        googleConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -20, bottom: 0, trailing: 0)
        googleConfig.cornerStyle = .fixed
        googleButton.configuration = googleConfig
        
        
        
        
        
    }
    func additionalStyling(){
        
        
        fbButton.layer.cornerRadius = 20
       // fbButton.layer.masksToBounds = false
        fbButton.clipsToBounds = true
        fbButton.layer.masksToBounds = false
        fbButton.layer.shadowColor = UIColor.darkGray.cgColor
        fbButton.layer.shadowRadius = 10
        fbButton.layer.shadowOpacity = 1
        fbButton.layer.shadowOffset = .zero
        fbButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        fbButton.titleLabel?.adjustsFontSizeToFitWidth = true
        fbButton.titleLabel?.minimumScaleFactor = 0.1
       
        googleButton.clipsToBounds = true
        googleButton.layer.masksToBounds = false
        googleButton.layer.shadowColor = UIColor.darkGray.cgColor
        googleButton.layer.shadowRadius = 10
        googleButton.layer.shadowOpacity = 1
        googleButton.layer.shadowOffset = .zero
        googleButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        
        createAccountButton.layer.cornerRadius = 10
        createAccountButton.layer.shadowColor = UIColor.darkGray.cgColor
        createAccountButton.layer.shadowRadius = 10
        createAccountButton.layer.shadowOpacity = 1
        createAccountButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        createAccountButton.backgroundColor = UIColor(named: "customBlack")
        createAccountButton.tintColor = UIColor.systemBackground
        createAccountButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
            // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: CGSize.zero)
            let textStorage = NSTextStorage(attributedString: label.attributedText!)

            // Configure layoutManager and textStorage
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)

            // Configure textContainer
            textContainer.lineFragmentPadding = 0.0
            textContainer.lineBreakMode = label.lineBreakMode
            textContainer.maximumNumberOfLines = label.numberOfLines
            let labelSize = label.bounds.size
            textContainer.size = labelSize

            // Find the tapped character location and compare it to the specified range
            let locationOfTouchInLabel = self.location(in: label)
            let textBoundingBox = layoutManager.usedRect(for: textContainer)

            let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

            let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
            let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
//extension ViewController: LoginButtonDelegate {
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        let token = result?.token?.tokenString
//
//        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : "email,name"], tokenString: token, version: nil, httpMethod: .get)
//        request.start { connection, result, error in
//            if error != nil {
//                print("Error,\(error?.localizedDescription)")
//            } else {
//                print("\(result)")
//            }
//        }
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        print("Logged Out")
//    }
//}
extension ViewController {
    @IBAction func loginFacebookAction(sender: AnyObject) {//action of the custom button in the storyboard
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { result, error in
            if error != nil {
                print("OOPS ERROR,\(error)")
                return
            }
          else {
              let fbloginresult = result!
            // if user cancel the login
            if (result?.isCancelled)!{
                print("Cancelled")
                    return
            }
            if(fbloginresult.grantedPermissions.contains("email"))
            {
              self.getFBUserData()
                self.signIntoFirebase()
            }
          }
        }

     }

     func getFBUserData(){
         if let token = AccessToken.current?.tokenString {
             let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : "email,name,picture,last_name"], tokenString: token, version: nil, httpMethod: .get)
             request.start { connection, result, error in
                 if error != nil {
                     print("Error,\(error?.localizedDescription)")
                 } else {
                     
                     print("\(result)")
                 }
             }
         }
//
         

     }
    
    
    func signIntoFirebase(){
        guard let token = AccessToken.current?.tokenString else {return}
         let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signIn(with: credential) { authDataResult, error in
            if error != nil {
                print("ERROR SIGNING INTO FIREBASE,\(error?.localizedDescription)")
            }
            else {
                print("SUCCESSFULLY SIGNED INTO FIREBASE")
                
            }
        }
    }
    @IBAction func googleSignInPressed(_ sender: UIButton){
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if error != nil {
                print("ERROR,\(error?.localizedDescription)")
                return
            } else {
                self.googleSignIn(user: user)
            }
        }

    }
    func googleSignIn(user: GIDGoogleUser?){
        guard let idToken = user?.authentication.idToken,
              let accessToken = user?.authentication.accessToken else {return}
         let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
        Auth.auth().signIn(with: credential) { authDataResult, error in
            if error != nil {
                print("ERROR SIGNING IN WITH GOOGLE,\(error)")
            }
            else {
                print("SUCCESSFULLY SIGNED IN WITH GOOGLE")
                print(user?.profile?.email)
            }
        }
        
    }
}
