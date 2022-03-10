//
//  ViewController.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 04/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTermsOfService()
        customiseButtons()
       
    }
    
    
    func setTermsOfService(){
        let termsString = "By clicking Create a new account you agree to our Terms of Service"
        let url = URL(string: "https://www.google.com")
        let attributedString = NSMutableAttributedString.init(string: termsString)
        let range = NSString(string: termsString).range(of: "Terms of Service", options: .caseInsensitive)
        attributedString.addAttribute(.link, value: url, range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemTeal, range: range)
        
        termsLabel.attributedText = attributedString
    }
    func customiseButtons(){
        var config = UIButton.Configuration.filled()
        config.title = "Sign in with Facebook"
        config.image = UIImage(named: "fb-logo-2")
        config.imagePadding = 10
        config.background.backgroundColor = UIColor(named: "fb-logo-color")
        fbButton.configuration = config
        
        var googleConfig = UIButton.Configuration.filled()
        googleConfig.image = UIImage(named: "google-logo")
        googleConfig.title = "Sign in with Google"
        googleConfig.imagePadding = 10
        
        googleConfig.background.backgroundColor = UIColor(named: "google-color")
        googleConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -20, bottom: 0, trailing: 0)
        googleButton.configuration = googleConfig
        
        
        createAccountButton.backgroundColor = UIColor(named: "customBlack")
        createAccountButton.tintColor = UIColor.white
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

