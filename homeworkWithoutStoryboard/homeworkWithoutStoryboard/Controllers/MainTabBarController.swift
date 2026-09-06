//
//  MainTabBarController.swift
//  homeworkWithoutStoryboard
//
//  Created by Lizaveta on 26.08.2026.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearance()
    }
    
    private func setupTabs() {
        // Создаем ViewControllers для каждой вкладки
        let catalogVC = CatalogViewController()
        let cartVC = CartViewController()
        let profileVC = ProfileViewController()
        
        // Оборачиваем в NavigationController для каждой вкладки
        let catalogNav = UINavigationController(rootViewController: catalogVC)
        let cartNav = UINavigationController(rootViewController: cartVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        // Настраиваем заголовки и иконки для вкладок
        catalogVC.title = "Каталог"
        cartVC.title = "Корзина"
        profileVC.title = "Профиль"
        
        catalogVC.tabBarItem = UITabBarItem(
            title: "Каталог",
            image: UIImage(systemName: "square.grid.2x2"),
            selectedImage: UIImage(systemName: "square.grid.2x2.fill")
        )
        
        cartVC.tabBarItem = UITabBarItem(
            title: "Корзина",
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart.fill")
        )
        
        profileVC.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        // Добавляем все вкладки в TabBarController
        viewControllers = [catalogNav, cartNav, profileNav]
    }
    
    private func setupTabBarAppearance() {
        // Настройка внешнего вида TabBar
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .systemBackground
        
        // Для iOS 15+ настройка внешнего вида
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
