//
//  RegistrationViewModel.swift
//  GameSetMatch
//
//  Created by renks on 15/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isformValidObserver?(isFormValid)
    }
    
    // Reactive programming
    var isformValidObserver: ((Bool) -> ())?
}
