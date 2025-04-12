//
//  MainFactory.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//
import UIKit

final class MainFactory {
    static func buildModule() -> UITabBarController {
        let tabBar = CustomTabBar()
        tabBar.delegate = tabBar
        let vc = MainVC()
        vc.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), tag: 0)
        let vc2 = UIViewController()
        vc2.tabBarItem = UITabBarItem(title: "Empty", image: UIImage(systemName: "trash"), tag: 1)
        let vc3 = UIViewController()
        vc3.tabBarItem = UITabBarItem(title: "Empty", image: UIImage(systemName: "pencil.tip.crop.circle"), tag: 2)
        tabBar.viewControllers = [UINavigationController(rootViewController: MainVC()), vc2, vc3]
        tabBar.selectedIndex = 0
        tabBar.tabBar.backgroundColor = .gray
        return tabBar
    }
}
class CustomTabBar: UITabBarController, UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController == tabBarController.viewControllers?[1] || viewController == tabBarController.viewControllers?[2] {
            return false
        } else {
            return true
        }
    }
}
