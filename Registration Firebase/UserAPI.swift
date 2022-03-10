//
//  UserAPI.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 09/03/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import ProgressHUD
import UIKit
class UserAPI{
    
    
    func signUP(withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void ){
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if error != nil || username.isEmpty || email.isEmpty || password.isEmpty {
                ProgressHUD.showError(error?.localizedDescription)
                return
            }
            else {
                if let authData = authDataResult  {
                    
                    var dict: Dictionary<String, Any> = [UID : authData.user.uid,
                                                         NAME : username,
                                                         EMAIL : authData.user.email,
                                                         PROFILE_IMAGE_URL : "",
                                                         STATUS : ""
                    ]
                    guard let imageSelected = image else {
                       // ProgressHUD.showError("Please add an avatar")
                        return
                    }
                    
                    guard let imgData = imageSelected.jpegData(compressionQuality: 0.4) else{return}
                    
                    
                    let profileImgRef = Ref().storageSpecificProfile(uid: authData.user.uid)
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpg"
                    StorageServices.savePhoto(username: username, uid: authData.user.uid, data: imgData, metadata: metadata, storageProfileRef: profileImgRef, dict: dict) {
                        print("Successfully saved in storage")
                    } onError: { errorMessage in
                       // ProgressHUD.showError(errorMessage)
                    }

                    
                    print("Successfully sign up")
                }
            }
        }
    }
}
