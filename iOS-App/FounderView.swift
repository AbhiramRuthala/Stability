//
//  FounderView.swift
//  Stability
//
//  Created by Abhiram Ruthala on 11/30/24.
//

import SwiftUI

struct FounderView: View {
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.vertical){
                    
                    
                    Image("IMG_7731")
                        .resizable()
                        .frame(width: 120, height: 150)
                        .clipShape(Circle())
                    
                    //Image("")
                    
//                    VStack{
                        Text("Abhiram Ruthala")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
//                            .border(.red, width: 5)
//                            .cornerRadius(5)
                        
//                        .border(.white)
//                            .cornerRadius(4)
                        Text("Abhiram Ruthala is a senior at Rock Ridge High School who loves all-things neuroscience. He sees potential in a growing field regarding brain tapestry and hopes to create impact in this field.")
                            .multilineTextAlignment(.center)
                        
//                    }
                    Text("Thanks to the PEER Group at Rock Ridge High School for their support on this project!")
                        .font(.headline)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    
                    Text("Any feedback/suggestions? Click here!")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    //Button("Submit Feedback Here"){
                    Link("Submit Feedback Here!", destination: URL(string:"https://forms.gle/u1N1viZ68knUfhG78")!)
                    //}
                        .buttonStyle(.bordered)
                        .tint(.blue)
                    
                    Text("Click here to get product updates")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    Link("Product Updates", destination: URL(string:"https://abhiramruthala.substack.com/")!)
                        .buttonStyle(.bordered)
                        .tint(.blue)
                     
                    Text("An Abhiram Ruthala Production")
                        .padding(.vertical, 100)
                        .font(.caption)
                }
                
            }.navigationBarTitle("About The Founder")
        }
    }
}

#Preview {
    FounderView()
}
