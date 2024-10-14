//
//  UIViewController+Ext.swift
//  QuotesApp
//
//  Created by Doni Silva on 26/08/24.
//

import UIKit

extension UIViewController {
    func setTabBarImage(imageName: String, title: String) {
        let image = UIImage(named: imageName)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
