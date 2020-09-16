//
//  ViewController.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func btnsignupAction(_ sender: Any)
    {
        let login: FootBallSignupVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallSignupVC") as! FootBallSignupVC)
              self.navigationController?.pushViewController(login!, animated: true)
    }
    @IBOutlet var btnsignup: UIButton!
    @IBOutlet var btnlogin: UIButton!
    
    @IBAction func btnloginAction(_ sender: Any)
    {
          let login: FootballLoginVC? = (storyboard?.instantiateViewController(withIdentifier: "FootballLoginVC") as! FootballLoginVC)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnsignup.clipsToBounds = true
        btnsignup.layer.cornerRadius = 10
        btnlogin.clipsToBounds = true
        btnlogin.layer.cornerRadius = 10;
        
        // Do any additional setup after loading the view.
    }


}

