//
//  FootBallResetPasswordVC.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallResetPasswordVC: UIViewController , UITextFieldDelegate {

    @IBOutlet var txtemail: UITextField!
    
    
    @IBOutlet var btnback: UIButton!
    @IBOutlet var btnnext: UIButton!
    
    
    @IBAction func btnbackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAction(_ sender: Any)
    {
        let login: FootBallSignupVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallSignupVC") as! FootBallSignupVC)
            self.navigationController?.pushViewController(login!, animated: true)
        
    }
    override func viewDidLoad()
    
    
    {
        super.viewDidLoad()
        btnnext.clipsToBounds = true
        btnnext.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
       {
           return textField .resignFirstResponder()
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
