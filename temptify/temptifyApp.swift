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
            LoadingView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private let center = UNUserNotificationCenter.current()
    private let modalHandler = ModalHandler.shared
    private let temptingApp = TemptingApp.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification permission granted")
                self.schedule_notifications()
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
        self.schedule_notifications()
        return true
    }

    // todo: only runs on first launch since installation rn
    private func schedule_notifications() {
        let content = UNMutableNotificationContent()
        for i in 0...10 {
            let selectedApp = UserDefaults.standard.string(forKey: "selectedApp") ?? "Instagram"
            let notifOptions = Constants.notificationsContent[selectedApp]
            print(selectedApp)
            let count = notifOptions?.count ?? 0
            // Randomize content of notification
            let rand = Int.random(in: 0...(count-1))
            let temptingNotification = notifOptions?[rand] ?? ["title": "Sample notification", "message": "Sample notification text"]
            print(temptingNotification)
            content.title = temptingNotification["title"] ?? ""
            content.body = temptingNotification["message"] ?? ""

            print(temptingNotification)
            content.title = temptingNotification["title"] ?? ""
            content.body = temptingNotification["message"] ?? ""

            // Randomize the trigger time for the notification
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(15+i*60), repeats: false)
            let request = UNNotificationRequest(identifier: "test"+String(i), content: content, trigger: trigger)

            center.add(request) { (error) in
                if error != nil {
                    print("Error sending notification: \(error!.localizedDescription)")
                } else {
                    print("Notification sent successfully on app launch")
                }
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notifSentTotal = UserDefaults.standard.integer(forKey: "notifSentTotal")
        UserDefaults.standard.set(notifSentTotal+1, forKey: "notifSentTotal")
        let notifSentDaily = UserDefaults.standard.integer(forKey: "notifSentDaily")
        UserDefaults.standard.set(notifSentDaily+1, forKey: "notifSentDaily")
        modalHandler.showModal = true
        print("A notification has been clicked")
    }
}
