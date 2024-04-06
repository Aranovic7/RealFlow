//
//  SettingsScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-03-16.
//

import SwiftUI

struct SettingsScreen: View {
    
    @State var navigateToAccount: Bool = false
    @State var navigateToNotifications: Bool = false
    @State var navigateToApperance: Bool = false
    @State var navigateToPrivacy: Bool = false
    @State var navigateToHelp: Bool = false
    @State var navigateToAbout: Bool = false
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        
        VStack{
            
            Text("Settings")
                .font(.title)
                .bold()
                .padding()
            
            ScrollView{
                
            VStack (spacing: 30) {
                
                HStack{
                    Text("Allmänt:")
                        .bold()
                        .font(.title3)
                        .padding(.leading, 40)
                    
                    Spacer()
                    
                } .padding(.top)
               
                    
                    HStack{
                        
                        Image(systemName: "flag")
                            .padding(.leading, 40)
                        
                        Text("Språkinställningar")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .padding(.trailing, 40)
                        
                    } 
                    .onTapGesture {
                        navigateToAccount = true
                    }
                    
                    HStack{
                        
                        Image(systemName: "bell.and.waves.left.and.right")
                            .padding(.leading, 40)
                        
                        Text("Notifications")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .padding(.trailing, 40)
                        
                    }
                    .onTapGesture {
                        navigateToNotifications = true
                    }
                    
                    HStack{
                        
                        Image(systemName: "eye")
                            .padding(.leading, 40)
                        
                        Text("Apperance")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .padding(.trailing, 40)
                        
                    }
                    .onTapGesture {
                        navigateToApperance = true
                    }
                
                    Divider()
                        .frame(width: 315)
                
                HStack{
                    Text("Help & Support:")
                        .bold()
                        .font(.title3)
                        .padding(.leading, 40)
                    Spacer()
                }
                
                    HStack{
                        
                        Image(systemName: "beats.headphones")
                            .padding(.leading, 40)
                        
                        Text("Contact us")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .padding(.trailing, 40)
                        
                    }
                    .onTapGesture {
                        navigateToHelp = true
                    }
                    
                    HStack{
                        
                        Image(systemName: "questionmark.circle")
                            .padding(.leading, 40)
                        
                        Text("About")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .padding(.trailing, 40)
                        
                    }
                    .onTapGesture {
                        navigateToAbout = true
                    }
                
                HStack{
                    Button(action: {
                        firebaseManager.logout()
                        print("signing out...")
                    }) {
                        Text("Sign out")
                        Image(systemName: "door.left.hand.open")
                    }
                    
                } 
                .foregroundStyle(Color.red)
                .padding()
                  
                    
                }
            }
        }
    }
}

#Preview {
    SettingsScreen()
}
