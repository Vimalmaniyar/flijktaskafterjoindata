//
//  serviceTableViewCell.swift
//  Flik Task
//
//  Created by Sandeep on 5/9/20.
//  Copyright © 2020 vimal. All rights reserved.
//

import UIKit

class serviceTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var profession: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
