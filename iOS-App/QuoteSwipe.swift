//
//  TiktokQuotes.swift
//  Stability
//
//  Created by Abhiram Ruthala on 1/15/25.
//

//  This is essentially Tiktok for Quotes. QuoteSwipe allows you to swipe on quotes regarding the mood reading that you get, allowing you to build wisdom and ensure a proper approach toward safe mental health.

import SwiftUI

struct TiktokQuotes: View {
//    @State private var ImageSzn: [UIImage] = ["spideygng", "markzuckhomie", "spideygng", "markzuckhomie", "spideygng"]
    @State private var QuoteSzn: [String] = [" \"Love your moments in time\"", " \"Have a great life\"", "Do great things", "\"A safe mind is a safe body\"", " \"Breathe and live in the moment\""]
    @State private var QuoteIndex: Int = 0
    @Environment(\.colorScheme) var ColorScheme
    
//    var moodLabel: classLabel {
//        switch classLabel{
//        case "Happy":
//        case "Sad":
//
//        case "Angry":
//
//        default:
//
//        }
//    }
    
    
    
    
//    init(){
//        let appearanceSzn = UINavigationBarAppearance()
//        
//        appearanceSzn.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearanceSzn.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        
//        UINavigationBar.appearance().standardAppearance = appearanceSzn
//        
//        
//    }
    var body: some View {
        
        
        NavigationView{
            
            VStack{
                
                
//                Image("Coolhappy")
//                    .resizable()
//                    .scaledToFill()
//                   // .aspectRatio(contentMode: .fill)
//                    .cornerRadius(5.0)
//                    .shadow(radius: 10)
//                    .frame(width: 350, height: 800)
//                    
//                    .overlay(alignment: .center, content: {
                        VStack{
                            Text("Welcome to QuoteSwipe! Start swiping away at these meaningful quotes and improve your mood!")
                                .multilineTextAlignment(.center)
                                .fontDesign(.serif)
                                .foregroundColor(.white)
                            
                                //.position(x: 200, y:50)
                            //Spacer()
                            Text("Current Mood Reading: ")
                                .multilineTextAlignment(.center)
                                .fontDesign(.serif)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                //.frame(width: 200, alignment: .center)
                               // Spacer()
                                //.padding()
                                //.position(x: 200, y:0)
                            //.padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                            Spacer()
//                            Spacer()
//                            Spacer()
                            Text(QuoteSzn[QuoteIndex])
                                .padding()
                                .font(.subheadline)
                                .scaleEffect(2)
                                .fontWeight(.black)
                                .fontDesign(.serif)
                                .foregroundColor(.white)
                            
                            //dude what this is so inefficient
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            
                        }
//                    })
                    
                
//                Button(action: QuoteIndex = (QuoteIndex+1), label: {
//                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//                })
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.height < -50{
                                    QuoteIndex = (QuoteIndex + 1)
                                    
                                    if QuoteIndex > 5 {
                                        QuoteIndex = QuoteIndex - 5
                                    }
                                } else if value.translation.height > 50 {
                                    QuoteIndex = (QuoteIndex - 1)
                                    //error handling for quote usage
//                                    if QuoteIndex < 0 {
//                                        Text("Quit")
//                                    }
                                    if QuoteIndex < 0 {
                                        QuoteIndex = QuoteIndex + 5
                                    }
                                    
                                    //if not error handling run a system to reset the quotes
                                }
                            }
                    
                    )
                
            }.navigationTitle("QuoteSwipe (BETA)")
                .background(Image("Coolhappy").resizable().scaledToFill().ignoresSafeArea())
            
            
            //gotta fix appearance for light mode
                .onAppear{
                    setNavigationWhite()
                    
                }
                .onDisappear{
                    resetNavigationWhite()
                }
            
            
                //.foregroundColor(.white)
           // if  10 > 5 {
//                .background(
//                .background(Image("Coolhappy").resizable().scaledToFill().ignoresSafeArea())//.resizable().frame(width: 400, height: 100))
                            // }
//                        } else {
//                            background(Image("bennyblance").resizable().scaledToFill().ignoresSafeArea())

            
//            .toolbar{
//                    ToolbarItem(placement: .topBarLeading){
//                        Text("QuoteSwipe")
//                            .foregroundColor(.white)
//                            .font(.title)
//                            .fontWeight(.bold)
//                    }
//                }
                
               // .ignoresSafeArea()
            
            

            
            
        }
    }
}

private func setNavigationWhite(){
    let appearance = UINavigationBarAppearance()
    
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    UINavigationBar.appearance().standardAppearance = appearance
}

private func resetNavigationWhite(){
    let appearanceSzn = UINavigationBarAppearance()

    UINavigationBar.appearance().standardAppearance = appearanceSzn
    
}

#Preview {
    TiktokQuotes()
}
