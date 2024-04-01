//
//  ProfileScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-03-16.
//

import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ScrollView{
            VStack{
                
                Image("profilepic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 33))
                    .foregroundStyle(Color.blue)
                
                HStack{
                    
                    Text("\(firebaseManager.firstName ?? "John")")
                        .bold()
                        .font(.title)
                    
                    Text("\(firebaseManager.lastName ?? "Doe")")
                        .bold()
                        .font(.title)
                        
                }.padding()
                
               
                
                Text("\(firebaseManager.username ?? "JohnDoe@gmail.com")")
                    .padding()
                
                Text("This is a text about me. lorem ipsum is a dummy text dummy dummy text")
                    .padding()
                
                
                
            }
           
        }
    }
}

#Preview {
    ProfileScreen()
}
