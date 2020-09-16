//
//  FootBallProfileVC.swift
//  Football Stats
//
//  Created by Chakri on 15/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallProfileVC: UIViewController {

    @IBOutlet var profileimage: UIImageView!
    
    @IBOutlet var txtname: UITextField!
    
    @IBOutlet var txtfirstname: UITextField!
    
    
    @IBOutlet var txtsurname: UITextField!
    
    @IBOutlet var txtdateofbirth: UITextField!
    
    @IBOutlet var txtmobileno: UITextField!
    
    @IBOutlet var btngender: UIButton!
    
    
    @IBOutlet var btnteamsupport: UIButton!
    
    @IBOutlet var defaultdatabase: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultdatabase.clipsToBounds = true
        defaultdatabase.layer.borderColor = UIColor.darkGray.cgColor
        defaultdatabase.layer.borderWidth = 1
        btngender.layer.borderColor = UIColor.darkGray.cgColor
              btngender.layer.borderWidth = 1
        btnteamsupport.layer.borderColor = UIColor.darkGray.cgColor
        btnteamsupport.layer.borderWidth = 1
        profileimage.layer.cornerRadius = profileimage.frame.size.width/2
        profileimage.clipsToBounds = true
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
