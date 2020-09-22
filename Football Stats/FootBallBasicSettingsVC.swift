//
//  FootBallBasicSettingsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallBasicSettingsVC: UIViewController
{

    @IBOutlet var btncolorselect: UIButton!
    
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var btnteam2shirtcolor: UILabel!
    
    @IBOutlet var btnteam2color: UIButton!
    
    @IBOutlet var btnselectdate: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btncolorselect.clipsToBounds = true
        btncolorselect.layer.cornerRadius = 9
        btncolorselect.layer.borderWidth = 1;
        btncolorselect.layer.borderColor = UIColor.lightGray.cgColor
        btnteam2color.clipsToBounds = true
        btnteam2color.layer.cornerRadius = 9;
        btnteam2color.layer.borderWidth = 1;
        btnteam2color.layer.borderColor = UIColor.lightGray.cgColor
         btnselectdate.clipsToBounds = true
             btnselectdate.layer.cornerRadius = 9;
             btnselectdate.layer.borderWidth = 1;
             btnselectdate.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
