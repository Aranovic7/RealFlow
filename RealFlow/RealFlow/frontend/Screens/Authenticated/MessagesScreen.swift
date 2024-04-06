//
//  MessagesScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-28.
//

import SwiftUI

struct MessagesScreen: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    var body: some View {
        VStack{
            TopNavBar()
            ScrollView{
                ForEach(0..<10, id: \.self) { num in
                    VStack{
                        HStack(spacing: 16){
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 44).stroke(lineWidth: 1))
                            VStack(alignment: .leading){
                                Text("Username")
                                    .font(.system(size: 16) .weight(.bold))
                                Text("Message")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Color.gray)
                            }
                            Spacer()
                            Text("22d")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        Divider()
                        .padding(.vertical, 8)
                    } .padding(.horizontal)
                   
                }
            } 
           
        }.overlay(
            NewMessagesBtn(), alignment: .bottom
                
            )
//        .onAppear{
//            firebaseManager.fetchUserData(userEmail: firebaseManager.registerUsernameInput)
//        }

    }
}

#Preview {
    MessagesScreen()
}
