//
//  Ref.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 10/03/22.
//

import Foundation
import Firebase
let REF_USER = "users"
let REF_PROFILE = "profile"
let STORAGE_ROOT_URL = "gs://registration-1ca8a.appspot.com"
let UID = "uid"
let NAME = "name"
let EMAIL = "email"
let PROFILE_IMAGE_URL = "profileImageUrl"
let STATUS = "status"
let ERROR_EMPTY_USERNAME = "Username cannot be empty"
let ERROR_EMPTY_EMAIL = "Email cannot be empty"
let ERROR_EMPTY_PASSWORD = "Password cannot be empty"
let ERROR_EMPTY_EMAIL_RESET = "Please enter an Email Address"
let SUCCESS_STRING = "We have sent you an Email for password reset."

class Ref{
    let databaseRoot: DatabaseReference = Database.database().reference()
    
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    let storageRoot: StorageReference = Storage.storage().reference(forURL: STORAGE_ROOT_URL)
    
    var storageProfile: StorageReference {
        return storageRoot.child(REF_PROFILE)
    }
    func storageSpecificProfile(uid: String) -> StorageReference{
        return storageProfile.child(uid)
    }
    
}
