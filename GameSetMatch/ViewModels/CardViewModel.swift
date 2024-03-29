//
//  CardViewModel.swift
//  GameSetMatch
//
//  Created by renks on 14/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit

protocol PoducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    
    let uid: String
    let imageUrls: [String]
    let attributedText: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(uid: String, imageNames: [String], attributedText: NSAttributedString, textAlignment: NSTextAlignment) {
        self.uid = uid
        self.imageUrls = imageNames
        self.attributedText = attributedText
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageUrl = imageUrls[imageIndex]
            imageIndexObserver?(imageIndex, imageUrl)
        }
    }
    
    //Reactive Programming
    var imageIndexObserver: ((Int, String?) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageUrls.count - 1)
    }
    
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}



