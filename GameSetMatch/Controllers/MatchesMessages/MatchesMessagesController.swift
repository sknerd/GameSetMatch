//
//  MatchesMessagesController.swift
//  GameSetMatch
//
//  Created by renks on 22/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import LBTATools
import SDWebImage
import Firebase

struct Match {
    let name, profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}

class MatchCell: LBTAListCell<Match> {
    
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "olya1"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "Username Here", font: .systemFont(ofSize: 14, weight: .semibold), textColor: #colorLiteral(red: 0.3456445932, green: 0.3459315896, blue: 0.3456890583, alpha: 1), textAlignment: .center, numberOfLines: 2)
        
    override var item: Match! {
        didSet {
            usernameLabel.text = item.name
            profileImageView.sd_setImage(with: URL(string: item.profileImageUrl))
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        profileImageView.clipsToBounds = true
        profileImageView.constrainWidth(80)
        profileImageView.constrainHeight(80)
        profileImageView.layer.cornerRadius = 80 / 2
        stack(stack(profileImageView, alignment: .center),
              usernameLabel)
    }
}

class MatchesMessagesController: LBTAListController<MatchCell, Match>, UICollectionViewDelegateFlowLayout {
    
    let customNavBar = MatchesNavBar()
    fileprivate let navBarHeight: CGFloat = 100
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 120)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let match = items[indexPath.item]
        let chatLogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        items = [
//            .init(name: "test", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/gamesetmatchohyeah.appspot.com/o/images%2F907CEFB0-0412-409E-9882-486F26F06561?alt=media&token=8608802f-6576-4736-8b13-4829448e2db9"),
//            .init(name: "1", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/gamesetmatchohyeah.appspot.com/o/images%2F907CEFB0-0412-409E-9882-486F26F06561?alt=media&token=8608802f-6576-4736-8b13-4829448e2db9"),
//            .init(name: "2", profileImageUrl: "profile url"),
//        ]
        
        fetchMatches()
        
        collectionView.backgroundColor = .white
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
        
        collectionView.contentInset.top = navBarHeight
    }
    
    fileprivate func fetchMatches() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("matches_messages").document(currentUserId).collection("matches").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Failed to fetch matches", err)
                return
            }
            
            print("Here are my matches documents:")
            
            var matches = [Match]()
            
            querySnapshot?.documents.forEach({ (documentSnaphot) in
                let dictionary = documentSnaphot.data()
                matches.append(.init(dictionary: dictionary))
            })
            self.items = matches
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}
