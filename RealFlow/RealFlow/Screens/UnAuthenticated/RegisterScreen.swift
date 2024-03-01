//
//  RegisterScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-19.
//

import SwiftUI

struct RegisterScreen: View {
    
    @State var registerUsernameInput: String
    @State var registerPasswordInput: String
    
    @State var repeatPasswordInput: String
    var body: some View {
        
        VStack{
            
           
                
                Text("Create your account")
                    .font(.title)
                    .bold()
                    .padding()
        
             
              
                
                TextField("Username", text: $registerUsernameInput)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
                TextField("Password", text: $registerPasswordInput)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
                TextField("Repeat password", text: $repeatPasswordInput)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
              
                
                Text("Already have an account? Sign in")
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        print("Go back to LoginScreen")
                    }
                
                Spacer()
                
                Button(action: {
                    print("Button 'create account' was pressed")
                    FirebaseManager.registerUser(registerUsernameInput: registerUsernameInput, registerPasswordInput: registerPasswordInput, repeatPasswordInput: repeatPasswordInput)
                }, label: {
                    Text("Create account")
                        .bold()
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 250, height: 50)
                        .background(Color.black)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                })
                
               Spacer()
                
                
            
        }
    }
}

#Preview {
    RegisterScreen(registerUsernameInput: "", registerPasswordInput: "", repeatPasswordInput: "")
}
