//
//  FootBallSettingsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallSettingsVC: UIViewController {

    @IBOutlet var btnbasicSettings: UIButton!
    @IBOutlet var btncontactus: UIButton!
    @IBOutlet var btnsecuritysettings: UIButton!
    
    @IBAction func btnbasicsettings(_ sender: Any)
    {
        let login: FootBallBasicSettingsVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallBasicSettingsVC") as! FootBallBasicSettingsVC)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    
    @IBAction func btncontactAction(_ sender: Any) {
        let login: FootBallContactVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallContactVC") as! FootBallContactVC)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    
    @IBAction func btnsecurityAction(_ sender: Any) {
        let login: FootBallSecuritySettingsVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallSecuritySettingsVC") as! FootBallSecuritySettingsVC)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnbasicSettings.clipsToBounds = true
        btnbasicSettings.layer.cornerRadius = 22
        btnbasicSettings.layer.borderColor = UIColor.lightGray.cgColor
        btnbasicSettings.layer.borderWidth = 1;
        btncontactus.clipsToBounds = true
        btncontactus.layer.cornerRadius = 22
        btncontactus.layer.borderColor = UIColor.lightGray.cgColor
        btncontactus.layer.borderWidth = 1;
        btnsecuritysettings.clipsToBounds = true
        btnsecuritysettings.layer.cornerRadius = 22
        btnsecuritysettings.layer.borderColor = UIColor.lightGray.cgColor
        btnsecuritysettings.layer.borderWidth = 1;
        

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
