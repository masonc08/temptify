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
    private let dailyCounterHandler = DailyCounterHandler.shared
    
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
        if today != dailyCounterHandler.lastOpened {
            dailyCounterHandler.notifResistedDaily = 0
            dailyCounterHandler.notifSuccumbedDaily = 0
            dailyCounterHandler.notifSentDaily = 0
            dailyCounterHandler.lastOpened = today
        }
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        modalHandler.showModal = true
        //let contentView = ContentView(modalHandler: modalHandler)
        print("A notification has been clicked")
    }
}
