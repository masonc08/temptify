//
//  ContentView.swift
//  temptify
//
//  Created by mason on 2023-02-08.
//

import SwiftUI

struct ContentView: View {
//    let button: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .white
//        button.setTitle("Title", for: .normal)
//        return button
//    }()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Temptify")
        }
        .padding()
        Button("Request Authorization", action: g)
        Button("Turn on Notification", action: f)
//        button
    }
    func g() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                // Handle the error here.
            }
            
            // Enable or disable features based on the authorization.
        }
    }
    func f() {
        let center = UNUserNotificationCenter.current()
        let content =
        UNMutableNotificationContent()
        content.title = "Don't miss out!"
        content.body = "Instagram is calling your name right now! Check it out now."
        content.sound = UNNotificationSound.default
        content.userInfo = ["app": "Instagram"]
        
        //create dateComponents for lunch time
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 13
        
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
//    body.addSubview(button)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
