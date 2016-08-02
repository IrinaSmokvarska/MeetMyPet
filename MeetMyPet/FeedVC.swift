//
//  FeedVC.swift
//  MeetMyPet
//
//  Created by Darko Spasovski on 7/28/16.
//  Copyright © 2016 Irina Smokvarska. All rights reserved.
//

import UIKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.getPostsFromDB { 
            self.tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.sharedModel.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            
            let post = DataModel.sharedModel.posts[indexPath.row] as! Post
            cell.configureCell(post)
            return cell
        } else {
            return PostCell()
        }
        
    }

}
