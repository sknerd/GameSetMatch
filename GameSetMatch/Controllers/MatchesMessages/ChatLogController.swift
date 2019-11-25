//
//  ChatLogController.swift
//  GameSetMatch
//
//  Created by renks on 24/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import LBTATools

class ChatLogController: LBTAListController<MessageCell, Message>, UICollectionViewDelegateFlowLayout {
    
    fileprivate lazy var customNavBar = MessagesNavBar(match: self.match)
    
    fileprivate let navBarHeight: CGFloat = 100
    
    fileprivate let match: Match
    
    init(match: Match) {
        self.match = match
        super.init()
    }
    
    // input accessory view
    
    class CustomInputAcessoryView: UIView {
        
        let textView = UITextView()
        let sendButton = UIButton(title: "SEND", titleColor: .black, font: .boldSystemFont(ofSize: 14), backgroundColor: .white, target: nil, action: nil)
        
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
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    lazy var redView: UIView = {
        return CustomInputAcessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return redView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.keyboardDismissMode = .interactive
        
        items = [
            .init(text: "Hello fucking whore", isFromCurrentLoggedUser: true),
            .init(text: "Shit piss fuck cunt", isFromCurrentLoggedUser: false),
            .init(text: "Lol", isFromCurrentLoggedUser: false),
            .init(text: "Fucking hoe", isFromCurrentLoggedUser: true),
            .init(text: "Kaya Thomas has always been a voracious reader, yet growing up she rarely came across protagonists who looked like her. “High school was when I started to realize that none of the characters were ever black girls", isFromCurrentLoggedUser: true),
            .init(text: "Kaya Thomas has always been a voracious reader, yet growing up she rarely came across protagonists who looked like her. “High school was when I started to realize that none of the characters were ever black girls", isFromCurrentLoggedUser: false)
        ]
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        collectionView.alwaysBounceVertical = true
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
        
        collectionView.contentInset.top = navBarHeight
        collectionView.verticalScrollIndicatorInsets.top = navBarHeight
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        let statusBarCover = UIView(backgroundColor: .white)
        view.addSubview(statusBarCover)
        statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // estimated sizing for Autoresize cells
        let estimatedSizeCell = MessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        estimatedSizeCell.item = self.items[indexPath.item]
        estimatedSizeCell.layoutIfNeeded()
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
