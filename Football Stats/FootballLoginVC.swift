//
//  FootballLoginVC.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootballLoginVC: UIViewController  ,UITextFieldDelegate{

    
    @IBOutlet var txtemail: UITextField!
    
    
    @IBOutlet var btnfacebook: UIButton!
    @IBOutlet var btngoogle: UIButton!
    
    @IBOutlet var btnapple: UIButton!
    @IBOutlet var btnlogin: UIButton!
    @IBOutlet var txtpassword: UITextField!
    
    
    @IBOutlet var btnforgotpassword: UIButton!
    
    @IBAction func btnforgotAction(_ sender: Any)
    {
        let login: FootBallResetPasswordVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallResetPasswordVC") as! FootBallResetPasswordVC)
              self.navigationController?.pushViewController(login!, animated: true)
    }
    
    
    @IBAction func btnsignupAction(_ sender: Any)
    {
        let login: FootBallSignupVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallSignupVC") as! FootBallSignupVC)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    
    @IBOutlet var btnsignup: UIButton!
    @IBAction func btnloginAction(_ sender: Any)
    {
        let login: FootBallTabControllerViewController? = (storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    
    @IBAction func btnappleAction(_ sender: Any) {
    }
    
    @IBAction func btngoogleAction(_ sender: Any) {
    }
    
    @IBAction func btnfacebookAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnlogin.clipsToBounds = true
      btnlogin.layer.cornerRadius = 10
      btnapple.clipsToBounds = true
      btnapple.layer.cornerRadius = 10;
        btnfacebook.clipsToBounds = true
        btnfacebook.layer.cornerRadius = 10;
        btngoogle.clipsToBounds = true
        btngoogle.layer.cornerRadius = 10;
        
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
