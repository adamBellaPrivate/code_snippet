//
//  MainTabBarViewController.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit

protocol CustomTabBarItemProtocol {
    var customTabBarItem: UITabBarItem { get }
    var shouldUseNavigationController: Bool { get }
}

private protocol TabBarItemsAppearanceProtocol {
    func setupTabs(from controllers: [UIViewController & CustomTabBarItemProtocol]) -> [UIViewController]
}

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = setupTabs(from: [ExploreViewController(), SearchViewController(), ProfileViewController()])
        setupAppearance()
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension MainTabBarViewController: TabBarItemsAppearanceProtocol {
    final func setupAppearance() {
        tabBar.layer.shadowColor = AppTheme.tabBarShadow.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.masksToBounds = false
    }

    final func setupTabs(from controllers: [UIViewController & CustomTabBarItemProtocol]) -> [UIViewController] {
        controllers.forEach({
            $0.tabBarItem = $0.customTabBarItem
            $0.tabBarItem.title = .none
            $0.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        })
        return controllers.sorted(by: {$0.tabBarItem.tag < $1.tabBarItem.tag}).compactMap {
            guard $0.shouldUseNavigationController else { return $0}
            return UINavigationController(rootViewController: $0)
        }
    }
}
