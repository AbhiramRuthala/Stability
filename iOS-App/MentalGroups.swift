//
//  MentalGroups.swift
//  Stability
//
//  Created by Abhiram Ruthala on 12/28/24.
//

import SwiftUI

struct MentalGroups: View {
    @State private var ClickSzn: Bool = false
    @State private var PeerGroup: Bool = false
    @State private var MentalHealthUnited: Bool = false
    @State var isAnimating: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                
                
                ScrollView(.vertical){
                    
                    Text("Welcome to Mental Health Groups. Click on a group to learn about the groups and their offerings!")
                        .padding()
                        .multilineTextAlignment(.center)
                    Button(action:{
                        self.PeerGroup = true
                    }){
                        Image("spideygng")
                            .resizable()
                            .cornerRadius(10)
                            .scaledToFit()
                            //.colorMultiply(.gray)
                            .padding()
                            .shadow(radius: 10)
                            .overlay(alignment: .bottomTrailing, content: {
                                VStack{
                                    Text("Mental Health Group")
                                        .fontDesign(.serif)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .padding()
                                        .foregroundColor(.white)
                                    Text("Rock Ridge PEER")
                                        .fontDesign(.serif)
                                        .foregroundColor(Color.black)
                                        .shadow(radius: 5)
                                        .fontWeight(.bold)
                                        .padding()
                                        .padding()
                                }
                                
                            })

                        
                    }
                            
                   
                    Button(action: {
                        self.MentalHealthUnited = true
                        
                    }){
                        Image("markzuckhomie")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .padding()
                            .shadow(radius: 10)
                            .overlay(alignment: .bottomTrailing, content: {
                                
                                VStack{
                                
                                    Text("Mental Health Group")
                                        .frame(alignment: .bottomTrailing)
                                        .fontDesign(.serif)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        //Spacer()
                                 
                                    Text("Mental Health of America")
                                        .fontDesign(.serif)
                                        .shadow(radius: 5)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .fontWeight(.bold)
                                        .padding()

                                }
                            })
                        
                    }
                    
                        
                                
                                    

                        
                    Image("buildinghomie")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                        .overlay(alignment: .bottomTrailing, content: {
                            Text("Mental Health Group")
                                .fontDesign(.serif)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .padding()
                                .padding()
                            Text("Mental Health United (MHU)")
                                .fontDesign(.serif)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .padding()
                                .fontWeight(.bold)
                                .padding()
                            
                                
                        })
                    
                        Text("Resources")
                            .font(.title)
                            .fontWeight(.bold)
                           // .scrollBounceBehavior(.basedOnSize)
                            .hoverEffect(.automatic)
                            .scaleEffect(isAnimating ? 1.5:1)
                          //  .animation(.linear(duration: 1), value: isAnimating)
                    
                    
                            .onAppear{
                                withAnimation{
                                    isAnimating = true
                                }
                            }
                    VStack{
                        Button(action: {
                            self.ClickSzn = true
                        }){
                            Image("buildinghomie")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .hoverEffect(.lift)
                                .padding()
                                .overlay(alignment: .bottomTrailing) {
                                    Text("Breathing Exercises")
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                        .fontDesign(.serif)
                                        .padding()
                                        .padding()
                                }
                        }
                    }
                    
                }.navigationBarTitle("Mental Health Groups & Resources")
                    .fullScreenCover(isPresented: $ClickSzn, content: {
                        VStack{
                            
                            Button(action: {
                                self.ClickSzn = false
                            }){
                                Image("xcloseout")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .topTrailing)
                            }
                            ScrollView(.vertical){
                                VStack{
                                    Text("Welcome to Breathing Exercises")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("Click on the multitude of options to start improving your breathing!")
                                        .foregroundStyle(.secondary)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.center)
                                       // .padding()
                                    
                                    Divider()
                                        .frame(width: 55, height:5)
                                        //.foregroundColor(.gray)
                                        .overlay(Color.gray)
                                        .cornerRadius(10)
                                    
                                    
                                    Text("Tips")
                                        .font(.footnote)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                    
                                    
                                    //.font
                                    
    
                                    
                                    
                                    Text("Here are some apps that currently optimize breathing exercises:")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    ScrollView(.horizontal){
                                        HStack{
                                            Image("bennyblance")
                                                .resizable()
                                                //.scaleEffect(1)
                                                
                                                .cornerRadius(5)
                                            Image("markzuckhomie")
                                                .resizable()
                                                //.scaledToFit()
                                                .cornerRadius(5)
                                            Image("Coolhappy")
                                                .resizable()
                                                //.scaledToFit()
                                                .cornerRadius(5)
                                        }
                                    }
                                }
                            }
                        }
                    })
                    .fullScreenCover(isPresented: $PeerGroup, content: {
                        VStack{
                            
                            Button(action: {
                                self.PeerGroup = false
                            }){
                                
//                                if (traitCollection.userInterfaceStyle == .dark) {
//                                    Image("")
//                                } else {
                                    
                                    Image("xcloseout")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .topTrailing)
                                    //.position(x:350, y:-300)
                                    
                                        .scaledToFit()
//                                }
                                                            }
                            ScrollView(.vertical){
                                Image("spideygng")
                                    .resizable()
                                    .scaledToFit()
                                    .overlay(alignment: .bottomLeading, content: {
                                        Text("Rock Ridge PEER")
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                    })
                            }
                        }
                    })
                    .fullScreenCover(isPresented: $MentalHealthUnited, content: {
                        VStack{
                            Button(action:{
                                //withAnimation{
                                    self.MentalHealthUnited = false
                              //  }
                                
                            }){
                                Image("xcloseout")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .topTrailing)
                                    .scaledToFit()
                                    
                            }
                            
                            ScrollView(.vertical){
                                Text("Welcome to Mental Health United")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                Text("This group will help you be the best version of yourself!")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                    })
                
            }
            
        }
    }
}
    
#Preview {
        MentalGroups()
}

