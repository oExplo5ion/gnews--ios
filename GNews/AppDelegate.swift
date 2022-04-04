//
//  AppDelegate.swift
//  GNews
//
//  Created by Aleksey on 31.03.2022.
//

import UIKit
import Unrealm

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? {
        didSet {
            if #available(iOS 13.0, *) {
                self.window?.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    var coordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupRealm()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = ApplicationCoordinator(window: window!)
        coordinator?.start()
        
        return true
    }
    
    private func setupRealm() {
        Realm.registerRealmables(Sugesstion.self)
        Realm.registerRealmables(Article.self)
        
        let schemaVersion: UInt64 = 0
        
        let config = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: { _, oldSchemaVersion in
            if oldSchemaVersion < schemaVersion { }
        }, shouldCompactOnLaunch: { (totalBytes, usedBytes) -> Bool in
            let oneHundredMB = 25 * 1024 * 1024
            return (totalBytes > oneHundredMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
        print("Realm path: \(realm.configuration.fileURL!.deletingLastPathComponent().path)")
    }

}

