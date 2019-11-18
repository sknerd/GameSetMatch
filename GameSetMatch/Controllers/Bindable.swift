//
//  Bindable.swift
//  GameSetMatch
//
//  Created by renks on 17/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
