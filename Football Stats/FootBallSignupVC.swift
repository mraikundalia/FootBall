//
//  FootBallSignupVC.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallSignupVC: UIViewController {

    @IBOutlet var txtfirstname: UITextField!
    
    @IBOutlet var txtsurname: UITextField!
    
    @IBOutlet var txpassword: UITextField!
    
    @IBOutlet var txtemail: UITextField!

    @IBOutlet var txtconfirmpassword: UITextField!
    
    @IBOutlet var btnnext: UIButton!
    
    @IBOutlet var btnapple: UIButton!
    
    @IBOutlet var btnfacebook: UIButton!
    
    @IBOutlet var btngoogle: UIButton!
    
    @IBAction func btnnextAction(_ sender: Any)
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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
            btnnext.clipsToBounds = true
             btnnext.layer.cornerRadius = 10
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
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                           replacementString string: String) -> Bool
    {
        if textField  == txtconfirmpassword || textField == txpassword
        {
        let maxLength = 10
            let currentString: NSString = txtconfirmpassword!.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        }
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
