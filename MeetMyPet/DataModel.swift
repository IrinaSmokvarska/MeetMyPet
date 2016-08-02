//
//  DataModel.swift
//  MeetMyPet
//
//  Created by Darko Spasovski on 8/2/16.
//  Copyright © 2016 Irina Smokvarska. All rights reserved.
//

import Foundation
import Firebase

class DataModel {
    static let sharedModel = DataModel()
    
    private init (){}
    
    var posts: NSMutableArray = []
    
    func parsePostSnapshot(snapshot: FIRDataSnapshot) {
        var post: Post = Post()
        print(snapshot.value!["description"]);
        
        post.content = snapshot.childSnapshotForPath("description").value as! String
        post.imageUrl = snapshot.childSnapshotForPath("imageUrl").value as! String
        post.likes = snapshot.childSnapshotForPath("likes").value as! NSNumber
   
        posts.addObject(post)
        
    }
    
}