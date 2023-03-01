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
    private let modalHandler = ModalHandler.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        center.delegate = self
       
        // refresh daily counter if needed
        let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        if today != UserDefaults.standard.string(forKey: "lastOpened"){
            UserDefaults.standard.set(0, forKey: "notifResistedDaily")
            UserDefaults.standard.set(0, forKey: "notifSentDaily")
            UserDefaults.standard.set(0, forKey: "notifSuccumbedDaily")
            UserDefaults.standard.set(today, forKey: "lastOpened")
        }
        
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        modalHandler.showModal = true
        print("A notification has been clicked")
    }
}
