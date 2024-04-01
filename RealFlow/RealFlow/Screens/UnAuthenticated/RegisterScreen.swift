//
//  RegisterScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-19.
//

import SwiftUI

struct RegisterScreen: View {
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        
        VStack{
            
           
                Text("Create your account")
                    .font(.title)
                    .bold()
                    .padding()
            
            TextField("Firstname", text: $firebaseManager.firstName)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
            
            TextField("Lastname", text: $firebaseManager.lastName)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
            TextField("Username", text: $firebaseManager.registerUsernameInput)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
            TextField("Password", text: $firebaseManager.registerPasswordInput)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
            TextField("Repeat password", text: $firebaseManager.repeatPasswordInput)
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
                    firebaseManager.registerUser(registerUsernameInput: firebaseManager.registerUsernameInput, registerPasswordInput: firebaseManager.registerPasswordInput, repeatPasswordInput: firebaseManager.repeatPasswordInput, firstName: firebaseManager.firstName, lastName: firebaseManager.lastName)
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
    RegisterScreen()
}
