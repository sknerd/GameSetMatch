//
//  ViewController.swift
//  GameSetMatch
//
//  Created by renks on 13/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottomStackView = HomeBottomControlsStackView()
        
    let cardViewModels: [CardViewModel] = {
        let producers = [
        Advertiser(title: "Be the next hero", brandName: "Reverse Side of the Road", posterPhotoName: "reverse"),
        User(name: "Alexander", age: 28, profession: "Arts & Science", imageNames: ["boch", "boch1", "boch2", "boch3", "boch4"]),
        User(name: "Alesya", age: 33, profession: "Muse", imageNames: ["alesya", "alesya1", "alesya2", "alesya3", "alesya4", "alesya5"]),
        User(name: "Oksana", age: 31, profession: "Weed Smoker", imageNames: ["oksana", "oksana1", "oksana2", "oksana3", "oksana4"]),
        User(name: "Anna", age: 26, profession: "Scientist", imageNames: ["anna", "anna1", "anna2"]),
        ] as [PoducesCardViewModel]
        let viewModels = producers.map({ return $0.toCardViewModel()})
        return viewModels
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        
        setupLayout()
        setupDummyCards()
    }
    
    @objc func handleSetting() {
        print("Show registration page")
        let registrationController = RegistrationController()
        registrationController.modalPresentationStyle = .fullScreen
        present(registrationController, animated: true)
    }
    
    fileprivate func setupDummyCards() {
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    //MARK:- Fileprivate
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        
        //using UIView Extension to anchor
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    
}

