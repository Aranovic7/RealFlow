//
//  LoginScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-19.
//

import SwiftUI

struct LoginScreen: View {
    
    @State var usernameInput: String
    @State var passwordInput: String
    
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
                    .padding()
                
                Spacer()
                
                TextField("Username", text: $usernameInput)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
                TextField("Password", text: $passwordInput)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
                Button(action: {
                    print("Button 'sign in' was pressed")
                    FirebaseManager.login(usernameInput: usernameInput, passwordInput: passwordInput)
                }, label: {
                    Text("Sign in")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 250, height: 50)
                        .background(Color.black)
                        .clipShape(.rect(cornerRadius: 10))
                })
                
                Spacer()
                
                Text("Don't have an account? Register now")
                
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
                       
                })
                
                
                Spacer()
                
                Text("Made by Aran Ali")
                  
            }
           
        
        }
    }
}

#Preview {
    LoginScreen(usernameInput: "", passwordInput: "")
}
