//
//  ChatLogView.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-04-24.
//

import SwiftUI

struct ChatLogView: View {
    
    let user: UserData
    @ObservedObject var chatLogViewModel: ChatLogViewModel
    var firebaseManager: FirebaseManager
    // Add a new property to store the current user's ID
     var currentUserId: String {
       return firebaseManager.auth.currentUser?.uid ?? ""
     }
    

    var body: some View {
        VStack{
            ScrollView{
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
//                            .padding(.horizontal)
//                            .padding(.top, 8)
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
                
            }
                .background(Color.gray.opacity(0.2))
                .navigationTitle(user.username)
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(chatLogViewModel.$messages) { messages in
                    // Uppdatera vyn när meddelandena ändras
                    print("fetched messaged onReceive: \(messages)")
//                    chatLogViewModel.fetchMessages()
                   
                }
                .onAppear{
                    print("Current user id: \(currentUserId)")
                }
                
            
        }
       // ChatBarComponent(user: UserData.init(username: user.username))
        ChatBarComponent(chatLogViewModel: chatLogViewModel, user: user)
    }
    
}

//#Preview {
//    ChatLogView(user: .init(username: "Dennix"))
//}
