//
//  MatchesHeader.swift
//  GameSetMatch
//
//  Created by renks on 26/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import LBTATools

class MatchesHeader: UICollectionReusableView {
    
    let newMatchesLabel = UILabel(text: "New Matches", font: .boldSystemFont(ofSize: 14), textColor: #colorLiteral(red: 1, green: 0.4424606562, blue: 0.4643346667, alpha: 1))
    
    let matchesHorizontalController = MatchesHorizontalController()
    
    let messagesLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 14), textColor: #colorLiteral(red: 1, green: 0.4424606562, blue: 0.4643346667, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(stack(newMatchesLabel).padLeft(16),
              matchesHorizontalController.view,
              stack(messagesLabel).padLeft(16),
              spacing: 20).withMargins(.init(top: 20, left: 0, bottom: 8, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
