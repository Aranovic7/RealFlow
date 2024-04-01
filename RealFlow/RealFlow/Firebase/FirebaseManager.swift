//
//  FirebaseManager.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-27.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseManager: ObservableObject {
    
//    var db = Firestore.firestore() // Creating our first instance of our database
//    var auth = Auth.auth() // Creating our first instance of our authentication
//    var USER_DATA_COLLECTION = "users" // the name of our collection in firestore -> to reduce risks of spelling misstakes
//    var dbListener: ListenerRegistration? // Represents our listener
//    var isInitialPrint = true
//    @Published var users: [UserDetails] = []
//    @Published var userName: String = ""
//    @Published var didFetchData: Bool = false
//    @Published var didFetchHomeData: Bool = false
//    @Published var currentUser: User?
//    @Published var currentUserData: UserData?
//    @Published var historiaValue: Int = 0
//    @Published var sportValue: Int = 0
//    @Published var geografiValue: Int = 0
//    @Published var teknikValue: Int = 0
//    @Published var selectedIcon: String = ""
//    @Published var alertMessage = ""
//    @Published var name: String = ""
//    @Published var email: String = ""
//    @Published var password: String = ""
//    @Published var confirmPassword: String = ""
    
    var db = Firestore.firestore() // Creating first instance of database
    var auth = Auth.auth() // Creating first instance of authentication
    var USER_DATA_COLLECTION = "users" // name of collection in firestore
    
    @Published var isLoggedIn: Bool = false
    @Published var usernameInput: String = ""
    @Published var passwordInput: String = ""
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var username: String = ""
    
    @Published var registerUsernameInput: String = ""
    @Published var registerPasswordInput: String = ""
    @Published var repeatPasswordInput: String = ""
    
    
    // Funktion för att registrera en användare
    func registerUser(registerUsernameInput: String, registerPasswordInput: String, repeatPasswordInput: String, firstName: String, lastName: String) {
            if registerPasswordInput == repeatPasswordInput {
                auth.createUser(withEmail: registerUsernameInput, password: registerPasswordInput) { authResult, error in
                    if let error = error {
                        print("Fel vid registrering av användare: \(error)")
                    } else {
                        print("Användare registrerad framgångsrikt")
                       

                        // lagra användarinformation i firestore
                        guard let userID = authResult?.user.uid else {
                            print("Användarens UID saknas")
                            return
                        }
                        
                        let userData = [
                            "username": registerUsernameInput,
                            "password": registerPasswordInput,
                            "createdAt": FieldValue.serverTimestamp(),
                            "firstName": firstName,
                            "lastName": lastName
                            // lägg till andra användarattribut här om det behövs
                        ]
                        
                        
                        self.db.collection(self.USER_DATA_COLLECTION).document(userID).setData(userData) { error in
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
    
    func login(usernameInput: String, passwordInput: String) {
        auth.signIn(withEmail: usernameInput, password: passwordInput) { authResult, error in
            if let error = error {
                print("Failed to log in: \(error)")
            } else {
                print("Log in success")
                self.isLoggedIn = true
                print(self.isLoggedIn)
            }
            
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
            // återställ eventuell data
           isLoggedIn = false
        } catch let error {
            print("error trying to sign out: \(error)")
        }
    }
    
    
    func fetchUserData() {
        
        guard let currentUser = auth.currentUser?.uid else { return }
        
        let docRef = db.collection(USER_DATA_COLLECTION).document(currentUser)
        
        docRef.getDocument { (document, error ) in
            if let document = document, document.exists {
                if let data = document.data(), let firstName = data["firstName"] as? String, let lastName = data["lastName"] as? String, let username = data["username"] as? String {
                    self.firstName = firstName
                    self.lastName = lastName
                    self.username = username
                }
            } else {
                print("Document does not exist")
            }
            
        }
        
       
        
//        func fetchProfileUserData() {
//            if let user = currentUser {
//                let uid = user.uid
//                let docRef = db.collection(USER_DATA_COLLECTION).document(uid)
//
//                docRef.getDocument { (document, error) in
//                    if let document = document, document.exists {
//                        if let data = document.data() {
//                            if let selectedIcon = data["selectedIcon"] as? String {
//                                DispatchQueue.main.async {
//                                    self.selectedIcon = selectedIcon
//                                    print("Get icon \(selectedIcon)")
//                                }
//                            }
//
//                            if let scores = data["scores"] as? [String: Int] {
//                                DispatchQueue.main.async {
//                                    self.historiaValue = scores["Historia"] ?? 0
//                                    self.teknikValue = scores["Teknik"] ?? 0
//                                    self.sportValue = scores["Sport"] ?? 0
//                                    self.geografiValue = scores["Geografi"] ?? 0
//                                    self.didFetchData = true
//                                }
//                            } else {
//                                DispatchQueue.main.async {
//                                    self.historiaValue = 0
//                                    self.teknikValue = 0
//                                    self.sportValue = 0
//                                    self.geografiValue = 0
//                                    self.didFetchData = true
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
    }
    



