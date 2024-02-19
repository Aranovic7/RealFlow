//
//  RegisterScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-19.
//

import SwiftUI

struct RegisterScreen: View {
    
    @State var usernameInput: String
    @State var passwordInput: String
    
    @State var repeatPasswordInput: String
    var body: some View {
        
        VStack{
            
            VStack{
                
                Text("Create your account")
                    .font(.title)
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
                
                TextField("Repeat password", text: $repeatPasswordInput)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    print("Button 'create account' was pressed")
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
                
                Text("Already have an account? Sign in")
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        print("Go back to LoginScreen")
                    }
            }
        }
    }
}

#Preview {
    RegisterScreen(usernameInput: "", passwordInput: "", repeatPasswordInput: "")
}
