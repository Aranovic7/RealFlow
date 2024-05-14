//
//  ContentView.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-18.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var firebaseManager = FirebaseManager()
    @StateObject var chatLogViewModel = ChatLogViewModel()
    
    
    var body: some View {
        if firebaseManager.isLoggedIn {
            TabView{
                
                MessagesScreen()
                
                    .tabItem {
                        Image(systemName: "bubble")
                        Text("Messages")
                    }
                
                ProfileScreen()
                
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                
                SettingsScreen()
                
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .environmentObject(firebaseManager)
            .environmentObject(chatLogViewModel)
            
            
        } else {
            NavigationStack{
                LoginScreen()
                    
            } 
            .environmentObject(firebaseManager)
            .environmentObject(chatLogViewModel)
            
              
        }
        
    }
}
  

#Preview {
    ContentView()
        .environmentObject(FirebaseManager())
        .environmentObject(ChatLogViewModel())
}
