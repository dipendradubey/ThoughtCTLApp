//
//  AppDelegate.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 16/12/23.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
           let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
           sceneConfig.delegateClass = SceneDelegate.self
           return sceneConfig
       }
}
