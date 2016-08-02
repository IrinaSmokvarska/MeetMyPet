//
//  PostCell.swift
//  MeetMyPet
//
//  Created by Darko Spasovski on 7/28/16.
//  Copyright © 2016 Irina Smokvarska. All rights reserved.
//

import UIKit
import Foundation

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var petImg: UIImageView!
    @IBOutlet weak var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
        
        petImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getDataFromUrl(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    func downloadImage(url: NSURL){
        print("Download Started")
        getDataFromUrl(url) { (data, response, error)  in
            guard let data = data where error == nil else { return }
            
            dispatch_async(dispatch_get_main_queue(), { 
                print(response?.suggestedFilename ?? url.lastPathComponent ?? "")
                print("Download Finished")
                self.petImg.image = UIImage(data: data)
            });
        }
    }
    
    func configureCell(post: Post) {
        textView.text = post.content
        downloadImage(NSURL(string: post.imageUrl)!)
    }

}
