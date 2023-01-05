//
//  DatabaseManager.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/3/23.
//

import Foundation
import FirebaseAuth

final class DatabaseManager{
    ///Shared instance of class
//    public static let shared = DatabaseManager()
//
//    private let database = Database.database(url: "https://pokemontestxcaret-default-rtdb.firebaseio.com/").reference()
//    static func safeEmail(emailAddress: String) -> String{
//        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
//        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
//        return safeEmail
//    }
//
//    public func userExists(with email:String, completion: @escaping ((Bool) -> Void)){
//
//        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
//        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
//            guard snapshot.value as? [String : Any] != nil else{
//                print("user doesnt exist")
//                completion(false)
//                return
//            }
//            print(snapshot.value!)
//            print("user exists")
//            completion(true)
//        })
//    }
    
    public func createUser(with email:String, password: String, completion: @escaping(_ success: Bool) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {  authResult, error in
            guard authResult != nil, error == nil else{
                print("Error creating user")
                return
            }
            
            if let user = authResult?.user {
                completion(true)
            } else {
                completion(false)
            }
          
        })
    }
    
    public func signIn(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
