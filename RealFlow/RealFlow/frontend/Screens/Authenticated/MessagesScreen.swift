//
//  MessagesScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-28.
//

import SwiftUI

struct MessagesScreen: View {
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    @EnvironmentObject var chatLogViewModel: ChatLogViewModel
    
    @State var shouldNavigateToChatLogView: Bool = false
    
    @State private var latestMessage: Message? // State-variabel för att hålla det senaste meddelandet
    
    // Dictionary för att lagra det senaste meddelandet för varje användare
    @State private var latestMessages: [String: Message] = [:]
    
    
    var body: some View {
        NavigationStack{
            VStack{
                TopNavBar()
                ScrollView{
                    ForEach(firebaseManager.usersData.filter { user in
                        let currentUserUID = firebaseManager.auth.currentUser?.uid ?? ""
                        return firebaseManager.recentMessages.contains { message in
                            (message.senderID == currentUserUID && message.recipientUsername == user.username) ||
                            (message.senderID == user.username && message.recipientUsername == currentUserUID)}}) { user in
                                // NavigationLink("", isActive: $shouldNavigateToChatLogView) {
                                //     ChatLogView(user: user, firebaseManager: firebaseManager)
                                NavigationLink(destination: ChatLogView(user: user, firebaseManager: firebaseManager), isActive: $shouldNavigateToChatLogView){
                                    VStack{
                                        HStack(spacing: 16){
                                            
                                            if let profileImageURL = user.profileImageURL {
                                                AsyncImage(url: profileImageURL) { phase in
                                                    switch phase {
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                            .font(.system(size: 32))
                                                            .clipShape(Circle())
                                                        //                                            .overlay(RoundedRectangle(cornerRadius: 44).stroke(Color.black, style: .init(lineWidth: 1)))
                                                    case .failure(let error):
                                                        Text("Failed to load image: \(error.localizedDescription)")
                                                    case .empty:
                                                        ProgressView()
                                                    @unknown default:
                                                        EmptyView()
                                                    }
                                                }
                                            }
                                            
                                            
                                            VStack(alignment: .leading){
                                                Text(user.username)
                                                    .font(.system(size: 16) .weight(.bold))
                                                
                                                if let latestMessage = latestMessages[user.username] {
                                                    
                                                    Text(latestMessage.text)
                                                        .font(.system(size: 14))
                                                        .foregroundStyle(Color.gray)
                                                    
                                                    
                                                }
                                                
                                                
                                            }
                                            Spacer()
                                            
                                            if let latestMessage = latestMessages[user.username] {
                                                
                                                Text(latestMessage.timeAgo)
                                                    .font(.system(size: 14, weight: .semibold))
                                            }
                                            
                                        }.onTapGesture {
                                            shouldNavigateToChatLogView = true
                                            print("recentMessages: \(firebaseManager.recentMessages)")
                                            print("selected user is: \(user)")
                                        }
                                        
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 8)
                                } .padding(.horizontal)
                                    
                            }
                    
                                        
                }
                .overlay(
                    NewMessagesBtn(), alignment: .bottom
                    
                )
                
                
            }
            
            .onAppear{
                firebaseManager.fetchAllUsers{ users in
                    firebaseManager.usersData = users
                }
                firebaseManager.fetchMessages { messages in
                    // Uppdatera latestMessages-dictionaryn med det senaste meddelandet för varje användare
                    var updatedLatestMessages: [String: Message] = [:]
                    for message in messages {
                        updatedLatestMessages[message.recipientUsername] = message
                    }
                    
                    self.latestMessages = updatedLatestMessages
                    
                    firebaseManager.recentMessages = messages
                }
                print("recentMessages: \(firebaseManager.recentMessages)")
            }
            
        }
    }
}
        

#Preview {
    MessagesScreen()
}

