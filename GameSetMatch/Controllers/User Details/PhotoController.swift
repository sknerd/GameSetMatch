//
//  PhotoController.swift
//  GameSetMatch
//
//  Created by renks on 20/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {
    
    let imageView = UIImageView()
    
    // provide an initializer that takes in a URL instead
    init(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            imageView.sd_setImage(with: url)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
