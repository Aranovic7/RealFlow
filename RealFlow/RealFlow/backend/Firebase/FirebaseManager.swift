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

struct UserData: Identifiable {
    var id = UUID()
    var username: String
    var profileImageURL: URL?
}

struct Message: Identifiable, Equatable {
    var id = UUID()
    var text: String
    var senderID: String
    var recipientUsername: String
    var timestamp: Date // Används för att ordna meddelandena efter tidpunkt
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
    
}




//struct UserWithLatestMessage {
//    var user: UserData
//    var latestMessage: Message?
//}

class FirebaseManager: ObservableObject {
    
    var db = Firestore.firestore() // Creating first instance of database
    var auth = Auth.auth() // Creating first instance of authentication
    let USER_DATA_COLLECTION = "users" // name of collection in firestore
    let USER_IMAGES_COLLECTION = "images"
    let storage = Storage.storage() // Initialize firebase Storage
    let MESSAGES_COLLECTION = "messages"
    
//    let RECENT_MESSAGES_COLLECTION = "recent_messages"
   
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
    
    @Published var usersData: [UserData] = []
    
    @Published var currentUserUID: String?
    
    var messagesListener: ListenerRegistration?
    
    var recentMessages: [Message] = []
    
    func addRecentMessage(_ message: Message) {
        recentMessages.append(message)
    }
    
    func latestMessageForUser(_ username: String) -> Message? {
        return recentMessages.last { $0.recipientUsername == username }
    }

    
    
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
        
        self.currentUserUID = currentUser // Spara det inloggade användarkontots ID
        
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
    
    func changePassword(currentPassword: String, newPassword: String){
        
        guard let currentUser = auth.currentUser else {return}
        
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email!, password: currentPassword)
        
        currentUser.updatePassword(to: newPassword) { error in
            if let error = error {
                print("Error updating password: \(error)")
            } else {
                print("Password updated successfully")
            }
            
        }
    }
    
    func changeProfileImage(_ image: UIImage) {
        
        guard let currentUser = auth.currentUser else {return}
        
        uploadImage(image) { result in
            switch result {
            case .success(let url):
                let userDataRef = self.db.collection(self.USER_DATA_COLLECTION).document(currentUser.uid)
                userDataRef.updateData(["profileImageURL": url.absoluteString]) { error in
                    if let error = error {
                        print("error updating data: \(error)")
                    } else {
                        print("Profile picture updated successfully")
                        self.profileImageURL = url
                    }
                }
            case.failure(let error):
                print("Fel vid uppladdning av profilbild: \(error)")
            }
            
        }
    }
    
    func fetchAllUsers(completion: @escaping ([UserData]) -> Void) {
        var usersData: [UserData] = [] // Skapa en tom array för att lagra användardata
        
        db.collection(USER_DATA_COLLECTION).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching all users: \(error)")
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                completion([])
                return
            }
            
            for document in documents {
                let userData = document.data()
                if let firstName = userData["firstName"] as? String,
                   let lastName = userData["lastName"] as? String,
                   let profileImageURLString = userData["profileImageURL"] as? String,
                   let profileImageURL = URL(string: profileImageURLString),
                   let username = userData["username"] as? String {
                    if document.documentID != self.currentUserUID {
                        let user = UserData(username: username, profileImageURL: profileImageURL)
                        usersData.append(user)
                    }
                   
                }
            }
            
            completion(usersData) // Skicka tillbaka den fyllda arrayen när alla användare har hämtats
        }
    }
    
    func saveMessage(message: String, toRecipient: String, completion: @escaping (Bool) -> Void) {
        
        guard let senderID = auth.currentUser?.uid else {
            completion(false)
            return
        }
        
        let messageData: [String: Any] = [
            "text": message,
            "senderID": senderID,
            "recipientUsername": toRecipient,
            "timestamp": FieldValue.serverTimestamp()
            ]
        
        db.collection(MESSAGES_COLLECTION).addDocument(data: messageData) { error in
            
            if let error = error {
                print("Fel vid sparande av meddelande: \(error)")
                completion(false)
            } else {
                completion(true)
            }
            
        }

    }
    
    func fetchMessages(completion: @escaping ([Message]) -> Void) {
        // Hämta dokument från Firestore-kollektionen för meddelanden
        // skapa en lyssnare för meddelanden
        messagesListener = db.collection(MESSAGES_COLLECTION)
            .order(by: "timestamp", descending: false)
            .addSnapshotListener{ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                // Om ingen fel uppstod, fortsätt med att hantera de hämtade dokumenten
                var messages: [Message] = []
                
            // Iterera genom dokumenten som hämtats från Firestore
            for document in querySnapshot!.documents {
                // Extrahera data från varje dokument och skapa Message-objekt
                let messageData = document.data()
                if let text = messageData["text"] as? String,
                   let senderID = messageData["senderID"] as? String,
                   let recipientUsername = messageData["recipientUsername"] as? String,
                   let timestamp = messageData["timestamp"] as? Timestamp {
                    // Skapa ett Message-objekt och lägg till det i arrayen av meddelanden
                    let message = Message(text: text, senderID: senderID, recipientUsername: recipientUsername, timestamp: timestamp.dateValue())
                   // print("message in func:  \(message)")
                    messages.append(message)
                        
                }
            }
                
//                DispatchQueue.main.async {
//                    self.messages = messages
//                }
            
            // När alla meddelanden har skapats och lagts till i arrayen, skicka tillbaka arrayen genom completion-handlaren
           // print("Fetched messages: \(messages)")
            completion(messages)
        }
    }
    
   
    
   
    
   
   

    
}
    



