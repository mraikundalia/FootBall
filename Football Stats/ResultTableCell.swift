//
//  ResultTableCell.swift
//  Football Stats
//
//  Created by Chakri on 29/10/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class ResultTableCell: UITableViewCell {

    @IBOutlet var footballside: UILabel!
    @IBOutlet var lbldate: UILabel!
    @IBOutlet var pitchtbc: UILabel!
    @IBOutlet var totalgoals: UILabel!
    @IBOutlet var borderview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
