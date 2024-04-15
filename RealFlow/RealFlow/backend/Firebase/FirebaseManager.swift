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
    
    var db = Firestore.firestore() // Creating first instance of database
    var auth = Auth.auth() // Creating first instance of authentication
    let USER_DATA_COLLECTION = "users" // name of collection in firestore
    let USER_IMAGES_COLLECTION = "images"
    let storage = Storage.storage() // Initialize firebase Storage
    
    @Published var isLoggedIn: Bool = false
    @Published var usernameInput: String = ""
    @Published var passwordInput: String = ""
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var username: String = ""
    
    @Published var registerUsernameInput: String = ""
    @Published var registerPasswordInput: String = ""
    @Published var repeatPasswordInput: String = ""
    
    @Published var profileImage: UIImage?
    @Published var profileImageURL: URL?
    
    // Funktion för att registrera en användare
    func uploadImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Fel vid konvertering av bild till data"])))
            return
        }
        
        let imageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
            } else {
                imageRef.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Ingen URL returnerad"])))
                    }
                }
            }
        }
    }

    func registerUser(registerUsernameInput: String, registerPasswordInput: String, repeatPasswordInput: String, firstName: String, lastName: String, profileImage: UIImage?) {
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
                    
                    var userData: [String: Any] = [
                        "username": registerUsernameInput,
                        "password": registerPasswordInput,
                        "createdAt": FieldValue.serverTimestamp(),
                        "firstName": firstName,
                        "lastName": lastName
                    ]
                    
                    if let profileImage = profileImage {
                        // Ladda upp profilbilden
                        self.uploadImage(profileImage) { result in
                            switch result {
                            case .success(let url):
                                // Spara bildens URL i användardatan
                                userData["profileImageURL"] = url.absoluteString
                                
                                // Spara användarinformation i Firestore
                                self.db.collection(self.USER_DATA_COLLECTION).document(userID).setData(userData) { error in
                                    if let error = error {
                                        print("Fel vid uppladdning av användardata till Firestore: \(error)")
                                    } else {
                                        print("Användardata uppladdad till Firestore")
                                        print("registerUsernameInput: \(registerUsernameInput)")
                                    }
                                }
                            case .failure(let error):
                                print("Fel vid uppladdning av profilbild: \(error)")
                            }
                        }
                    } else {
                        // Om ingen profilbild valdes, spara bara användarinformationen
                        self.db.collection(self.USER_DATA_COLLECTION).document(userID).setData(userData) { error in
                            if let error = error {
                                print("Fel vid uppladdning av användardata till Firestore: \(error)")
                            } else {
                                print("Användardata uppladdad till Firestore")
                                print("registerUsernameInput: \(registerUsernameInput)")
                            }
                        }
                    }
                }
            }
        } else {
            print("Lösenorden matchar inte")
        }
    }

    
    func login(usernameInput: String, passwordInput: String) {
        auth.signIn(withEmail: usernameInput, password: passwordInput) { authResult, error in
            if let error = error {
                print("Failed to log in: \(error)")
            } else {
                print("Log in success")
                print("Logged in with: \(self.auth.currentUser?.email)")
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
        
        print("currentUser in fetchUserData: \(currentUser)")
        
        db.collection(USER_DATA_COLLECTION).document(currentUser).getDocument{ documentSnapshot, error in
            if let error = error {
                print("Error fetching data: \(error)")
            } else if let document = documentSnapshot, document.exists {
                if let data = document.data(), let firstName = data["firstName"] as? String, let lastName = data["lastName"] as? String, let username = data["username"] as? String {
                    self.firstName = firstName
                    self.lastName = lastName
                    self.username = username
                    
                    if let profileImageURLString = data["profileImageURL"] as? String {
                        self.profileImageURL = URL(string: profileImageURLString)
                    }
                }
            }
        }
        
    }

    
}
    



