//
//  ProfileTableViewCell.swift
//  Project_224
//
//  Created by Gwalsh on 2019-04-25.
//  Copyright © 2019 Gary Walsh. All rights reserved.
//

import UIKit

/// Cell class having two variable of the profileImageView and nameLabel.
class ProfileTableViewCell: UITableViewCell {
    
    /// Variables declaration.
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /// Selected of variables function
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
