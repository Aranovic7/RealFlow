//
//  BottomNavBar.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-28.
//

import SwiftUI

struct BottomNavBar: View {
    
    @State var isMessagesSelected: Bool = false
    @State var isProfileSelected: Bool = false
    @State var isSettingsSelected: Bool = false
    
    var body: some View {
        
        VStack{
            
            Divider()
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    isMessagesSelected.toggle()
                  
                }, label: {
                    VStack(alignment: .center, spacing: 4){
                        
                        Image(systemName: isMessagesSelected ? "bubble.left.fill" : "bubble.left")
                            .font(.system(size: 25))
                            
                        
                        Text("Messages")
                            .font(.system(size: 11))
                            
                    }
                })
                .padding()
                
                Spacer()
                
                Button(action: {
                    isProfileSelected.toggle()
                }, label: {
                    VStack(alignment: .center, spacing: 4){
                        
                        Image(systemName: isProfileSelected ? "person" : "person.fill")
                            .font(.system(size: 25))
                        
                        Text("Profile")
                            .font(.system(size: 11))
                            
                    }
                })
                .padding()
                
                Spacer()
                
                Button(action: {
                    isSettingsSelected.toggle()
                }, label: {
                    VStack(alignment: .center, spacing: 4){
                        
                        Image(systemName: "gear")
                            .font(.system(size: 25))
                        
                        Text("Settings")
                            .font(.system(size: 11))
                            
                    }
                })
                
                Spacer()
            }
            .frame(width: 400,height: 70)
            .background(Color.clear)
        }
    }
}

#Preview {
    BottomNavBar()
}
