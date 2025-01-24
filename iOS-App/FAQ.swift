//
//  FAQ.swift
//  Stability
//
//  Created by Abhiram Ruthala on 11/21/24.
//

import SwiftUI

struct QuestionAnswer: Identifiable {
    let id = UUID()
    let textOne: String
    var textTwo: [QuestionAnswer]?
}

struct FAQ: View {
    
    let QuestionList : [QuestionAnswer] = [ qa1(), qa2(), qa3()]// qa4() ]
    var body: some View {
        
        
        ScrollView(.vertical){
            NavigationView{
                //fix scroll view it's not working correctly!!!!!!
                //please look into this!
                //ScrollView(.vertical){
                VStack{
                    //Text("")
                    Text("Here's some things to know about Stability & its background.")
                        .font(.subheadline)
                    List(QuestionList, children: \.textTwo) { item in
                        Text(item.textOne)
                    }
                    
                }.navigationBarTitle("Information & FAQs")
                //}
            }
        }
    }
}

func qa1() -> QuestionAnswer {
    return .init(textOne: "How does the face scan system work?", textTwo: [.init(textOne: "It works by leveraging AI and iOS camera functionality to help you improve your mood.")])
}

func qa2() -> QuestionAnswer {
    return .init(textOne: "What happens if people 'fake' their emotion?", textTwo: [.init(textOne: "There's 2 sides to this. If you lie about your mood (Example: You fake a frown and try to showcase anger), the notifications are going to suggest ways to remove anger, which isn't a wrong thing at all. If you stay truthful to the emotion you show, there's nothing wrong with that as well, because all the notificatons are going to be tailored towards being happy and improving your mood through helpful activities. The only problem I see this creating is the mood-log system, where multiple fake mood entries can lead to a falsified demonstration of your mood over a period of time. However, we are actively working on fixing this problem.")])


}
func qa3() -> QuestionAnswer {
    return .init(textOne: "Would people get more dependent with their phones?", textTwo: [.init(textOne: "It really depends on how you wish to use it. Dependency on your phone is good to an extent—making phone calls, conducting bank operations, and checking the news—are all ways dependency helps us. Where dependency gets worse is when people replace life-based emotions—happiness, sadness etc.—through screens and other media, basically sucking yourself out of any worthwhile means of engaging in such emotions. Stability offers an alternative by non-invasively providing tips for you to be more mindful of your mood. It's for you to be more aware that this device, right in front of you, can be doing more to your health than you might know of it.")])
}

//Placeholder for 4th question and beyond
//
//func qa4() -> QuestionAnswer {
//    return .init(textOne: "What happens in the case of ....?", textTwo: [.init(textOne: "Dawg it really depends on yadda yadda yadda")])
//}

#Preview {
    FAQ()
}
