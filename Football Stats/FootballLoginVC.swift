//
//  FootballLoginVC.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class FootballLoginVC: UIViewController  ,UITextFieldDelegate{
     
    @IBOutlet var btnrememberme: UIButton!
    @IBOutlet var txtemail: UITextField!
     var hud : MBProgressHUD!
    
    @IBOutlet var btnfacebook: UIButton!
    @IBOutlet var btngoogle: UIButton!
    
    @IBOutlet var btnapple: UIButton!
    @IBOutlet var btnlogin: UIButton!
    @IBOutlet var txtpassword: UITextField!
    
    @IBAction func btnremberAction(_ sender: Any)
    {
        if (btnrememberme.isSelected == true)
                 {
                  btnrememberme.backgroundColor = UIColor.white
                   btnrememberme.setBackgroundImage(UIImage(named: ""), for:.normal)
                    UserDefaults.standard.set(nil, forKey: "emailid")
                  btnrememberme.isSelected = false;
                 }
                 else
                 {
                  //btncheck1.backgroundColor = UIColor.red
                   btnrememberme.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)
                    //UserDefaults.standard.set(txtemail.text, forKey: "emailid")
                
                  btnrememberme.isSelected = true;
                    let myValue:NSString = txtemail.text! as NSString

                    UserDefaults.standard.set(myValue, forKey:"emailid")
                    UserDefaults.standard.synchronize()
                 }
    }
    
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
        self.loginMethod()
    }
    
    @IBAction func btnappleAction(_ sender: Any)
    {
        
    }
    
    @IBAction func btngoogleAction(_ sender: Any)
    {
    }
    
    @IBAction func btnfacebookAction(_ sender: Any)
    {
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnlogin.clipsToBounds = true
      btnlogin.layer.cornerRadius = 10
      btnapple.clipsToBounds = true
      btnapple.layer.cornerRadius = 10
        btnfacebook.clipsToBounds = true
        btnfacebook.layer.cornerRadius = 10
        btngoogle.clipsToBounds = true
        btngoogle.layer.cornerRadius = 10
        btnrememberme.clipsToBounds = true
        btnrememberme.layer.cornerRadius = 2
        btnrememberme.layer.borderWidth = 1
        btnrememberme.layer.borderColor = UIColor.darkGray.cgColor
         // UserDefaults.standard.set(txtemail.text, forKey: "emailid")
        if let favorites = UserDefaults.standard.object(forKey: "emailid")
        {
             // userDefault has a value
            txtemail.text =  ((favorites as Any) as! String)
             btnrememberme.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)
           
            
        }
        else {
             // userDefault is nil (empty)
             btnrememberme.setBackgroundImage(UIImage(named: ""), for:.normal)
        }

//        var email: String  = ""
//       let  email =  UserDefaults.standard.object(forKey: "email") as! String
//       
//        if email.count > 0
//        {
//            txtemail.text =  email
//        }
        // Do any additional setup after loading the view.
    }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField .resignFirstResponder()
    }
   func loginMethod(){
                    
        //[SVProgressHUD show];
        //SVProgressHUD.show()
       hud = MBProgressHUD.showAdded(to: self.view, animated: true)

       hud.labelText = "Loading..."

    
   let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":txtemail.text!,"input3":txtpassword.text!] as [String : Any]
        //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                    AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                    if let json = response.value {
                    let jsonResponse = json as! NSDictionary
                        
                        DispatchQueue.main.async{

                            self.hud.hide(true)

                        }
                        //let when = DispatchTime.now() + 2
//                DispatchQueue.main.asyncAfter(deadline: when){
//                    SVProgressHUD.dismiss()
//                        }
                    print(jsonResponse)
                        
                    do
                    {
                        //t sizeDict = jsonResponse.objec["Data1"]
                        
                       
                        //jsonResponse["register_id"] as! CVarArg
                        var skippedArray = NSMutableArray()
                        
                        skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                        
                        
                       // var string = String()
                        //string = skippedArray.value(forKey: "register_id") as! String
//                        let encoded = NSKeyedArchiver.archivedData(withRootObject: "register_id")
//                        UserDefaults.standard.set(encoded, forKey: "encodedData")
//                        var stringvalue:String = ""
//                        stringvalue = skippedArray.value(forKeyPath: "returnV") as! String
                          let dataarray = skippedArray.firstObject as! NSDictionary
                        
                        //let keyExists = dataarray["register_id"] != nil
                            var stringvalue:String = ""
                    stringvalue = jsonResponse["status"] as! String
                        
                        if stringvalue == "Failure"
                        {
                            let dataarray = skippedArray.firstObject as! NSDictionary
                                                       
                            var stringvalue:String = ""
                            stringvalue = dataarray.value(forKey:"returnV") as! String
                            DispatchQueue.main.async{

                                self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                            }
                        }
                        else
                        {
                            UserDefaults.standard.set(skippedArray.value(forKeyPath: "register_id"), forKey: "registerid")
                                                                                 //Integer
                     let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
                        self.navigationController?.pushViewController(login!, animated: true)
                            
                        }
//                        if keyExists
//                        {
//                           UserDefaults.standard.set(skippedArray.value(forKeyPath: "register_id"), forKey: "registerid")
//                                                      //Integer
//                              let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
//                                 self.navigationController?.pushViewController(login!, animated: true)
//                        } else
//                        {
//                      let dataarray = skippedArray.firstObject as! NSDictionary
//
//                      var stringvalue:String = ""
//                  stringvalue = dataarray.value(forKey:"returnV") as! String
//
//                     if (stringvalue == "Invalid email address" || stringvalue == "Failure - Invalid email address" )
//                    {
//
//                     let alert = UIAlertController(title: "", message: stringvalue,         preferredStyle: UIAlertController.Style.alert)
//
//                     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
//                            //Cancel Action
//                        }))
//                        alert.addAction(UIAlertAction(title: "OK",
//                                                      style: UIAlertAction.Style.default,
//                                                      handler: {(_: UIAlertAction!) in
//                                                        //Sign out action
//                        }))
//                        self.present(alert, animated: true, completion: nil)
//                     }
                        }
                        
                       
                        
                        //}
                        
                      }
                       
       //                if(jsonResponse["status"] as! String == "sucess"){
       //
       //                }
                   
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

}
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
