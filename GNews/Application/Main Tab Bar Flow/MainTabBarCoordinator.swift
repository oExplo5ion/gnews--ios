//
//  MainTabBarCoordinator.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import Foundation
import UIKit

class MainTabBarCoordinator: BaseCoordinator {
    
    // MARK: - Proporties
    private let router: MainTabBarRouter
    private let factory = MainTabBarFactory()
    
    // MARK: - Init
    init(router: MainTabBarRouter) {
        self.router = router
    }
    
    // MARK: - Funcs
    func start() {
        guard let tabBarVC = router.rootViewController?.viewControllers.first as? UITabBarController else { return }
        
        var tabBarItems = [(UITabBarItem,UIViewController)]()
        
        tabBarItems.append(makeHomeItem())
        tabBarItems.append(makeNewsItem())
        tabBarItems.append(makeSearchItem())
        tabBarItems.append(makeProfileItem())
        tabBarItems.append(makeMoreItem())
        
        var vcs = [UIViewController]()
        tabBarItems.forEach { (item, vc) in
            vc.tabBarItem = item
            vcs.append(vc)
        }
        
        tabBarVC.setViewControllers(vcs, animated: true)
        tabBarVC.selectedIndex = 2
    }
    
    func makeHomeItem() -> (UITabBarItem, UIViewController) {
        let rootVC = GNNavigationController(rootViewController: BaseViewController())
        let coordinator = factory.makeHomeCoordinator(rootViewController: rootVC)
        
        addDependency(coordinator: coordinator)
        coordinator.start()
        
        let item = UITabBarItem(
            title: Text.home,
            image: Image.icHome.withRenderingMode(.alwaysOriginal),
            selectedImage: Image.icHome.withRenderingMode(.alwaysTemplate).withTintColor(Color._F78F54)
        )
        rootVC.tabBarItem = item
        return (item,rootVC)
    }
    
    func makeNewsItem() -> (UITabBarItem, UIViewController) {
        let vc = NewsViewController()
        vc.onRequestShow = { article in
            guard let url = URL(string: article.url ?? "") else { return }
            self.showWebView(url: url)
        }
        let rootVC = GNNavigationController(rootViewController: vc)
        let coordinator = factory.makeNewsCoordanitator(rootViewController: rootVC)
        
        addDependency(coordinator: coordinator)
        coordinator.start()
        
        let item = UITabBarItem(
            title: Text.news,
            image: Image.icNews.withRenderingMode(.alwaysOriginal),
            selectedImage: Image.icNews.withRenderingMode(.alwaysTemplate).withTintColor(Color._F78F54)
        )
        rootVC.tabBarItem = item
        return (item,rootVC)
    }
    
    func makeSearchItem() -> (UITabBarItem, UIViewController) {
        let rootVC = GNNavigationController(rootViewController: SearchViewController(), color: .white)
        let coordinator = factory.makeSearchCoordinator(rootViewController: rootVC)
        coordinator.onRequestShow = { article in
            guard let url = URL(string: article.url ?? "") else { return }
            self.showWebView(url: url)
        }
        
        addDependency(coordinator: coordinator)
        coordinator.start()
        
        let item = UITabBarItem(
            title: Text.search,
            image: Image.icSearch.withRenderingMode(.alwaysOriginal),
            selectedImage: Image.icSearch.withRenderingMode(.alwaysTemplate).withTintColor(Color._F78F54)
        )
        rootVC.tabBarItem = item
        return (item,rootVC)
    }
    
    func makeProfileItem() -> (UITabBarItem, UIViewController) {
        let rootVC = GNNavigationController(rootViewController: BaseViewController())
        let coordinator = factory.makeProfileCoordinator(rootViewController: rootVC)
        
        addDependency(coordinator: coordinator)
        coordinator.start()
        
        let item = UITabBarItem(
            title: Text.profile,
            image: Image.icSettingsPersonal.withRenderingMode(.alwaysOriginal),
            selectedImage: Image.icSettingsPersonal.withRenderingMode(.alwaysTemplate).withTintColor(Color._F78F54)
        )
        rootVC.tabBarItem = item
        return (item,rootVC)
    }
    
    func makeMoreItem() -> (UITabBarItem, UIViewController) {
        let rootVC = GNNavigationController(rootViewController: BaseViewController())
        let coordinator = factory.makeMoreCoordinator(rootViewController: rootVC)
        
        addDependency(coordinator: coordinator)
        coordinator.start()
        
        let item = UITabBarItem(
            title: Text.more,
            image: Image.icMore.withRenderingMode(.alwaysOriginal),
            selectedImage: Image.icMore.withRenderingMode(.alwaysTemplate).withTintColor(Color._F78F54)
        )
        rootVC.tabBarItem = item
        return (item,rootVC)
    }
    
    func showWebView(url: URL) {
        let vc = factory.makeWebViewViewController(url: url)
        router.present(vc)
    }
    
}
