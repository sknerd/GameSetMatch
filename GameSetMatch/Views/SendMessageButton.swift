//
//  SendMessageButton.swift
//  GameSetMatch
//
//  Created by renks on 21/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit

class SendMessageButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gradientLayer = CAGradientLayer()
        let leftColor = #colorLiteral(red: 0.9860834479, green: 0.1334367394, blue: 0.4557105899, alpha: 1)
        let rightColor = #colorLiteral(red: 0.9825345874, green: 0.4177262783, blue: 0.2983610928, alpha: 1)
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
        
        gradientLayer.frame = rect
    }
}
