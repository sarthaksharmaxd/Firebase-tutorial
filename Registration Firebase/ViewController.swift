//
//  ViewController.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 04/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTermsOfService()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customiseButtons()
        additionalStyling()
    }
    
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
        googleConfig.cornerStyle = .fixed
        googleButton.configuration = googleConfig
        
        
        
        
        
    }
    func additionalStyling(){
        
        fbButton.layer.cornerRadius = 10
        fbButton.clipsToBounds = true
        fbButton.layer.masksToBounds = true
        fbButton.layer.shadowColor = UIColor(named: "customGrey")?.cgColor
        fbButton.layer.shadowRadius = 10
        fbButton.layer.shadowOpacity = 1
        fbButton.layer.shadowPath = UIBezierPath(rect: fbButton.bounds).cgPath
        fbButton.layer.shadowOffset = .zero
        
        googleButton.layer.cornerRadius = 10
        
        googleButton.clipsToBounds = true
        googleButton.layer.masksToBounds = true
        googleButton.layer.shadowColor = UIColor(named: "customGrey")?.cgColor
        googleButton.layer.shadowRadius = 10
        googleButton.layer.shadowOpacity = 1
        googleButton.layer.shadowPath = UIBezierPath(rect: googleButton.bounds).cgPath
        googleButton.layer.shadowOffset = .zero
        
        createAccountButton.layer.cornerRadius = 10
        createAccountButton.layer.shadowColor = UIColor(named: "customGrey")?.cgColor
        createAccountButton.layer.shadowRadius = 10
        createAccountButton.layer.shadowOpacity = 1
        createAccountButton.layer.shadowPath = UIBezierPath(rect: createAccountButton.bounds).cgPath
        createAccountButton.layer.shadowOffset = .zero
        createAccountButton.backgroundColor = UIColor(named: "customBlack")
        createAccountButton.tintColor = UIColor.systemBackground
        
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
