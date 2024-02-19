//
//  LoginScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-19.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        VStack{
            
            VStack{
                
                Text("Welcome to RealFlow")
                    .font(.title)
                    .bold()
                    .padding()
                
                Spacer()
                
                Text("This app is made for you to have an easier communication with friends and family!")
                    .bold()
                
                Spacer()
                
                Button(action: {
                    print("Button 'sign in' was pressed")
                }, label: {
                    Text("Sign in")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 250, height: 50)
                        .background(Color.black)
                        .clipShape(.rect(cornerRadius: 10))
                })
                
                Button(action: {
                    print("Button 'register' was pressed")
                }, label: {
                    Text("Register")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 250, height: 50)
                        .background(Color.black)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                })
                
                
                Spacer()
                
                Text("Made by Aran Ali")
                
                
                    
                  
            }
           
        
        }
    }
}

#Preview {
    LoginScreen()
}
