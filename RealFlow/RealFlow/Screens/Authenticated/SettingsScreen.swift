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
    
    var body: some View {
        
        VStack{
            Text("Settings")
                .font(.title)
                .bold()
                .padding()
            
            HStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.trailing, 25)
                    
                
                VStack(alignment: .leading){
                    Text("NAME LASTNAME")
                    Text("@Username")
                }
               
            } .padding(.bottom)
            
            
            ScrollView{
                
            VStack (spacing: 25) {
                
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
                        
                        Image(systemName: "chevron.right")
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
                        
                        Image(systemName: "chevron.right")
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
                        
                        Image(systemName: "chevron.right")
                            .padding(.trailing, 40)
                        
                    }
                    .onTapGesture {
                        navigateToApperance = true
                    }
                
                    Divider()
                        .frame(width: 315)
                
                HStack{
                    Text("Meddelanden:")
                        .bold()
                        .font(.title3)
                        .padding(.leading, 40)
                    Spacer()
                }
                    
                    HStack{
                        
                        Image(systemName: "speaker.wave.2")
                            .padding(.leading, 40)
                        
                        Text("Ljudinställningar")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .padding(.trailing, 40)
                        
                    }
                    .onTapGesture {
                        navigateToPrivacy = true
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
                        
                        Image(systemName: "chevron.right")
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
                        
                        Image(systemName: "chevron.right")
                            .padding(.trailing, 40)
                        
                    }
                    .onTapGesture {
                        navigateToAbout = true
                    }
                
                HStack{
                    Text("Sign out")
                    Image(systemName: "door.left.hand.open")
                } 
                .foregroundStyle(Color.red)
                .padding()
                  
                    
                }
            }
        }
       
//        Form {
//            
//            Section(header: Text("Notifications")) {
//                Toggle(isOn: .constant(true), label: {
//                    Text("Enable notifications")
//                })
//                Toggle(isOn: .constant(true), label: {
//                    Text("Få nyhetsbrev från RealFlow")
//                })
//            }
//            
//            Section(header: Text("Plats")) {
//                Toggle(isOn: .constant(false), label: {
//                    Text("Tillåt åtkomst för platsinfo")
//                })
//            }
//            
//            Section(header: Text("Account")) {
//                Toggle(isOn: .constant(true), label: {
//                    Text("Show online status")
//                })
//                
//                HStack{
//                    Text("Log out")
//                    Image(systemName: "power")
//                }  .foregroundStyle(Color.red)
//            }
//            
//            Section(header: Text("Privacy & Security")) {
//                Toggle(isOn: .constant(true), label: {
//                    Text("Enable notifications")
//                })
//            }
//                            
//        }
    }
}

#Preview {
    SettingsScreen()
}
