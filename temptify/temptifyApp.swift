//
//  temptifyApp.swift
//  temptify
//
//  Created by mason on 2023-02-08.
//

import SwiftUI

@main
struct temptifyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private let center = UNUserNotificationCenter.current()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        center.delegate = self
        if launchOptions?[UIApplication.LaunchOptionsKey.localNotification] is UILocalNotification {
            // do anything you want update UIViewController, etc
            print("notification pressed")
        }
        return true
    }
}
