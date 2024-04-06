//
//  RegisterScreen.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-19.
//

import SwiftUI
import PhotosUI

struct RegisterScreen: View {
    
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @State var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        VStack{
        
                Text("Create your account")
                    .font(.title)
                    .bold()
                    .padding()
            
            HStack(spacing: 20){
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    Image(uiImage: firebaseManager.profileImage ?? .maleAvatar)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                }
               
                
                VStack(alignment: .leading){
                    Text("John Doe")
                        .font(.largeTitle.bold())
                    
                    Text("iOS Developer")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                }
                
                Spacer()
                      
                     
            }
            .padding(.leading, 30)
            .onChange(of: photosPickerItem) { _, _ in
                Task {
                    if let photosPickerItem,
                       let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            firebaseManager.profileImage = image
                        }
                    }
                    
                    photosPickerItem = nil
                }
                
            }
            
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
                    
                    firebaseManager.registerUser(registerUsernameInput: firebaseManager.registerUsernameInput, registerPasswordInput: firebaseManager.registerPasswordInput, repeatPasswordInput: firebaseManager.repeatPasswordInput, firstName: firebaseManager.firstName, lastName: firebaseManager.lastName, profileImage: firebaseManager.profileImage)
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
