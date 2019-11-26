//
//  CustomInputAcessoryView.swift
//  GameSetMatch
//
//  Created by renks on 25/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import LBTATools

class CustomInputAcessoryView: UIView {
    
    let textView = UITextView()
    let sendButton = UIButton(title: "Send", titleColor: .black, font: .systemFont(ofSize: 16), backgroundColor: .white, target: nil, action: nil)
    
    let placeholderLabel = UILabel(text: "Enter Message", font: .systemFont(ofSize: 16), textColor: .lightGray, textAlignment: .left)
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupShadow(opacity: 0.15, radius: 8, offset: .init(width: 0, height: -8), color: .lightGray)
        autoresizingMask = .flexibleHeight
        
        textView.text = ""
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 16)
        sendButton.isEnabled = false
        sendButton.setTitleColor(.lightGray, for: .disabled)
        sendButton.setTitleColor(#colorLiteral(red: 0.08545408398, green: 0.5945304314, blue: 0.9986578822, alpha: 1), for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
        
        hstack(textView,
               sendButton.withSize(.init(width: 60, height: 60)),
               alignment: .center
        ).withMargins(.init(top: 0, left: 16, bottom: 0, right: 16))
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: sendButton.leadingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        placeholderLabel.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor).isActive = true
    }
    
    @objc fileprivate func handleTextChange() {
        placeholderLabel.isHidden = textView.text.count != 0
        sendButton.isEnabled = textView.text.count != 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
