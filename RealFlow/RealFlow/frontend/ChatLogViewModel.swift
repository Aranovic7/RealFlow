//
//  ChatLogViewModel.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-04-24.
//

import Foundation

class ChatLogViewModel: ObservableObject {
    
    var firebaseManager: FirebaseManager // Använd den delade instansen av FirebaseManager
    @Published var chatText: String = ""
    @Published var messages: [Message] = []
    @Published var count: Int = 0
    
    
    init(firebaseManager: FirebaseManager = FirebaseManager()) {
           self.firebaseManager = firebaseManager
           self.count += 1
           fetchMessages() // Anropa fetchMessages() när ChatLogViewModel skapas
       }
    
    
    func handleSend(text: String, recipientID: String) {
        
        print(chatText)
        // Lägg till logik för att spara medelandet i databasen
        if !text.isEmpty {
            firebaseManager.saveMessage(message: text, toRecipient: recipientID) { success in
                if success {
                    print("Meddelandet sparades framgångsrikt")
                    self.chatText = ""
                    self.count += 1
                } else {
                    print("Misslyckades med att spara meddelandet")
                }
                
            }
        }
    }
    
    func fetchMessages() {
            firebaseManager.fetchMessages { messages in
                DispatchQueue.main.async {
                    self.messages = messages
                }
            }
        }
    
}
