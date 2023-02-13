import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var notificationsSent = UserDefaults.standard.integer(forKey: "notificationsSent")
    private let center = UNUserNotificationCenter.current()
    
    var body: some View {
        VStack {
            Text("Notifications Sent: \(notificationsSent)")
            Button(action: {
                self.sendNotification()
            }) {
                Text("Send Notification")
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
                UserDefaults.standard.set(notificationsSent+1, forKey: "notificationsSent")
                notificationsSent = UserDefaults.standard.integer(forKey: "notificationsSent")
                print("Notification sent successfully")
            }
        }
    }
}
