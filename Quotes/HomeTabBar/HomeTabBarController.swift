//
//  HomeTabBarController.swift
//  QuotesApp
//
//  Created by Doni Silva on 26/08/24.
//

import UIKit

public class HomeTabBarController: UITabBarController {
    
    private enum Constants {
        static let quotesImage = "quotes"
        static let quotesTitle = "quotesTitle".localized
        static let settingsImage = "settings"
        static let settingsTitle = "settingsTitle".localized
        static let tabBarBorder: CGFloat = 0.5
        static let tabBarCornerRadius: CGFloat = 15
    }
    
    private let quotesViewController = QuotesViewController()
    private let settingsViewController = SettingsViewController()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, CustomTabBar.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = true
        tabBar.tintColor = .appPrimary
        tabBar.barTintColor = .appPrimary
        tabBar.backgroundColor = .white
        
        tabBar.layer.borderWidth = Constants.tabBarBorder
        tabBar.layer.borderColor = UIColor.appPrimary.cgColor
        tabBar.layer.cornerRadius = Constants.tabBarCornerRadius
        tabBar.clipsToBounds = true
        
        quotesViewController.setTabBarImage(imageName: Constants.quotesImage, 
                                            title: Constants.quotesTitle)
        settingsViewController.setTabBarImage(imageName: Constants.settingsImage, 
                                              title: Constants.settingsTitle)
        setViewControllers([quotesViewController, settingsViewController], animated: true)
    }
}

fileprivate class CustomTabBar: UITabBar {
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 95
        return sizeThatFits
    }
}

