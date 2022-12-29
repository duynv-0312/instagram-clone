//
//  AuthManager.swift
//  Instagram
//
//  Created by Duy Nguyễn on 19/11/2022.
//
import FirebaseAuth
public class AuthManager {
    static let shared = AuthManager()

    public func registerNewUser(username: String, email: String, password: String,completion:@escaping (Bool)->Void){
         /* - check if username is available
            - check if email is vailable
            - create account
            - insert account to database
        n*/
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - create acccount
                 - insert acount to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                    }
                    // insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            completion(false)
                            return
                        }
                    }
                }
            }
            
            else {
                //either email or username does not exist
                completion(false)
            }
            
        }
        
    }
    
    public func loginUser(username: String?,
                          email: String?,
                          password: String,
                          completion: @escaping(Bool) ->Void){
        if let email = email {
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            //username log in
            print(username)
        }
    }
    /// attempt to log out firebasse user
    public func logOut(completion: (Bool)-> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
    
}
