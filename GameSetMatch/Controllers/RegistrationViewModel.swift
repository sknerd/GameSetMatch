//
//  RegistrationViewModel.swift
//  GameSetMatch
//
//  Created by renks on 15/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableisRegistering = Bindable<Bool>()
    var bindableIsFormValid = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        bindableisRegistering.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let err = err {
                completion(err)
                return
            }
            print("Sucessfully registered user:", res?.user.uid ?? "")
            self.saveImageToFirebase(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        let filename = UUID.init().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        ref.putData(imageData, metadata: nil) { (_, err) in
            
            if let err = err {
                completion(err)
                return
            }
            print("Finished uploading image to storage")
            ref.downloadURL { (url, err) in
                if let err = err {
                    completion(err )
                    return
                }
                self.bindableisRegistering.value = false
                print("Download url of our image:", url?.absoluteString ?? "")
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFireStore(imageUrl: imageUrl, completion: completion)
            }
        }
    }
    
    fileprivate func saveInfoToFireStore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName": fullName ?? "", "uid": uid, "imageUrl1": imageUrl]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            if let err = err {
                completion(err)
                return
            }
            completion(nil)
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
}
