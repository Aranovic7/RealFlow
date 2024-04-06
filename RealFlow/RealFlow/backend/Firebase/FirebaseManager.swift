//
//  FirebaseManager.swift
//  RealFlow
//
//  Created by Aran Ali on 2024-02-27.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

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
    
    @Published var profileImageURL: String = ""
    @Published var profileImage: UIImage = .maleAvatar
    
    
    // Funktion för att registrera en användare
    func registerUser(registerUsernameInput: String, registerPasswordInput: String, repeatPasswordInput: String, firstName: String, lastName: String, profileImage: UIImage, completion: @escaping (Bool) -> ()) {
      if registerPasswordInput == repeatPasswordInput {
        auth.createUser(withEmail: registerUsernameInput, password: registerPasswordInput) { authResult, error in
          if let error = error {
            print("Fel vid registrering av användare: \(error)")
            completion(false) // Ange misslyckad registrering i closure
          } else {
            print("Användare registrerad framgångsrikt")

            // Lagra användarinformation i Firestore
            guard let userID = authResult?.user.uid else {
              print("Användarens UID saknas")
              completion(false) // Ange misslyckad registrering i closure
              return
            }

            // Konvertera UIImage till Data
            guard let imageData = profileImage.jpegData(compressionQuality: 0.5) else {
              print("Fel vid konvertering av profilbild till Data")
              completion(false) // Ange misslyckad registrering i closure
              return
            }

            // Skapa en referens till databasen
            let storage = Storage.storage()
            let storageRef = storage.reference().child("profile_images/\(userID)")

            // Ladda upp bilden till samma referens i databasen
            let uploadImage = storageRef.putData(imageData, metadata: nil) { metadata, error in
              if error == nil, metadata != nil {
                storageRef.downloadURL { url, error in
                  // success
                  if let url = url {
                    print("Bildens URL: \(url)")

                    // Uppdatera användardata dictionary
                    let userData = [
                      "username": registerUsernameInput,
                      "password": registerPasswordInput,
                      "createdAt": FieldValue.serverTimestamp(),
                      "firstName": firstName,
                      "lastName": lastName,
                      "profileImageURL": url.absoluteString,
                    ]

                    // Spara användardata till Firestore
                    self.db.collection(self.USER_DATA_COLLECTION).document(userID).setData(userData) { error in
                      if let error = error {
                        print("Fel vid uppladdning av användardata till Firestore: \(error)")
                        completion(false) // Ange misslyckad registrering i closure
                      } else {
                        print("Användardata uppladdad till Firestore")
                        completion(true) // Ange framgångsrik registrering i closure
                      }
                    }
                  } else {
                    print("Fel vid hämtning av bildens URL")
                    completion(false) // Ange misslyckad registrering i closure
                  }
                }
              } else {
                // fail
                print("Fel vid uppladdning av profilbild till Firebase: \(error)")
                completion(false) // Ange misslyckad registrering i closure
              }
            }
          }
        }
      } else {
        print("Lösenorden matchar inte")
        completion(false) // Ange misslyckad registrering i closure
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
                if let data = document.data(), let firstName = data["firstName"] as? String, let lastName = data["lastName"] as? String, let username = data["username"] as? String, let profileImageURL = data["selectedImage"] as? String {
                    self.firstName = firstName
                    self.lastName = lastName
                    self.username = username
                    self.profileImageURL = profileImageURL
                    
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
    



