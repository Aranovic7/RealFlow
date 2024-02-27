//
//  FirebaseManager.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-27.
//

import Foundation
import Firebase

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
                    }
                }
            } else {
                print("Lösenorden matchar inte")
                // Här kan du meddela användaren om att lösenorden inte matchar
            }
        }
    }
    



