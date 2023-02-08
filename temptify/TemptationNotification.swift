//
//  TemptationNotification.swift
//  temptify
//
//  Created by mason on 2023-02-08.
//

import Foundation
import UserNotifications

class TemptationNotification {
    let center = UNUserNotificationCenter.current()
//    var blockedApps: [String] = []
    
    func scheduleLunchNotification() {
        // Get the list of blocked apps from user defaults
//        if let blockedApps = UserDefaults.standard.value(forKey: "blockedApps") as? [String] {
//            self.blockedApps = blockedApps
//        }
//
//        if blockedApps.count == 0 {
//            // No blocked apps, don't schedule a notification
//            return
//        }
//
//        // Choose a random blocked app
//        let randomIndex = Int.random(in: 0..<blockedApps.count)
//        let randomApp = blockedApps[randomIndex]
        
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Don't miss out!"
        content.body = "Instagram is calling your name right now! Check it out now."
        content.sound = UNNotificationSound.default
        content.userInfo = ["app": "Instagram"]
        
        //create dateComponents for lunch time
        var dateComponents = DateComponents()
        dateComponents.hour = 14
        dateComponents.minute = 45
        
        // Create the trigger (lunch time every day)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let request = UNNotificationRequest(identifier: "lunchNotification", content: content, trigger: trigger)
        
        // Schedule the notification
        center.add(request) { (error) in
           if let error = error {
               print("Error scheduling notification: \(error)")
           }
        }
    }
}
