import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var notificationsSent = 0
    private let center = UNUserNotificationCenter.current()
    
    var body: some View {
        VStack {
            Text("Notifications Sent: \(notificationsSent)")
            
            Button(action: {
                self.requestPermission()
            }) {
                Text("Request Permission")
            }
            
            Button(action: {
                self.sendNotification()
            }) {
                Text("Send Notification")
            }
        }
    }
    
    private func requestPermission() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error != nil {
                print("Error sending notification: \(error!.localizedDescription)")
            } else {
                self.notificationsSent += 1
                print("Notification sent successfully")
            }
        }
    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        notificationsSent += 1
        completionHandler()
    }
}
