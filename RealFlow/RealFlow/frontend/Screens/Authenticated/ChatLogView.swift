//
//  ChatLogView.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-04-24.
//

import SwiftUI

struct ChatLogView: View {
    
    let user: UserData
    @StateObject var chatLogViewModel = ChatLogViewModel()
    
     var firebaseManager: FirebaseManager
    // Add a new property to store the current user's ID
     var currentUserId: String {
       return firebaseManager.auth.currentUser?.uid ?? ""
     }
    
    var body: some View {
        VStack{
            ScrollView{
                ScrollViewReader{ scrollViewProxy in
                    VStack{
                        
                        ForEach(chatLogViewModel.messages) { messages in
                            VStack{
                                if messages.senderID == currentUserId{
                                    HStack{
                                        Spacer()
                                        HStack{
                                            Text(messages.text)
                                                .foregroundStyle(Color.white)
                                        }
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(.rect(cornerRadius: 10))
                                    }
                                    
                                } else {
                                    HStack{
                                        
                                        HStack{
                                            Text(messages.text)
                                                .foregroundStyle(Color.black)
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(.rect(cornerRadius: 10))
                                        Spacer()
                                        
                                    }
                                }
                            } .padding(.horizontal)
                                .padding(.top, 8)
                            
                        }
                        
                        HStack{ Spacer() }
                            .id("lastMessage")
                    }
                    .onAppear{
                
                        scrollViewProxy.scrollTo("lastMessage", anchor: .bottom)
                    }
                    .onChange(of: chatLogViewModel.messages) { _ in
                        withAnimation(.easeOut(duration: 0.5)){
                            scrollViewProxy.scrollTo("lastMessage", anchor: .bottom)
                        }
                        
                    }
                }
                       
                }
            }
            .background(Color.gray.opacity(0.2))
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
            
        
        .toolbar(.hidden, for: .tabBar)
        ChatBarComponent(chatLogViewModel: chatLogViewModel, user: user)
    }
}


