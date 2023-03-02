import SwiftUI
import UserNotifications

class ModalHandler: ObservableObject{
    static let shared = ModalHandler()
    @Published var showModal: Bool = false
}
class TemptingApp: ObservableObject {
    static let shared = TemptingApp()
    @Published var appName: String
    init(appName: String="Instagram") {
        self.appName = appName
    }
}

struct ContentView: View {
    //all time counters
    @State private var notifSentTotal = UserDefaults.standard.integer(forKey: "notifSentTotal")
    @State private var notifSuccumbedTotal = UserDefaults.standard.integer(forKey: "notifSuccumbedTotal")
    @State private var notifResistedTotal = UserDefaults.standard.integer(forKey: "notifResistedTotal")
    
    //daily counters
    @State private var notifSentDaily = UserDefaults.standard.integer(forKey: "notifSentDaily")
    @State private var notifSuccumbedDaily = UserDefaults.standard.integer(forKey: "notifSuccumbedDaily")
    @State private var notifResistedDaily = UserDefaults.standard.integer(forKey: "notifResistedDaily")
    @State private var lastOpened = UserDefaults.standard.string(forKey: "lastOpened")
    
    @State private var skipOnboarding = UserDefaults.standard.bool( forKey: "skipOnboarding")

    @ObservedObject var temptingApp: TemptingApp = TemptingApp(appName: "Instagram")
    @State var selectedApp: String = ""
    
    @ObservedObject var modalHandler = ModalHandler.shared
    private let center = UNUserNotificationCenter.current()
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 10){
                Spacer()
                Image("TransparentLogoText").resizable().scaledToFit().cornerRadius(10).padding(.bottom, 50)
                Text("Resisting \(selectedApp)").font(.title).bold().italic().underline()
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
                Text("Succumbed: \(notifSentTotal == 0 ? "0.0" : String(format:"%.1f", (Double(notifSuccumbedTotal)/Double(notifSentTotal)*100)))%")
                Text("Resisted: \(notifSentTotal == 0 ? "0.0" : String(format:"%.1f", (Double(notifResistedTotal)/Double(notifSentTotal)*100)))%")
                .sheet(isPresented: $modalHandler.showModal, content:{ModalView(
                    notifSuccumbedTotal: self.$notifSuccumbedTotal,
                    notifResistedTotal: self.$notifResistedTotal,
                    notifSentDaily: self.$notifSentDaily,
                    notifSuccumbedDaily: self.$notifSuccumbedDaily,
                    notifResistedDaily: self.$notifResistedDaily,
                    selectedApp: $selectedApp)})
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
                            ForEach(Constants.appList, id: \.self) {
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
            // onboarding modal only shows upon first launch
            .sheet(isPresented:Binding<Bool>(get: {!skipOnboarding},
                                            set: { skipOnboarding = !$0}),
                   content:{OnboardingView(skipOnboarding: self.$skipOnboarding, selectedApp: self.$selectedApp)})
        }
    }
    
    private func updateApp(_ app: String) {
        // Update the appName property of your TemptingApp object when the selection changes
        temptingApp.appName = app
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
    @Binding var selectedApp: String
    private func randomFact() -> String?{
        // Randomize fact to show in modal
        let fact = Constants.facts.randomElement()
        return fact
    }
    var body: some View {
        VStack {
            Text("TAKE A SECOND...").font(.largeTitle)
            Text("This is attempt # \(notifSentDaily) to open \(selectedApp) today.")
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
                self.deepLink(app: selectedApp)
            }) {
                Text("Continue to \(selectedApp)")
            }.padding()
                .buttonStyle(.bordered)
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
                Text("I don't want to open \(selectedApp)")
            }
        }
    }
    private func deepLink(app: String) {
        presentationMode.wrappedValue.dismiss()
        print("opening app...")
        let url = URL(string: "\(app.lowercased())://")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)

    }
    private func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct Screen: Hashable {
    let screenName: String
}

// modal view for onboarding screen that only shows the first time an user opens the app
struct OnboardingView: View {
    @Binding var skipOnboarding: Bool
    @Binding var selectedApp: String
    var body: some View {
        NavigationStack {
            VStack (spacing: 10){
                //Spacer()
                Image("TransparentLogoText").resizable().scaledToFit().cornerRadius(10).padding(.top, 30)
                Text("Are notifications getting a little too tempting for you?").font(.title3).padding(.top, 50).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true).padding(.horizontal, 10)
                Text("Start improving your self control today!").font(.title3).padding(10)
                //Spacer()
            }
            VStack (spacing: 20){
                Spacer()
                NavigationLink(value: Screen(screenName: "Help")) {
                    Text("Help")
                }
                NavigationLink(value: Screen(screenName: "Settings")) {
                    Text("Settings")
                }
                NavigationLink(value: Screen(screenName: "Feedback")) {
                    Text("Feedback")
                }
                Spacer()
            }
            .navigationDestination(for: Screen.self) { screen in
                if (screen.screenName == "Settings") {
                    VStack {
                        Text("Personalize your Temptify Experience").font(.largeTitle)
                        Text("What app are you trying to use less?")
                        Picker("Select an app", selection: $selectedApp) {
                            ForEach(Constants.appList, id: \.self) {
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
            VStack (spacing: 10) {
                Spacer()
                Button(action: {
                    updateFlag()
                }) {
                    Text("GO!").font(.title)
                }.buttonStyle(.bordered)
            }
        }
    }
    
    private func updateFlag(){
        UserDefaults.standard.set(true, forKey: "skipOnboarding")
        skipOnboarding = UserDefaults.standard.bool( forKey: "skipOnboarding")
    }
}
