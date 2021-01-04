//
//  MessaggiAppApp.swift
//  MessaggiApp
//
//  Created by Michele on 02/01/21.
//

import SwiftUI
import Firebase

@main
struct MessaggiAppApp: App {
    @UIApplicationDelegateAdaptor(Delegate.self)var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class Delegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
}
