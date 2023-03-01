import SwiftUI
import UserNotifications

class ModalHandler: ObservableObject{
    static let shared = ModalHandler()
    @Published var showModal: Bool = false
}
class TemptingApp: ObservableObject {
    @Published var appName: String
    
    init(appName: String) {
        self.appName = appName
    }
}

struct ContentView: View {
    //all time counters
    @State private var notifSentTotal = UserDefaults.standard.integer(forKey: "notifSentTotal")
    @State private var notifSuccumbedTotal = UserDefaults.standard.integer(forKey: "notifSuccumbedTotal")
    @State private var notifResistedTotal = UserDefaults.standard.integer(forKey: "notifResistedTotal")
    
    @State private var notifSentDaily = UserDefaults.standard.integer(forKey: "notifSentDaily")
    @State private var notifSuccumbedDaily = UserDefaults.standard.integer(forKey: "notifSuccumbedDaily")
    @State private var notifResistedDaily = UserDefaults.standard.integer(forKey: "notifResistedDaily")
    @State private var lastOpened = UserDefaults.standard.string(forKey: "lastOpened")

    @ObservedObject var temptingApp: TemptingApp = TemptingApp(appName: "Instagram")
    let appList = ["Tiktok", "Instagram", "Facebook", "Twitter", "WhatsApp", "Snapchat","WeChat","Gmail","Outlook","Reddit"]
    @State var selectedApp: String = ""
    
    @ObservedObject var modalHandler = ModalHandler.shared
    private let center = UNUserNotificationCenter.current()
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 10){
                Spacer()
                Image("logo").resizable().scaledToFit().cornerRadius(5).padding(.bottom, 50)
                Text("Resisting Instagram").font(.title).bold().italic().underline()
                Text("TODAY'S COUNTER").font(.largeTitle)
                Text(DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)).font(.title)
            }
            VStack (spacing: 10) {
                Text("Attempts: \(notifSentDaily) times")
                Text("Succumbed: \(notifSuccumbedDaily) times  (\(notifSentDaily == 0 ? "0.0" : String(format:"%.1f",(Double(notifSuccumbedDaily)/Double(notifSentDaily)*100)))%)")
                Text("Resisted: \(notifResistedDaily) times  (\(notifSentDaily == 0 ? "0.0" : String(format:"%.1f",(Double(notifResistedDaily)/Double(notifSentDaily)*100)))%)")
            }.padding(20)
            VStack (spacing: 10){
                Text("ALL TIME").font(.title)
//                Text("Total Notifications Sent: \(notifSentTotal) ")
//                Text("Total Notifications Succumbed: \(notifSuccumbedTotal)")
//                Text("Total Notifications Resisted: \(notifResistedTotal)")
                Text("Succumbed: \(notifSentTotal == 0 ? "0.0" : String(format:"%.1f", (Double(notifSuccumbedTotal)/Double(notifSentTotal)*100)))%")
                Text("Resisted: \(notifSentTotal == 0 ? "0.0" : String(format:"%.1f", (Double(notifResistedTotal)/Double(notifSentTotal)*100)))%")
                
                Button(action: {
                    self.sendNotification()
                }) {
                    Text("Send Notification")
                }
                .sheet(isPresented: $modalHandler.showModal, content:{ModalView(notifSuccumbedTotal: self.$notifSuccumbedTotal, notifResistedTotal: self.$notifResistedTotal, notifSentDaily: self.$notifSentDaily, notifSuccumbedDaily: self.$notifSuccumbedDaily, notifResistedDaily: self.$notifResistedDaily)})
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
                    VStack {
                        Text("Personalize your Temptify Experience").font(.largeTitle)
                        Text("What app are you trying to use less?")
                        Picker("Select an app", selection: $selectedApp) {
                            ForEach(appList, id: \.self) {
                                app in Text(app)
                            }
                        }.pickerStyle(.wheel)
                        Text("You selected \(selectedApp)")
                    }.onChange(of: selectedApp) {
                        newValue in
                        print("Selected app changed to \(newValue)")
                    }
                    
                } else if (screen.screenName == "Help") {
                    Text("How Does Temptify Work?")
                        .fontWeight(.bold)
                    Text(Constants.helpPageText)
                        .padding()
                    Spacer()
                } else if (screen.screenName == "Feedback") {
                    Text("Help Us Improve")
                        .fontWeight(.bold)
                    VStack{
                        Text(Constants.feedbackPageText)
                            .padding(.bottom)
                        Link(Constants.feedbackPageLink, destination: URL(string: "https://www." + Constants.feedbackPageLink)!)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    Spacer()
                }
            }
        }
    }
    
    private func updateApp(_ app: String) {
        // Update the appName property of your TemptingApp object when the selection changes
        temptingApp.appName = app
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
                UserDefaults.standard.set(notifSentDaily+1, forKey: "notifSentDaily")
                notifSentDaily = UserDefaults.standard.integer(forKey: "notifSentDaily")
            }
        }
    }
}

