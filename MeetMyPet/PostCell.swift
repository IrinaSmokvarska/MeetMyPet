//
//  PostCell.swift
//  MeetMyPet
//
//  Created by Darko Spasovski on 7/28/16.
//  Copyright © 2016 Irina Smokvarska. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var petImg: UIImageView!

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

}
