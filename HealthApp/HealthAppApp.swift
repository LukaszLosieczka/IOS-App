//
//  HealthAppApp.swift
//  HealthApp
//
//  Created by Łukasz on 04/11/2021.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey:Any]?=nil)->Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct HealthAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppContentView()
        }
    }
}

