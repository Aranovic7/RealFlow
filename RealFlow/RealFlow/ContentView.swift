//
//  ContentView.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-18.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoggedIn: Bool = true
    
    var body: some View {
        
        if isLoggedIn {
            TabView {
       
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
                
            
        } else {
            NavigationStack{
                LoginScreen(usernameInput: "", passwordInput: "")
            }
        }
    }
}

#Preview {
    ContentView()
}
