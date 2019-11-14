//
//  User.swift
//  GameSetMatch
//
//  Created by renks on 13/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit


struct User: PoducesCardViewModel {
    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]
    
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSMutableAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageNames: imageNames, attributedText: attributedText, textAlignment: .left)
    }
    
}
