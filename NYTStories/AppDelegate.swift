//
//  AppDelegate.swift
//  NYTStories
//
//  Created by Hesham on 24/09/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let container = DependencyFactory()
        let coordinator = container.makeCoordinator()
        let navigationController = UINavigationController()
        setNavBarAppearance(navigationController)
        coordinator.start(navigationController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    private func setNavBarAppearance(_ navigationController: UINavigationController) {
        navigationController.navigationBar.prefersLargeTitles = true
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .purple
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.compactAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }
        navigationController.navigationBar.tintColor = .white
    }
}

