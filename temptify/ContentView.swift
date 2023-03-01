import SwiftUI
import UserNotifications

class ModalHandler: ObservableObject{
    static let shared = ModalHandler()
    @Published var showModal: Bool = false
}

class DailyCounterHandler: ObservableObject{
    static let shared = DailyCounterHandler()
    @Published var notifSentDaily: Int = 0
    @Published var notifSuccumbedDaily: Int = 0
    @Published var notifResistedDaily: Int = 0
    @Published var lastOpened: String = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
}

struct ContentView: View {
    //all time counters
    @State private var notifSentTotal = UserDefaults.standard.integer(forKey: "notifSentTotal")
    @State private var notifSuccumbedTotal = UserDefaults.standard.integer(forKey: "notifSuccumbedTotal")
    @State private var notifResistedTotal = UserDefaults.standard.integer(forKey: "notifResistedTotal")
    
    @ObservedObject var modalHandler = ModalHandler.shared
    private let dailyCounterHandler = DailyCounterHandler.shared
    private let center = UNUserNotificationCenter.current()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Total Notifications Sent: \(notifSentTotal) ")
                Text("Total Notifications Succumbed: \(notifSuccumbedTotal)")
                Text("Total Notifications Resisted: \(notifResistedTotal)")
                
                Text("Daily Notifications Sent: \(dailyCounterHandler.notifSentDaily)")
                Text("Daily Notifications Succumbed: \(dailyCounterHandler.notifSuccumbedDaily)")
                Text("Daily Notifications Resisted: \(dailyCounterHandler.notifResistedDaily)")
                Button(action: {
                    self.sendNotification()
                }) {
                    Text("Send Notification")
                }
                .sheet(isPresented: $modalHandler.showModal, content:{ModalView(notifSuccumbedTotal: self.$notifSuccumbedTotal, notifResistedTotal: self.$notifResistedTotal)})
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
                UserDefaults.standard.set(notifSentTotal+1, forKey: "notifSentTotal")
                notifSentTotal = UserDefaults.standard.integer(forKey: "notifSentTotal")
                print("Notification sent successfully")
                dailyCounterHandler.notifSentDaily = dailyCounterHandler.notifSentDaily + 1
            }
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var notifSuccumbedTotal: Int
    @Binding var notifResistedTotal: Int
    private let dailyCounterHandler = DailyCounterHandler.shared
    var body: some View {
        VStack {
            Text("Are you sure you want to open Instagram?")
            Button(action: {
                // increment total counter
                UserDefaults.standard.set(notifSuccumbedTotal+1, forKey: "notifSuccumbedTotal")
                notifSuccumbedTotal = UserDefaults.standard.integer(forKey: "notifSuccumbedTotal")
                // increment daily counter
                dailyCounterHandler.notifSuccumbedDaily = dailyCounterHandler.notifSuccumbedDaily + 1
                // action
                self.deepLink(app: "Instagram")
            }) {
                Text("Take me there")
            }
            Button(action: {
                // increment total counter
                UserDefaults.standard.set(notifResistedTotal+1, forKey: "notifResistedTotal")
                notifResistedTotal = UserDefaults.standard.integer(forKey: "notifResistedTotal")
                // increment daily counter
                dailyCounterHandler.notifResistedDaily = dailyCounterHandler.notifResistedDaily + 1
                // action
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