// Modal view when the user clicks on a notification from app
struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var notifSuccumbedTotal: Int
    @Binding var notifResistedTotal: Int
    @Binding var notifSentDaily: Int
    @Binding var notifSuccumbedDaily: Int
    @Binding var notifResistedDaily: Int
    private func randomFact() -> String?{
            // Randomize fact to show in modal
            let facts = [
              "47% of Americans admit they’re addicted to their phones",
              "The average American checks their smartphone 352 times per day",
              "71% of people spend more time on their phone than with their romantic partner",
              "72% of parents feel their teenagers are distracted by smartphones during in-person conversations",
              "44% of American adults admit that not having their phones gives them anxiety",
              "42% of American adults say they waste too much time on their smartphones",
              "30% of Americans say they’d be more productive without their smartphones",
              "People with smartphone addiction have worse sleep quality than those without",
              "Smartphone addiction correlates with anxiety, depression, and other mental health issues",
              "Cell phones cause over 20% of car accidents",
              "Teenagers who spend 5 hours a day on electronic devices are 71% more likely to have suicide risk factors than those with one-hour use.",
              "Smartphone use and depression are correlated.",
              "Being constantly interrupted by alerts and notifications may be contributing towards a problematic deficit of attention.",
              "33% of teens spend more time socializing with close friends online, rather than face-to-face."
            ]
            
            let fact = facts.randomElement()
            return fact
        }
    var body: some View {
        VStack {
            Text("TAKE A SECOND...").font(.largeTitle)
            Text("This is attempt # \(notifSentDaily) to open \("Instagram") today.")
            Text("DID YOU KNOW?").font(.title).padding()
            Text(randomFact()!)
            
            Text("What can I do instead?")    .multilineTextAlignment(.center)
                .frame(width: 200, height: 100)
            
            Button(action: {
                // increment total counter
                UserDefaults.standard.set(notifSuccumbedTotal+1, forKey: "notifSuccumbedTotal")
                notifSuccumbedTotal = UserDefaults.standard.integer(forKey: "notifSuccumbedTotal")
                // increment daily counter
                UserDefaults.standard.set(notifSuccumbedDaily+1, forKey: "notifSuccumbedDaily")
                notifSuccumbedDaily = UserDefaults.standard.integer(forKey: "notifSuccumbedDaily")
                // action
                self.deepLink(app: "Instagram")
            }) {
                Text("Continue to Instagram")
            }.padding()
                .buttonStyle(.bordered)
                .clipShape(Capsule())
            Button(action: {
                // increment total counter
                UserDefaults.standard.set(notifResistedTotal+1, forKey: "notifResistedTotal")
                notifResistedTotal = UserDefaults.standard.integer(forKey: "notifResistedTotal")
                // increment daily counter
                UserDefaults.standard.set(notifResistedDaily+1, forKey: "notifResistedDaily")
                notifResistedDaily = UserDefaults.standard.integer(forKey: "notifResistedDaily")
                // action
                self.dismissModal()
            }) {
                Text("I don't want to open Instagram")
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
