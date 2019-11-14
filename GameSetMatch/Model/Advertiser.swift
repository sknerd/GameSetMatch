//
//  Advertiser.swift
//  GameSetMatch
//
//  Created by renks on 14/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit

struct Advertiser: PoducesCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "\n\(brandName)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageNames: [posterPhotoName], attributedText: attributedText, textAlignment: .left)
    }
}
