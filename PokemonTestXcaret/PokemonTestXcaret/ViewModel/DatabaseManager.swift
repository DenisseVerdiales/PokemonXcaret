//
//  DatabaseManager.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/3/23.
//

import Foundation
import FirebaseAuth

final class DatabaseManager{

    public func createUser(with email:String, password: String, completion: @escaping(_ success: Bool) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {  authResult, error in
            guard authResult != nil, error == nil else{
                return
            }
            
            if (authResult?.user) != nil {
                completion(true)
            } else {
                completion(false)
            }
          
        })
    }
    
    public func signIn(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    public func signOut(completion: @escaping (_ success: Bool) -> Void) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
                completion(true)
        } catch {
            completion(false)
        }
    }
}
