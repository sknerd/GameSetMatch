//
//  SwipingPhotosController.swift
//  GameSetMatch
//
//  Created by renks on 19/11/2019.
//  Copyright © 2019 Renald Renks. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var cardViewModel: CardViewModel! {
        didSet {
            print(cardViewModel.attributedText)
            controllers = cardViewModel.imageUrls.map({ (imageUrl) -> UIViewController in
                let photoController = PhotoController(imageUrl: imageUrl)
                return photoController
            })
            setViewControllers([controllers.first!], direction: .forward, animated: true)
            
            setupBarViews()
        }
    }
    
    fileprivate let barsStackView = UIStackView(arrangedSubviews: [])
    fileprivate let deselectedBarColor = UIColor(white: 0, alpha: 0.2)
    fileprivate let transparentColor = UIColor(white: 0, alpha: 0)
    
    fileprivate func setupBarViews() {
        
        cardViewModel.imageUrls.forEach { (_) in
            let barView = UIView()
            barsStackView.backgroundColor = deselectedBarColor
            barView.layer.cornerRadius = 2
            barsStackView.addArrangedSubview(barView)
        }
        barsStackView.arrangedSubviews.first?.backgroundColor = .white
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
        
        view.addSubview(barsStackView)
        
        if barsStackView.arrangedSubviews.count > 1 {
            barsStackView.isHidden = false
        } else {
            barsStackView.isHidden = true
        }
        
        
        /* // include this for devices with the notch
         var paddingTop: CGFloat = 8
         if !isCardViewMode {
         paddingTop += UIApplication.shared.statusBarFrame.height + 8
         }
         */
        
        barsStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 6, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 3))
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let currentPhotoController = viewControllers?.first
        
        if let index = controllers.firstIndex(where: { $0 == currentPhotoController }) {
            
            barsStackView.arrangedSubviews.forEach({ $0.backgroundColor = deselectedBarColor })
            barsStackView.arrangedSubviews[index].backgroundColor = .white
            
        }
    }
    
    var controllers = [UIViewController]()
    
    fileprivate let isCardViewMode: Bool
    
    init(isCardViewMode: Bool = false) {
        self.isCardViewMode = isCardViewMode
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.backgroundColor = .white
        
        if isCardViewMode {
            disableSwipingAbility()
        }
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let currentController = viewControllers!.first!
        if let index = controllers.firstIndex(of: currentController) {
            barsStackView.arrangedSubviews.forEach({ $0.backgroundColor = deselectedBarColor })
            if gesture.location(in: self.view).x > view.frame.width / 1.5 {
                let nextIndex = min(index + 1, controllers.count - 1)
                let nextController = controllers[nextIndex]
                setViewControllers([nextController], direction: .forward, animated: false)
                barsStackView.arrangedSubviews[nextIndex].backgroundColor = .white
            } else if gesture.location(in: self.view).x < view.frame.width / 3 {
                let previousIndex = max(0, index - 1)
                let previousController = controllers[previousIndex]
                setViewControllers([previousController], direction: .forward, animated: false)
                barsStackView.arrangedSubviews[previousIndex].backgroundColor = .white
            } else {
                print("Need to implement delegating to show UserDetailsController")
            }
        }
    }
    
    fileprivate func disableSwipingAbility() {
        view.subviews.forEach { (v) in
            if let v = v as? UIScrollView {
                v.isScrollEnabled = false
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index = self.controllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = self.controllers.firstIndex(where: { $0 == viewController }) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
}
