//
//  DatabaseManager .swift
//  Instagram
//
//  Created by Duy Nguyễn on 19/11/2022.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    // Check if username is avaiable
    // parmeters
    // - email:String represeting email
    // - username : String representing username
    public func canCreateNewUser(with email :String, username: String, completion:(Bool) -> Void){
        completion(true)
    }
    // -insert new user data to database
    //- Parameters
    // -email : string represeting email
    // - username  : string representing username
    // - completion  : async callback for result if database entry succeeded
    
    
    public func insertNewUser(with email: String,username : String, completion : @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                //succeeded
                completion(true)
                return
            }
            else {
                //failed
                completion(false)
                return
            }
        }
    }
    
}
