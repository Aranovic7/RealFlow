//
//  FirebaseManager.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-27.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseManager {
    
    // Funktion för att registrera en användare
       static func registerUser(registerUsernameInput: String, registerPasswordInput: String, repeatPasswordInput: String) {
            if registerPasswordInput == repeatPasswordInput {
                Auth.auth().createUser(withEmail: registerUsernameInput, password: registerPasswordInput) { authResult, error in
                    if let error = error {
                        print("Fel vid registrering av användare: \(error.localizedDescription)")
                    } else {
                        print("Användare registrerad framgångsrikt")
                        // Här kan du navigera till nästa skärm eller utföra andra åtgärder efter framgångsrik registrering
                        
                        // lagra användarinformation i firestore
                        guard let userID = authResult?.user.uid else {
                            print("Användarens UID saknas")
                            return
                        }
                        
                        let userData = [
                            "username": registerUsernameInput,
                            "password": registerPasswordInput,
                            "createdAt": FieldValue.serverTimestamp()
                            // lägg till andra användarattribut här om det behövs
                        ]
                        
                        let db = Firestore.firestore()
                        db.collection("users").document(userID).setData(userData) { error in
                            if let error = error {
                                print("Fel vid uppladdning av användardata till Firestore: \(error)")
                            } else {
                                print("Användardata uppladdad till Firestore")
                            }
                            
                        }
                        
                    }
                }
            } else {
                print("Lösenorden matchar inte")
                // Här kan du meddela användaren om att lösenorden inte matchar
            }
        }
    
   static func login(usernameInput: String, passwordInput: String) {
        Auth.auth().signIn(withEmail: usernameInput, password: passwordInput) { authResult, error in
            if let error = error {
                print("Failed to log in: \(error)")
            } else {
                print("Log in success")
            }
            
        }
    }
    }
    



