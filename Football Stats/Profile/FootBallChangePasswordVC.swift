//
//  FootBallChangePasswordVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import Reachability
class FootBallChangePasswordVC: UIViewController, UITextFieldDelegate {
    class NetworkState
             {
               class func isConnected() ->Bool
               {
                   return NetworkReachabilityManager()!.isReachable
               }
             }
    var hud : MBProgressHUD!
    @IBOutlet var txtconfirmpassword: UITextField!
    @IBOutlet var txtnewpassword: UITextField!
    @IBOutlet var txtcurrentpassword: UITextField!
    
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnconfirmAction(_ sender: Any) {
        if txtcurrentpassword.text == ""
        {
            
        }
        if txtcurrentpassword.text == "" || txtcurrentpassword.text?.count == 0
                      {
                          self.showToast(message: "Please Enter Current Password ", font: UIFont.systemFont(ofSize: 13))
                      }
               else if txtconfirmpassword.text == "" || txtconfirmpassword.text?.count == 0
                  {
               self.showToast(message: "Please Enter Confirm Password", font: UIFont.systemFont(ofSize: 13))
                  }
                   else if txtnewpassword.text == "" || txtnewpassword.text?.count == 0
                    {
                   self.showToast(message: "Please Enter New Password", font: UIFont.systemFont(ofSize: 13))
                    }
        else if txtconfirmpassword.text == txtnewpassword.text
                {
                     self.Changepasswordmethod()
                 }
        else
        {
       self.showToast(message: "Password Not Matching", font: UIFont.systemFont(ofSize: 13))
        }
        
    }
    @IBOutlet var btnconfirm: UIButton!
    
    //MARK: ......ViewDidLoad////////////////
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnconfirm.layer.cornerRadius = 20;
        btnconfirm.clipsToBounds = true
        txtnewpassword.delegate = self
        txtconfirmpassword.delegate = self
        txtcurrentpassword.delegate = self
        
        // Do any additional setup after loading the view.
    }
      //MARK: ......ApiCall////////////////
       func Changepasswordmethod()
       {
                        
        if NetworkState.isConnected()
        {
              hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.labelText = ""
            let str2 =  UserDefaults.standard.object(forKey: "registerid")
                 let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                let verify_param = ["sessionID" :sessionid as Any,"storedProcedureName": "sp_changePassword","input1":str2 as Any,"input2":txtcurrentpassword.text!,"input3":txtconfirmpassword.text!] as [String : Any]
                   
                     let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                     AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                                 if let json = response.value {
                                 let jsonResponse = json as! NSDictionary
                                    DispatchQueue.main.async{
                                        self.hud.hide(true)

                                    }
                                 print(jsonResponse)
                                     DispatchQueue.main.async{

                                             self.hud.hide(true)

                                         }
                                 do
                                 {
                                    var stringvalue:String = ""
                                 stringvalue = jsonResponse["status"] as! String
                                     var skippedArray = NSMutableArray()
                                 skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                                
                                 let dataarray = skippedArray.firstObject as! NSDictionary
                                     
                                     if stringvalue == "Success"
                                     {
                                         var stringvalue1:String = ""
                                         stringvalue1 = dataarray.value(forKey:"Column1") as! String
                                        // self.showToast(message: stringvalue1, font: UIFont.systemFont(ofSize: 13))
                                         self.showAlert(message: stringvalue1)
                                         self.navigationController?.popViewController(animated: true)
                                     }
                                     else{
                                         var stringvalue1:String = ""
                                         stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                                         self.showAlert(message: stringvalue1)
                                       //  self.showToast(message: stringvalue1, font: UIFont.systemFont(ofSize: 13))
                                     }
                                   }
                        
                                
                              }
                             }
        }
      else
        {
         self.showAlert(message: GlobalConstants.internetmessage)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField .resignFirstResponder()
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

}
