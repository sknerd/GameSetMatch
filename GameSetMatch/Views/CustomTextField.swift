//
//  CustomTextField.swift
//  GameSetMatch
//
//  Created by renks on 15/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    // Setting padding for textfields
    let padding: CGFloat
    let height: CGFloat
    
    init(padding: CGFloat, height: CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        layer.cornerRadius = height / 2
        backgroundColor = .white
        self.autocapitalizationType = .none
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    // Setting preffered size for our textfields
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: height)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
