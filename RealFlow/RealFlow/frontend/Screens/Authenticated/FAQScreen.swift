//
//  FAQScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-03-25.
//

import SwiftUI

struct FAQItem: Identifiable, Equatable {
    let id = UUID()
    let question: String
    let answer: String
   
}

let faqItems: [FAQItem] = [
    FAQItem( question: "Question 1", answer: "Answer 1"),
    FAQItem( question: "Question 2", answer: "Answer 2"),
    FAQItem( question: "Question 3", answer: "Answer 3"),
    FAQItem( question: "Question 4", answer: "Answer 4"),
    FAQItem( question: "Question 5", answer: "Answer 5"),
    FAQItem( question: "Question 6", answer: "Answer 6"),
    FAQItem( question: "Question 7", answer: "Answer 7")
]

struct FAQScreen: View {
    
    @State var showAnswers: Bool = false
    @State var selectedQuestion: FAQItem?
    @State var navigateBackBtn: Bool = false
    
    var body: some View {
        
            List(faqItems) { faqItem in
                VStack(alignment: .leading){
                    Text(faqItem.question)
                        .foregroundStyle(selectedQuestion == faqItem ? Color.red : .black)
                    if selectedQuestion == faqItem {
                        Text(faqItem.answer)
                    }
                  
                }.onTapGesture {
                    selectedQuestion = faqItem
                }
                .padding()
            
            }
    }
}

#Preview {
    FAQScreen()
}
