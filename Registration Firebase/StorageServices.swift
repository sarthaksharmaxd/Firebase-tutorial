//
//  StorageServices.swift
//  Registration Firebase
//
//  Created by Sarthak Sharma on 10/03/22.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD
class StorageServices{
    static func savePhoto(username: String, uid: String, data: Data, metadata: StorageMetadata, storageProfileRef: StorageReference, dict: Dictionary<String, Any>, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        
        
        
        storageProfileRef.putData(data, metadata: metadata) { storageMetadata, error in
            if error != nil {
                ProgressHUD.showError(error?.localizedDescription)
            }
            else {
                let downloadUrl = storageProfileRef.downloadURL { url, error in
                    if error != nil {
                        ProgressHUD.showError(error?.localizedDescription)
                    }
                    else {
                        print("Yo")
                        if let imageURL = url?.absoluteString {
                            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                                changeRequest.displayName = username
                                changeRequest.photoURL = url
                                changeRequest.commitChanges(completion: { error in
                                    ProgressHUD.showError(error?.localizedDescription)
                                })
                                print("Committed changes")
                            }
                            var newDict = dict
                            newDict["profileImageUrl"] = imageURL
                            
                            Ref().databaseSpecificUser(uid: uid).updateChildValues(dict) { error, ref in
                                if error != nil {
                                    onError(error!.localizedDescription)
                                }
                                else {
                                    onSuccess()
                                    print("DATABASE SAVED")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
