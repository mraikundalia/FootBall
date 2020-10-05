//
//  FootBallSignupVC.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class FootBallSignupVC: UIViewController {

    
     var hud : MBProgressHUD!
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
        self.SignupCall()

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
    
       func SignupCall()
      {
        //SVProgressHUD.show()
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                     hud.labelText = "Loading..."
        
        let verify_param = ["storedProcedureName": "sp_registerPlayer","input1":"Email","input2":txtemail.text!,"input3":txtconfirmpassword.text!,"input4":txtfirstname.text!,"input5":txtsurname.text!] as [String : Any]
        
                 let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                 AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON {
                    response in
                  //  SVProgressHUD.dismiss()
                 if let json = response.value
                 {
            let jsonResponse = json as! NSDictionary
                DispatchQueue.main.async{

                self.hud.hide(true)

                }
                print(jsonResponse)
                 do
                 {
                    var skippedArray = NSMutableArray()
                                          
                    skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                    
                    let dataarray = skippedArray.firstObject as! NSDictionary
                  
                                           
                                    let keyExists = dataarray["register_id"] != nil
                                            
                    if keyExists
                    {
                                    
            UserDefaults.standard.set(skippedArray.value(forKeyPath: "registeredPlayer_ID"), forKey: "registerid")  //Integer
            let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
        self.navigationController?.pushViewController(login!, animated: true)
            
                            }
                        else{
                var stringvalue:String = ""
                                 stringvalue = dataarray.value(forKey:"returnV") as! String
                 if (stringvalue == "Invalid email address" || stringvalue == "Failure - Invalid email address" || stringvalue == "Email address has already been registered..")
                {

                 let alert = UIAlertController(title: "", message: stringvalue,         preferredStyle: UIAlertController.Style.alert)

                 alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                        //Cancel Action
                    }))
                    alert.addAction(UIAlertAction(title: "OK",
                                                  style: UIAlertAction.Style.default,
                                                  handler: {(_: UIAlertAction!) in
                                                    //Sign out action
                    }))
                    self.present(alert, animated: true, completion: nil)
                    }
           
            }
                }
              }
             }
        
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






