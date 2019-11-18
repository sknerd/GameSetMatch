//
//  ViewController.swift
//  GameSetMatch
//
//  Created by renks on 13/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottomControls = HomeBottomControlsStackView()
        
//    let cardViewModels: [CardViewModel] = {
//        let producers = [
//        Advertiser(title: "Be the next hero", brandName: "Reverse Side of the Road", posterPhotoName: "reverse"),
//        User(name: "Alexander", age: 28, profession: "Arts & Science", imageNames: ["boch", "boch1", "boch2", "boch3", "boch4"]),
//        User(name: "Alesya", age: 33, profession: "Muse", imageNames: ["alesya", "alesya1", "alesya2", "alesya3", "alesya4", "alesya5"]),
//        User(name: "Oksana", age: 31, profession: "Weed Smoker", imageNames: ["oksana", "oksana1", "oksana2", "oksana3", "oksana4"]),
//        User(name: "Anna", age: 26, profession: "Scientist", imageNames: ["anna", "anna1", "anna2"]),
//        ] as [PoducesCardViewModel]
//        let viewModels = producers.map({ return $0.toCardViewModel()})
//        return viewModels
//    }()
    
    var cardViewModels = [CardViewModel]() // empty array
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        
        bottomControls.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        
        
        setupLayout()
        setupFirestoreUserCards()
        fetchUsersFromFirestore()
    }
    
    @objc fileprivate func handleRefresh() {
        fetchUsersFromFirestore()
    }
    
    var lastFetchedUser: User?
    
    fileprivate func fetchUsersFromFirestore() {
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Fetching users"
        hud.show(in: view)
        // implementing pagination
        let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastFetchedUser?.uid ?? ""]).limit(to: 5)
        query.getDocuments { (snapshot, err) in
            hud.dismiss()
            if let err = err {
                print("Failed to fetch users", err)
                return
            }
            snapshot?.documents.forEach({ (documentsSnapshot) in
                let userDictionary = documentsSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
                self.lastFetchedUser = user
                self.setupCardFromUser(user: user)
            })
//            self.setupFirestoreUserCards()
        }
    }
    
    fileprivate func setupCardFromUser(user: User) {
        let cardView = CardView()
        cardView.cardViewModel = user.toCardViewModel()
        cardsDeckView.addSubview(cardView)
        cardView.fillSuperview()
    }
    
    @objc func handleSetting() {
        print("Show registration page")
        let registrationController = RegistrationController()
        registrationController.modalPresentationStyle = .fullScreen
        present(registrationController, animated: true)
    }
    
    fileprivate func setupFirestoreUserCards() {
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView()
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardsDeckView.sendSubviewToBack(cardView)
            cardView.fillSuperview()
        }
    }
    
    //MARK:- Fileprivate
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomControls])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        
        //using UIView Extension to anchor
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    
}

