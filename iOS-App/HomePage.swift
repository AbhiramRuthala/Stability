//
//  Account.swift
//  Stability
//
//  Created by Abhiram Ruthala on 11/19/24.
//

import SwiftUI
import CoreML
import Vision
//import AVFoundation

extension UIImage {
    
    // https://www.hackingwithswift.com/whats-new-in-ios-11
    func toCVPixelBuffer() -> CVPixelBuffer? {
           
           let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
             var pixelBuffer : CVPixelBuffer?
             let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
             guard (status == kCVReturnSuccess) else {
               return nil
             }

             CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
             let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

             let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
             let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

             context?.translateBy(x: 0, y: self.size.height)
             context?.scaleBy(x: 1.0, y: -1.0)

             UIGraphicsPushContext(context!)
             self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
             UIGraphicsPopContext()
             CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

             return pixelBuffer
       }
}

//Dude how do you transfer the dataaaaaaaaaaaaa

class MoodHealthRegion: ObservableObject{
    @Published var classLabel: String = ""
}

struct HomePage: View {
    
    
    @State private var showSheet: Bool = false
    
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @State public var classLabel: String = ""
    @State private var inTesting: Bool = false
    @AppStorage("Onboarding") var Onboarding: Bool = true
    @Environment(\.colorScheme) var ColorScheme
    @State private var GradientOpacity: Double = 0.0
    @State private var PersonalizeNotis: Bool = false
    @State var time = Date()
    @State var numbers = 0
    @State private var Reminder: Bool = false
    @State private var TestSubject: Bool = false
    
    
    var gradientColors: [Color] {
        switch classLabel {
        case "Happy":
            return [Color.yellow, Color.clear]
        case "Sad":
            return [Color.blue, Color.clear]
        case "Angry":
            return [Color.red, Color.clear]
        default:
            return [Color.clear, Color.clear]
        }
        
    }
    // @State private var classificationResult: String = ""
    
    var moodClassify: MoodClassification?
    //    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    //    enum FilterType{
    //        case home
    //    }
    //
    //    let filter: FilterType
    //
    //    var title: String {
    //        switch filter {
    //        case .home:
    //            return "Home"
    //        }
    //    }
    
    init() {
        do {
            moodClassify = try MoodClassification(configuration: MLModelConfiguration())
        } catch {
            print(error)
        }
    }
    
    
    
