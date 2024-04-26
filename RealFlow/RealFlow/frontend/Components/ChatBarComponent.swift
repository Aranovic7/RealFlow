//
//  ChatBarComponent.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-04-24.
//

import SwiftUI

struct ChatBarComponent: View {
    
   // @ObservedObject var chatLogViewModel = ChatLogViewModel()
    @ObservedObject var chatLogViewModel: ChatLogViewModel // Ta emot ChatLogViewModel som parameter
    let user: UserData
  
    var body: some View {
        HStack(spacing: 16){
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundStyle(Color(.darkGray))
            TextField("Description", text: $chatLogViewModel.chatText)
            Button{
                chatLogViewModel.handleSend(text: self.chatLogViewModel.chatText, recipientID: user.username)
            } label: {
                Text("Send")
                    .foregroundStyle(Color.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .clipShape(.rect(cornerRadius: 8))
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    ChatBarComponent(chatLogViewModel: ChatLogViewModel(firebaseManager: FirebaseManager()), user: .init(username: "denniz@gmail.com"))
}
