//
//  FootBallSecuritySettingsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
class FootBallSecuritySettingsVC: UIViewController {
    var biometric: String = ""
    var hud : MBProgressHUD!

    @IBAction func btnsignoutAction(_ sender: Any) {
          UserDefaults.standard.set(nil, forKey: "registerid")
        let login: FootballLoginVC? = (self.storyboard?.instantiateViewController(withIdentifier: "FootballLoginVC") as! FootballLoginVC)
        self.navigationController?.pushViewController(login!, animated: true)
        
    }
    @IBOutlet var btnsignout: UIButton!
    @IBOutlet var bioswitch: UISwitch!
    @IBAction func btnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnswitchAction(_ sender: Any)
    {
        let value = bioswitch.isOn
               if value == true
               {
                
                biometric = "0"
                   self.Getbiometric()
                   
               }
               else{
                   biometric = "1"
                   self.Getbiometric()
               }
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
        btnsignout.clipsToBounds = true
       btnsignout.layer.cornerRadius = 22
      btnsignout.layer.borderColor = UIColor.lightGray.cgColor
      btnsignout.layer.borderWidth = 1
        self.GetsecuritySettings()
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
                                            self.DeleteAction()
                                            
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
      func DeleteAction()
        {
                               
                   //[SVProgressHUD show];
                   //SVProgressHUD.show()
                  hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                  hud.labelText = "Loading..."
              let str2 =  UserDefaults.standard.object(forKey: "registerid")
            
              let verify_param = ["storedProcedureName": "sp_deleteMyAccount","input1":str2 as Any] as [String : Any]
                   //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
                               let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                               AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                               if let json = response.value {
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
                let dataarray = skippedArray.firstObject as! NSDictionary
               var stringvalue:String = ""
               stringvalue = dataarray.value(forKey:"returnV") as! String
                  DispatchQueue.main.async{
                 self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                                }
                                 }
                                //}
                              
                            }
                           }
           }
        
   
}
    
     func GetsecuritySettings()
            {
                                   
                       //[SVProgressHUD show];
                       //SVProgressHUD.show()
                      hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                      hud.labelText = "Loading..."
              let str2 =  UserDefaults.standard.object(forKey: "registerid")
                  let verify_param = ["storedProcedureName": "getSecuritySetting","input1":str2 as Any] as [String : Any]
                       //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
                                   let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                                   AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                                   if let json = response.value {
                                   let jsonResponse = json as! NSDictionary
                                      DispatchQueue.main.async{
                                          self.hud.hide(true)

                                      }
                                   print(jsonResponse)
                                       
                                   do
                                   {
        //                            if jsonResponse.value(forKey: "status") = "Success"
        //                            {
                                    var skippedArray = NSMutableArray()
                                    skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
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
                             let dataarray = skippedArray.firstObject as! NSDictionary
                            //var stringvalue:String = ""
                           // stringvalue = dataarray.value(forKey:"biometric") as! String
                               DispatchQueue.main.async{
                              if let partname = dataarray.value(forKey: "biometric") as? String
                               {
                                 if partname == "0"
                                 {
                                   // self.bioswitch.setOn(true, animated: true)
                                    self.bioswitch.isOn = true
                                    self.bioswitch.setOn(true, animated: true)
                                    
                                }
                                
                                else
                                 {
                                   // self.bioswitch.setOn(false, animated: true)
                                     self.bioswitch.isOn = true
                                    self.bioswitch.setOn(true, animated: true)
                                }
                                
                                }
                                }
                                                               
                                }
                                    //}
                                  
                                }
                               }
               }
       
    }
    
    
    
     func Getbiometric()
                   {
                                          
                              //[SVProgressHUD show];
                              //SVProgressHUD.show()
                             hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                             hud.labelText = "Loading..."
                     let myInt1 = Int(biometric)
                     let str2 =  UserDefaults.standard.object(forKey: "registerid")
                         let verify_param = ["storedProcedureName": "update_biometrics","input1":str2 as Any,"input2":myInt1 as Any] as [String : Any]
              //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
                          let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                          AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                          if let json = response.value {
                          let jsonResponse = json as! NSDictionary
                             DispatchQueue.main.async{
                                 self.hud.hide(true)

                             }
                          print(jsonResponse)
                              
                          do
                          {
    //                            if jsonResponse.value(forKey: "status") = "Success"
    //                            {
                           var skippedArray = NSMutableArray()
                           skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                          
                           let dataarray = skippedArray.firstObject as! NSDictionary
    //                             String)
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
                       let dataarray = skippedArray.firstObject as! NSDictionary
                      var stringvalue:String = ""
                      stringvalue = dataarray.value(forKey:"returnV") as! String
                         DispatchQueue.main.async{
                        self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                           
                                       
                                       }
                                                         
                               }

                                              
                                            }
                                           //}
                                         
                                       }
                                      }
                      }
}