    var body: some View {
   
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                    .opacity(0.45)
                
                
                
                //                    .onAppear{
                //
                //
                //                    }
                
                
                //                if classLabel == "Happy" {
                //                    fadeIn()
                //                } else if classLabel == "Sad"{
                //                    fadeIn()
                //                } else if classLabel == "Angry"{
                //                    fadeIn()
                //                } else {
                //
                //                }
                //                    .onAppear{
                //                        fadeIn()
                //                    }
                
                ScrollView(.vertical){
                    VStack{
                        Text("Welcome to Stability!")
                            .font(.title2)
                            .padding()
                        Text("Here's where you can learn more about your mood and improve your lifestyle")
                            .font(.caption)
                        
                        Image(uiImage: image ?? UIImage(named:"Happiness")!)
                            .resizable()
                            .scaledToFit()
                        
                        //.frame(width: 350, height: 270)
                        
                        
                        HStack{
                            
                            Button("Choose Picture"){
                                self.showSheet = true
                                
                            }.padding()
                                .actionSheet(isPresented: $showSheet) {
                                    ActionSheet(title: Text("Select A Photo"), message: Text("Choose An Option"), buttons: [
                                        .default(Text("Photo Library")){
                                            self.showImagePicker = true
                                            self.sourceType = .photoLibrary
                                        },
                                        .default(Text("Use Camera")){
                                            self.showImagePicker = true
                                            self.sourceType = .camera
                                        },
                                        .cancel()
                                    ])
                                }
                                .buttonStyle(.bordered)
                            //.foregroundColor(.blue)
                                .tint(.blue)
                            //.fontDesign(.serif)
                            //                        if ColorScheme == .dark {
                            //                            .foregroundColor(.red)
                            //                        }
                            Button("Test Image") {
                                
                                //run Bool statement here to remind people to personalize their notifications so that they have a smooth experience after pressing 'Test Image'
                                
                                
                                
                                //self.Reminder = true
                                
                                
                                guard let uiImage = self.image else { return }
                                
                                guard let pixelBuffer = uiImage.toCVPixelBuffer() else { return }
                                
                                //essentially
                                do {
                                    let results = try moodClassify?.prediction(image: pixelBuffer)
                                    classLabel = results?.target ?? ""
                                    
                                } catch {
                                    print(error.localizedDescription)
                                }
                                
                                self.inTesting = true
                                
                                //                                if classLabel == "Happy" {
                                //                                    ZStack{
                                //                                        LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .bottom, endPoint: .top)
                                //                                            .ignoresSafeArea()
                                //                                            .opacity(GradientOpacity)
                                //                                            .onAppear{
                                //                                                fadeIn()
                                //                                            }
                                //                                    }
                                //                                }
                                //check where this should be put
                                addNotis()
                                
                                
                            }
                            .buttonStyle(.bordered)
                            .tint(.blue)
                            //.padding()
                            
                            
                            
                            
                            
                            
                            //                        .sheet(isPresented: $inTesting){
                            //                           //NavigationView{
                            //                               // VStack{
                            //                                    //figure out what to put in this sheet regarding the components that people would need to see!
                            //                            //fix issue of classLabel text not showing up!
                            //                                    Text(classLabel)
                            //                                        .font(.headline)
                            //                                        .fontWeight(.bold)
                            //                                        .padding()
                            //                                    Text("You'll be getting notifications over the day to help you keep your mood healthy!")
                            //                                        .multilineTextAlignment(.center)
                            //                                        .padding()
                            //                                    Text("Thanks for using Stability!")
                            //                                        .padding()
                            //                                        .multilineTextAlignment(.center)
                            //                                        .font(.caption2)
                            //                               // }
                            //
                            //                           // }.navigationBarTitle("Mood Classification Results")
                            //                        }
                            
                            
                            //We CAN RUN WITH THIS IF WE NEED TO ------- THE ALERT DOESNT WORK SO BAD EITHER BUT I WANT TO PRESENT MORE INFO--HENCE THE APPSHEET
                            .alert(isPresented: $inTesting) {
                                Alert(title: Text("Mood Classification Results"), message: Text(classLabel), dismissButton: .default(Text("Thanks!")))
                                
                                
                            }
                            
                            //                            .alert(isPresented: $Reminder){
                            //                                Alert(title: Text("Reminder"), message: Text("Personalize your notifications to have a smooth development experience!"), dismissButton: .default(Text("Thanks!")))
                            //                            }
                            //
                            //                            //showImagePicker == true && self.sourceType == .photoLibrary
                            //                            //Alert(title: Text("Coming soon"), message: Text("Be on the lookout!"), dismissButton: .default(Text("Awesome!")))
                            //                            //print("type!!")
                            //
                            //
                            //                        }
                            
                            //                        Button ("Get the Notis homie"){
                            //                            addNotis()
                            //                        }
                            //                        .buttonBorderShape(.roundedRectangle)
                            //                        .buttonStyle(.borderedProminent)
                            //.padding()
                            
                            
                        }
                        
                        Button("Personalize Notifications"){
                            self.PersonalizeNotis = true
                            
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        //.padding()
                        .fullScreenCover(isPresented: $PersonalizeNotis, content: {
                            VStack{
                                
                                ScrollView(.vertical){
                                    Button(action: {
                                        self.PersonalizeNotis = false
                                    }){
                                        Image("xcloseout")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .topTrailing)
                                            .scaledToFit()
                                    }
                                    
                                    
                                    
                                    
                                    Text("Cutomize Your Notifications")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("Use the settings below to adjust when and what notifications to get during the day! Reminder that you can always customize it when needed.")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .multilineTextAlignment(.center)
                                    
                                    
                                    Section(header: Text("Number of notifications in a day").padding().fontWeight(.bold)){
                                        //DatePicker("Pick a time: ", selection: $time)
                                        //Picker
                                        
                                        
                                        Picker("Select a number: ", selection: $numbers){
                                            ForEach(0..<9) { number in
                                                
                                                Text("\(number)")
                                                // .padding()
                                                
                                                
                                            }
                                            
                                        }
                                        //.pickerStyle()
                                        
                                    }
                                    
                                    
                                    Section(header: Text("Types of notifications").padding().fontWeight(.bold).border(Color.clear)){
                                        Toggle("Greeting Notification", isOn: $TestSubject)
                                        Toggle("First Tips", isOn: $TestSubject)
                                        Toggle("Hourly Reminder", isOn: $TestSubject)
                                        Toggle("Study-based suggestion", isOn: $TestSubject)
                                        Toggle("Other suggestions", isOn: $TestSubject)
                                    }
                                    
                                    
                                    //                                        VStack{
                                    //                                            Text("Types of Notifications: ")
                                    //                                                .font(.subheadline)
                                    //                                                .multilineTextAlignment(.leading)
                                    //                                                .padding()
                                    //                                        }
                                    //
                                    
                                    Section(header: Text("Daily Reminder Notification").padding().fontWeight(.bold)){
                                        DatePicker("Pick a time: ", selection: $time, displayedComponents: .hourAndMinute)
                                    }
                                    
                                    
                                    Button(action: {
                                        
                                        //call and configure stuff here then the tab should close!
                                        
                                        
                                        self.PersonalizeNotis = false
                                    }){
                                        Text("Use these settings!")
                                            .bold()
                                        
                                        //                            Spacer()
                                        //                                .multilineTextAlignment(.center)
                                        // .padding()
                                        
                                        
                                    }
                                    .buttonStyle(.borderedProminent)
                                    
                                }
                            }
                        })
                        
                        
                       
                        
                       
                                
                                Text("Some sample suggestions include:")
                                    .font(.subheadline)
                                ScrollView(.horizontal){
                                    HStack{
                                        Image("StabilityAppSystem")
                                            .resizable()
                                            .frame(width: 300, height: 77)
                                            .cornerRadius(10)
                                        Image("WalkStability")
                                            .resizable()
                                            .frame(width: 330, height: 75)
                                            .cornerRadius(10)
                                        Image("HobbiesStability")
                                            .resizable()
                                            .frame(width: 300, height: 77)
                                            .cornerRadius(10)
                                    }
                                    .padding()
                                }
                                
                                //                    Button("Get These Notifications"){
                                //                        addNotification()
                                //
                                //
                                //                    }
                                //                    .buttonStyle(.borderedProminent)
                                
                                
                                
                                
                                //.actionSheet(isPresented: //, content: {
                                //  ActionSheet(title: Text("Action Sheet"))
                                //})
                                
                            }
                            .navigationBarTitle("Home")
                            
                            //VStack{
                            
                        }//}
                        
                    }
                }.sheet(isPresented: $showImagePicker) {
                    //Link("LinkedIn Contact", destination: //URL(string:"https://www.linkedin.com/in/abhiramruthala")!)
                    ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                    //ImagePicker(image: self.$image, sourceType: self.sourceType)
                }
                .sheet(isPresented: $Onboarding) {
                    OnboardingView(Onboarding: .constant(true))
                }
                
                
                
                
                
            }
            
            
            //aniation doesnt work -- yet
            //    func fadeIn(){
            //        withAnimation(.easeInOut(duration: 2.0)){
            //            GradientOpacity = 0.4
            //        }
            //    }
            
            
            func addNotis(){
                
                //        if classLabel == "Happy" {
                //            let addReqs = {
                //                let content = UNMutableNotificationContent()
                //                content.title = "Hi from Stability!"
                //                content.body = "Noticing that your mood was recorded as \(classLabel), we are here to provide you notifications to improve your mood."
                //                content.sound = UNNotificationSound.defaultCritical
                //
                //                let newTrig = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                //                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: newTrig)
                //
                //                newGang.add(request)
                //            }
                //        }
                
                let newGang = UNUserNotificationCenter.current()
                
                newGang.getNotificationSettings { settings in
                    if settings.authorizationStatus == .authorized {
                        self.NotificationsBasedOnMood()
                    } else {
                        newGang.requestAuthorization(options: [.alert, .badge, .sound]) {
                            success, error in
                            if success {
                                self.NotificationsBasedOnMood()
                            } else if let error{
                                print(error.localizedDescription)
                            }
                        }
                        
                        
                    }
                    
                }
                
            }
            func NotificationsBasedOnMood(){
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                let calendar = Calendar.current
                let date = Date().formatted(date: .complete, time: .omitted)
                var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
                
                let content = UNMutableNotificationContent()
                let content2 = UNMutableNotificationContent()
                let content3 = UNMutableNotificationContent()
                let content4 = UNMutableNotificationContent()
                let content5 = UNMutableNotificationContent()
                let CalendarContent = UNMutableNotificationContent()
                let PeerNotification1 = UNMutableNotificationContent()
                let contentSound = UNNotificationSound.defaultCritical
                
                //    center.remo
                
                //        let happyPages = ["going for a walk.", "speaking to loved ones.", "planning out a picnic.", "making a nice bowl of your favorite food!"]
                //        let newHappy = happyPages.randomElement()!
                
                let sadPages = ["going for a walk.", "speaking to loved ones.", "planning out a picnic.", "making a nice bowl of your favorite food!", "practicing mindfulness.", "spending time in nature.", "starting some exercise!", "listening to your favorite artist!", "engaging in some creative work like art/drawing/writing.", "giving someone a compliment! (Could be someone you know)."]
                let newSad = sadPages.randomElement()!
                
                let angryPages = ["going for a walk", "speaking to loved ones", "planning out a picnic", "making a nice bowl of your favorite food"]
                let newAngry = angryPages.randomElement()!
                
                switch classLabel {
                case "Happy":
                    //Notification 1
                    content.title = "Hi from Stability"
                    content.body = "We've recorded your mood as \(classLabel), and will send you notifications for \(date) to help you improve your mood."
                    content.sound = contentSound
                    //Notification 2
                    content2.title = "First Tips"
                    content2.body = "You seemed happy! Continue to promote this by \(newSad)"
                    content2.sound = contentSound
                    //Notification 3
                    content3.title = "Just checking up!"
                    content3.body = "How are you feeling? Do you wish to do another check up?"
                    content3.sound = contentSound
                    //Notification 4
                    content4.title = "Keep being happy"
                    content4.body = "Studies show that happiness leads to lower risks of heart disease, stroke, among many others, whilst positively boosting productivity and life span!"
                    content4.sound = contentSound
                    //Notification 5
                    content5.title = "Another check in"
                    content5.body = "Hope you've continued to be happy! If not, try \(newSad) I hope it helps!"
                    content5.sound = contentSound
                    //            PeerNotification1.title = "Rock Ridge PEER"
                    //            PeerNotification1.body = "PEER is hosting a Bracelet sale on December 1st! This is open during all lunch blocks and each bracelet is $2!"
                    //            PeerNotification1.sound = contentSound
                case "Sad":
                    content.title = "Hi from Stability"
                    content.body = "We've recorded your mood as \(classLabel), and will send you notifications for \(date) to help you improve your mood."
                    content.sound = contentSound
                    content2.title = "First Steps"
                    content2.body = "I'm sorry that you're feeling sad. Try \(newSad) It can help your mood!"
                    content2.sound = contentSound
                    content3.title = "Just checking up!"
                    content3.body = "How are you feeling? Do you wish to do another check up?"
                    content3.sound = contentSound
                    //New Notis
                    content4.title = "Here's some food for thought"
                    content4.body = "Do something nice today! Studies show that happiness leads to lower risks of heart disease, stroke, among many others, whilst positively boosting productivity and life span!"
                    content4.sound = contentSound
                    //Notification 5
                    content5.title = "Another check in"
                    content5.body = "I hope you're okay. If not, try \(newSad) I hope it helps!"
                    content5.sound = contentSound
                    //            PeerNotification1.title = "Rock Ridge PEER"
                    //            PeerNotification1.body = "PEER is hosting a Bracelet sale on December 1st! This is open during all lunch blocks and each bracelet is $2!"
                    //            PeerNotification1.sound = contentSound
                case "Angry":
                    content.title = "Hi from Stability"
                    content.body = "We've recorded your mood as \(classLabel), and will send you notifications \(date) to help you improve your mood."
                    content.sound = contentSound
                    content2.title = "First Steps"
                    content2.body = "You feeling angry? Try \(newSad) It can help you!"
                    content2.sound = contentSound
                    content3.title = "Just checking up!"
                    content3.body = "How are you feeling? Do you wish to do another check up?"
                    content3.sound = contentSound
                    //Notification 5
                    content5.title = "Another check in"
                    content5.body = "I hope you're okay. If not, try \(newSad) I hope it helps!"
                    content5.sound = contentSound
                    //            PeerNotification1.title = "Rock Ridge PEER"
                    //            PeerNotification1.body = "PEER is hosting a Bracelet sale on December 1st! This is open during all lunch blocks and each bracelet is $2!"
                    //            PeerNotification1.sound = contentSound
                    
                default:
                    content3.title = "Just checking up!"
                    content3.body = "How are you feeling? Do you wish to do another check up?"
                    content3.sound = contentSound
                    
                }
                
                dateComponents.hour = 09
                dateComponents.minute = 00
                dateComponents.second = 00
                
                CalendarContent.title = "Hey there!"
                CalendarContent.body = "This is a reminder to take a picture today to track your mood!"
                CalendarContent.sound = contentSound
                
                //might have to look for the time at which the button is pressed for this part to integrate some new features!
                // all notification triggers
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
                let trigger5 = UNTimeIntervalNotificationTrigger(timeInterval: 2400, repeats: false)
                let trigger4 = UNTimeIntervalNotificationTrigger(timeInterval: 9000, repeats: true)
                let triggerSzn = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
                let trigger3 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                //Peer Notifications trigger
                //    let PeerTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                
                
                // all notification requests
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content2, trigger: trigger2)
                let request3 = UNNotificationRequest(identifier: UUID().uuidString, content: CalendarContent, trigger: trigger3)
                let request4 = UNNotificationRequest(identifier: UUID().uuidString, content: content3, trigger: trigger4)
                let request5 = UNNotificationRequest(identifier: UUID().uuidString, content: content5, trigger: triggerSzn)
                let request6 = UNNotificationRequest(identifier: UUID().uuidString, content: content4, trigger: trigger5)
                
                //PEER Notification Requests
                //      let PeerRequest = UNNotificationRequest(identifier: UUID().uuidString, content: PeerNotification1, trigger: PeerTrigger)
                
                center.add(request) { error in
                    if let error{
                        print(error.localizedDescription)
                    }
                }
                center.add(request2) { error in
                    if let error{
                        print(error.localizedDescription)
                    }
                    
                }
                
                center.add(request4) { error in
                    if let error{
                        print(error.localizedDescription)
                    }
                }
                
                //change once fully tested! && dateComponents.second == 00
                
                //  if dateComponents.hour == 12 && dateComponents.minute == 00 {
                //center.removeAllPendingNotificationRequests()
                
                center.add(request3) { error in
                    if let error {
                        print(error.localizedDescription)
                    }
                }
                //   }
                center.add(request5) { error in
                    if let error {
                        print(error.localizedDescription)
                    }
                }
                
                center.add(request6) { error in
                    if let error {
                        print(error.localizedDescription)
                    }
                }
                
                
                //All Peer Notification Requests
                //    center.add(PeerRequest) { error in
                //        if let error {
                //            print(error.localizedDescription)
                //        }
                //
                //    }
                //
                
                
            }
            
            
        }
        
        
        //func addNotification(){
        //    let center = UNUserNotificationCenter.current()
        //
        //    let addRequest = {
        //        let content = UNMutableNotificationContent()
        //        content.title = "Test Notification from Stability!"
        //        content.body = "How do you do today?"
        //        content.sound = UNNotificationSound.defaultCritical
        //        let content2 = UNMutableNotificationContent()
        //        content2.title = "Hey buddy!"
        //        content2.subtitle = "Stability"
        //        content2.body = "Go for a walk to help improve your mood."
        //        content2.sound = UNNotificationSound.defaultCritical
        //
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        //        let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content2, trigger: trigger)
        //        center.add(request)
        //        center.add(request2)
        //    }
        //
        //    center.getNotificationSettings { settings in
        //        if settings.authorizationStatus == .authorized {
        //            addRequest()
        //        } else {
        //            center.requestAuthorization(options: [.alert, .badge, .sound]) {
        //                success, error in
        //                if success {
        //                    addRequest()
        //                } else if let error{
        //                    print(error.localizedDescription)
        //                }
        //            }
        //
        //
        //        }
        //
        //    }
        //
        //}
        
        
        
        #Preview {
            HomePage()//filter: .home)//CameraView()
            //OnboardingView(Onboarding: .constant(true))
            
        }
        
        struct OnboardSystem: Identifiable {
            let id = UUID()
            let label: String
            let text: String
            let images: ImageResource
            
        }
        
        let OnboardPages = [
            OnboardSystem(label: "Hey there!", text: "Welcome to Stability!", images: .IMG_7731),
            OnboardSystem(label: "Test your mood everyday!", text: "This app hopes to make you feel better by using machine learning algorithms and a simplistic classification of your face. This, in turn, provides notifications to help you feel better.", images: .IMG_7731),
            OnboardSystem(label: "Use the camera or photo library", text: "Use a photo from today or take a picture in real-time to test your mood through the scanner and get comprehensive mood feedback!", images: .IMG_7731),
            OnboardSystem(label: "Disclaimer", text: "This system does not offer medical advice, nor should be used as one. This is just a system that recommends you ways to improve your mood throughout the day.", images: .warning),
            //    OnboardSystem(label: "Personalize the app here", text: "Since this app is based on notifications, personalize how you wish the notifications to appear to you!", images: .IMG_7731)
            
            //transparent background doesn't work -- not the biggest concern but something to fix to improve elegancy.
        ]
        
        struct OnboardingView: View {
            @Binding var Onboarding: Bool
            
            var body: some View{
                VStack{
                    TabView{
                        ForEach(OnboardPages) { page in
                            VStack{
                                Image(page.images)
                                    .resizable()
                                    .frame(width: 220, height: 280)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                                
                                Text(page.label)
                                    .padding(.vertical, 1)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                //really considering a font style change here
                                //.fontDesign(.serif)
                                //.fontDesign(.serif)
                                    .multilineTextAlignment(.center)
                                Text(page.text)
                                    .font(.subheadline)
                                    .padding(.vertical, 1)
                                //.fontWeight(.semibold)
                                //.fontDesign(.serif)
                                    .multilineTextAlignment(.center)
                                // .fontDesign(.default)
                            }
                        }
                        
                        
                    }
                    
                    Button {
                        //interactiveDismissDisabled(true)
                        Onboarding.toggle()
                        
                    } label: {
                        Text("Swipe Down To Use The App!")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                        
                        
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    
                    
                    
                }
                //.interactiveDismissDisabled()
                .tabViewStyle(.page)
                .onAppear{
                    UIPageControl.appearance().currentPageIndicatorTintColor = .black
                    UIPageControl.appearance().pageIndicatorTintColor = .gray
                    
                }
                
                
            }
        }
