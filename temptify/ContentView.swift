import SwiftUI
import UserNotifications

class ModalHandler: ObservableObject{
    static let shared = ModalHandler()
    @Published var showModal: Bool = false
}

struct ContentView: View {
    @State private var notificationsSent = UserDefaults.standard.integer(forKey: "notificationsSent")
    @ObservedObject var modalHandler = ModalHandler.shared
    private let center = UNUserNotificationCenter.current()
    
    var body: some View {
        VStack {
            Text("Notifications Sent: \(notificationsSent)")
            Button(action: {
                self.sendNotification()
            }) {
                Text("Send Notification")
            }
            .sheet(isPresented: $modalHandler.showModal, content: {ModalView()})
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

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Are you sure you want to open Instagram?")
            Button(action: {
                self.deepLink(app: "Instagram")
            }) {
                Text("Take me there")
            }
            Button(action: {
                self.dismissModal()
            }) {
                Text("Not now")
            }
        }
    }
    private func deepLink(app: String) {
        presentationMode.wrappedValue.dismiss()
        print("opening app...")
        let url = URL(string: "maps://")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)

    }
    private func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
}
