//
//  FootBallSecuritySettingsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallSecuritySettingsVC: UIViewController {

    @IBAction func btnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnswitchAction(_ sender: Any) {
    }
    @IBOutlet var btnenablebiometric: UIButton!
    
    @IBOutlet var btnchnagepassword: UIButton!
    
    @IBOutlet var btndeleteAction: UIButton!
    
    @IBAction func btnbiometricAction(_ sender: Any) {
    }
    @IBAction func btnchangePassword(_ sender: Any) {
        let login: FootBallChangePasswordVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallChangePasswordVC") as! FootBallChangePasswordVC)
               self.navigationController?.pushViewController(login!, animated: true)
    }
    
    @IBAction func btndeleteAction(_ sender: Any) {
        self.showSimpleAlert()
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnenablebiometric.clipsToBounds = true
        btnenablebiometric.layer.cornerRadius = 22
        btnenablebiometric.layer.borderColor = UIColor.lightGray.cgColor
        btnenablebiometric.layer.borderWidth = 1
        btnchnagepassword.clipsToBounds = true
             btnchnagepassword.layer.cornerRadius = 22
             btnchnagepassword.layer.borderColor = UIColor.lightGray.cgColor
             btnchnagepassword.layer.borderWidth = 1
        
        btndeleteAction.clipsToBounds = true
                   btndeleteAction.layer.cornerRadius = 22
                   btndeleteAction.layer.borderColor = UIColor.lightGray.cgColor
                   btndeleteAction.layer.borderWidth = 1
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
    func showSimpleAlert()
    {
        let alert = UIAlertController(title: "Delete My Account", message: "Are you sure do u want to delete your account?",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
               //Cancel Action
           }))
           alert.addAction(UIAlertAction(title: "Delete",
                                         style: UIAlertAction.Style.default,
                                         handler: {(_: UIAlertAction!) in
                                           //Sign out action
           }))
           self.present(alert, animated: true, completion: nil)
       }
}
