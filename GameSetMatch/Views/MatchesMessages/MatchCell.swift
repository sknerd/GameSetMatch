//
//  MatchCell.swift
//  GameSetMatch
//
//  Created by renks on 25/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import LBTATools

class MatchCell: LBTAListCell<Match> {
    
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "olya1"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "Username Here", font: .systemFont(ofSize: 14, weight: .semibold), textColor: #colorLiteral(red: 0.3456445932, green: 0.3459315896, blue: 0.3456890583, alpha: 1), textAlignment: .center, numberOfLines: 1)
    
    override var item: Match! {
        didSet {
            usernameLabel.text = item.name
            profileImageView.sd_setImage(with: URL(string: item.profileImageUrl))
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        profileImageView.clipsToBounds = true
        profileImageView.constrainWidth(75)
        profileImageView.constrainHeight(75)
        profileImageView.layer.cornerRadius = 75 / 2
        stack(stack(profileImageView, alignment: .center),
              usernameLabel).withMargins(.init(top: 0, left: 0, bottom: 0, right: 0))
    }
}
