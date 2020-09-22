//
//  FootBallPlayerTableCell.swift
//  Football Stats
//
//  Created by Chakri on 21/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallPlayerTableCell: UITableViewCell {

    @IBOutlet var profilename: UILabel!
    @IBOutlet var profileimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
