//
//  MainTabViewController.swift
//  GithubDummy
//
//  Created by MacBook AIR on 25/09/2024.
//

import UIKit
class MainTabViewController: UITabBarController {

    let networkManager: NetworkManager = NetworkManager.shared

    lazy var vc1: HomeViewController = {
        return HomeViewController(networkManager: networkManager)
    }()

    lazy var vc2: FavoritesViewController = {
      return FavoritesViewController(networkManager: networkManager)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSetupTabbarViewController()
    }

    private func configureSetupTabbarViewController() {
       

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)

        nav1.tabBarItem = UITabBarItem(title: "Github Followers", image: UIImage(systemName: "person.circle"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star.fill"), tag: 1)

        nav1.navigationBar.backgroundColor = .clear
        nav1.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav1.navigationBar.shadowImage = UIImage()
        setViewControllers([nav1, nav2], animated: false)
    }
}
