//
//  ContactUsScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-03-24.
//

import SwiftUI

struct ContactUsScreen: View {
    
    @State var navigateToFAQ: Bool = false
    @State var navigateToSupportChat: Bool = false
    
    var body: some View {
        VStack{
            
            Text("Har du några frågor eller behöver du hjälp? Vi finns för att hjälpa dig")
                .font(.title3)
                .bold()
                .padding(30)
            
            VStack(spacing: 40){
                
                ZStack{
                    
                        Rectangle()
                            .frame(width: 360, height: 100)
                            .foregroundStyle(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black.opacity(0.3))
                            )
                            .overlay(
                                Image(systemName: "questionmark.bubble")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(.circle)
                                    .padding(.trailing, 270)
                            )
                    
                    VStack(alignment: .leading){
                        
                        Text("Läs vanliga frågor")
                            .bold()
                            .padding(.bottom, 2)
                        
                        Text("Få snabba svar på våra vanligaste frågor")
                            .font(.system(size: 14))
                        
                    } .padding(.leading, 80)
                    
                } .onTapGesture {
                    navigateToFAQ = true
                }
                
                
                ZStack{
                    
                    Rectangle()
                        .frame(width: 360, height: 100)
                        .foregroundStyle(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black.opacity(0.3))
                        )
                        .overlay(
                            Image(systemName: "bubble.left.and.bubble.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .clipShape(.circle)
                                .padding(.trailing, 270)
                        )
                
                VStack(alignment: .leading){
                    
                    Text("Kontakta oss")
                        .bold()
                        .padding(.bottom, 2)
                    
                    Text("Kontakta oss via chatten")
                        .font(.system(size: 14))
                    
                } .padding(.trailing)
                    
                } .onTapGesture {
                   navigateToSupportChat = true
                }
                
            }
            
            Spacer()
               
        }
    }
}

#Preview {
    ContactUsScreen()
}
