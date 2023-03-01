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
        NavigationStack {
            VStack {
                Spacer()
                Text("Notifications Sent: \(notificationsSent)")
                Button(action: {
                    self.sendNotification()
                }) {
                    Text("Send Notification")
                }
                .sheet(isPresented: $modalHandler.showModal, content: {ModalView()})
                Spacer()
            }
            HStack {
                NavigationLink(value: Screen(screenName: "Help")) {
                    Text("Help")
                }
                NavigationLink(value: Screen(screenName: "Settings")) {
                    Text("Settings")
                }
                NavigationLink(value: Screen(screenName: "Feedback")) {
                    Text("Feedback")
                }
            }
            .navigationDestination(for: Screen.self) { screen in
                if (screen.screenName == "Settings") {
                    Text("Personalize your Temptify Experience")
                } else if (screen.screenName == "Help") {
                    Text("How Does Temptify Work?")
                } else if (screen.screenName == "Feedback") {
                    Text("Help Us Improve")
                }
            }
        }
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
                       
        // Randomize content of notification
        let rand = Int.random(in: 0...2)
        let randTitle = ["rand=0", "rand=1", "rand=2"]
        let randBody = ["ig is calling u", "checkout reelzz", "someone unfollowed u..."]
               
        content.title = randTitle[rand]
        content.body = randBody[rand]
               
        // Randomize the trigger time for the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double.random(in: 5...30), repeats: false)
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

struct Screen: Hashable {
    let screenName: String
}
