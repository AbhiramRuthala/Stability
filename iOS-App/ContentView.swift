//
//  ContentView.swift
//  Stability
//
//  Created by Abhiram Ruthala on 9/1/24.
//

import SwiftUI
import UserNotifications
import CoreML

struct ContentView: View {
    //@State private var isNotificationAuthorized = false
    var body: some View {

                //Image(systemName: "globe")
                //  .imageScale(.large)
                //  .foregroundStyle(.tint)
                //Text("Welcome to Stability!")
                //    .cornerRadius(3.0)
//                Button("Remind Me", systemImage: "bell"){
//                    addNotification()
//                    
//                } .tint(.blue)
//            }
//            .padding()
//            .onAppear() {
//                //requestNotificationPermission()
                
                
                
        TabView {
            
            HomePage()
                .tabItem{
                    Image(systemName: "person.3")
                    Text("Home")
                    
                }
            MentalGroups()
                .tabItem{
                    Image(systemName: "person.2")
                    Text("Mental Health Groups")
                }
            TiktokQuotes()
                .tabItem{
                    Image(systemName: "plus.square")
                    Text("Reminisce")
                }
//            Resources()
//                .tabItem{
//                    Image(systemName: "person.2")
//                    Text("Resources")
//                }
//            MoodHealthSystem(filter: .moodHealth)
//                .tabItem {
//                    Image(systemName: "shareplay")
//                    Text("Mood Health")
//                }
//            Account(filter: .account, name: "John Doe", email:"JohnDoe@gmail.com", interests: "Basketball")
//                .tabItem {
//                    Image(systemName: "person.crop.square")
//                    Text("Your Account")
//                }
            FAQ()
                .tabItem{
                    Image(systemName: "info.circle")
                    Text("Information & FAQs")
                }
            
            FounderView()
                .tabItem {
                    Image(systemName: "person.and.background.dotted")
                    Text("Learn More")
                }
           
            
            
            }
//        VStack{
//            Text("Welcome to Stability!")
//                .font(.headline)
//        }

        }
}
    
    
#Preview {
        ContentView()
    }

