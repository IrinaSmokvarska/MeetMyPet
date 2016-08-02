//
//  DataService.swift
//  MeetMyPet
//
//  Created by Darko Spasovski on 7/27/16.
//  Copyright © 2016 Irina Smokvarska. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    

    private init (){};
    
    var ref:FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    func getUsersFromDB(){
        self.ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            for child in snapshot.children{
                if child.isKindOfClass(FIRDataSnapshot){
                    let test = child as! FIRDataSnapshot;
                    print(test.value);
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func saveUser(username: String, password: String){
        let key = ref.child("users").childByAutoId().key
        let user = ["username": username,
                    "password": password]
        let childUpdates = ["/users/\(key)": user]
        ref.updateChildValues(childUpdates)
    }
    
    func saveFacebookUser(uid: String, user: Dictionary<String, String>) {
        self.ref.child("users/\(uid)").setValue(user)
        
    }
    
    func getPostsFromDB(completion: () -> Void){
        self.ref.child("posts").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            for child in snapshot.children{
                if child.isKindOfClass(FIRDataSnapshot){
                    let test = child as! FIRDataSnapshot;
                    DataModel.sharedModel.parsePostSnapshot(test)
                   
                }
                
            }
            completion()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func savePost(content: String, imageUrl: String, likes: String) {
        let key = ref.child("posts").childByAutoId().key
        let post = ["description": content, "imageUrl": imageUrl, "likes": likes]
        let childUpdates = ["/posts/\(key)": post]
        ref.updateChildValues(childUpdates)
    }
    
    

    
}