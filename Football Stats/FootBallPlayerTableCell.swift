//
//  FootBallPlayerTableCell.swift
//  Football Stats
//
//  Created by Chakri on 21/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallPlayerTableCell: UITableViewCell {

    @IBOutlet var lost10: UIView!
    @IBOutlet var lost9: UIView!
    @IBOutlet var lost8: UIView!
    @IBOutlet var lost7: UIView!
    @IBOutlet var lost6: UIView!
    @IBOutlet var lost5: UIView!
    @IBOutlet var lost4: UIView!
    @IBOutlet var lost3: UIView!
    @IBOutlet var lost2: UIView!
    @IBOutlet var lost1: UIView!
    @IBOutlet var checkbutton: UIButton!
    @IBOutlet var profilename: UILabel!
    @IBOutlet var profileimage: UIImageView!
    @IBOutlet var playernum: UILabel!
    
    @IBOutlet var borderview: UIView!
    @IBOutlet var serialnum: UILabel!
    
    override func awakeFromNib()
    
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
