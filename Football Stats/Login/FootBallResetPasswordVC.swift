//
//  FootBallResetPasswordVC.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

class FootBallResetPasswordVC: UIViewController , UITextFieldDelegate {
  var hud : MBProgressHUD!
    
    class NetworkState
          {
              class func isConnected() ->Bool
              {
                  return NetworkReachabilityManager()!.isReachable
              }
          }
    
    @IBOutlet var txtemail: UITextField!
    
    
    @IBOutlet var btnback: UIButton!
    @IBOutlet var btnnext: UIButton!
    
    
    @IBAction func btnbackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAction(_ sender: Any)
    {
        if txtemail.text?.count == 0 || !self.isValidEmail(txtemail.text!)
        {
            self.showToast(message: "Enter valid email", font: UIFont.systemFont(ofSize: 13))
        }
        else
        {
            self.txtemail.resignFirstResponder()
             self.Passwordresetcall()
        }
       
    }
    override func viewDidLoad()
    
    
    {
        super.viewDidLoad()
        btnnext.clipsToBounds = true
        btnnext.layer.cornerRadius = 10
        txtemail.clipsToBounds = true
        txtemail.layer.cornerRadius = 5
      //  self.showSimpleAlert()
        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
       }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
       {
           return textField .resignFirstResponder()
       }
    
    //MARK: ////APi CAll/////////////
    func Passwordresetcall()
            {
              //SVProgressHUD.show()
                if NetworkState.isConnected()
                {
                let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                       hud.labelText = ""
                    let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"ForgottenEmail","input1":txtemail.text!] as [String : Any]
                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                AF.request(GlobalConstants.ApiURL+"APIForgottenEmail", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON {
                          response in
                        //  SVProgressHUD.dismiss()
                       if let json = response.value
                       {
                  let jsonResponse = json as! NSDictionary
                      print(jsonResponse)
                        DispatchQueue.main.async{

                                       self.hud.hide(true)
                      self.navigationController?.popViewController(animated: true)
                                       }
                       do
                       {
//                        var skippedArray = NSMutableArray()
//                        skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                        var stringvalue:String = ""
                        stringvalue = jsonResponse["status"] as! String
                        if stringvalue == "Failure"
                       {
//                           let dataarray = skippedArray.firstObject as! NSDictionary
//
//                           var stringvalue:String = ""
//                           stringvalue = dataarray.value(forKey:"ErrorDescription") as! String
                           DispatchQueue.main.async{
                            self.showAlert(message: "Failure")
                               //self.showToast(message: "Failure", font: UIFont.systemFont(ofSize: 12))
                           }
                        }
                        else
                        {
                            
                            self.showSimpleAlert()
                        }
                         // UserDefaults.standard.set(jsonResponse.object(forKey: "register_id"), forKey: "registerid")  //Integer
    //                      let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
    //                         self.navigationController?.pushViewController(login!, animated: true)
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
    func showSimpleAlert()
         {
            let blurEffect = UIBlurEffect(style: .extraLight)
            let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
            blurVisualEffectView.frame = view.bounds
            blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurVisualEffectView.alpha = 0.5
             let alert = UIAlertController(title: "Email Sent", message: "An email has been sent with new password please check your registed email account", preferredStyle: UIAlertController.Style.alert)
            if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first {
                for innerView in actionSheet.subviews {
                    innerView.backgroundColor = .white
                    innerView.layer.cornerRadius = 15.0
                    innerView.clipsToBounds = true
                    innerView.layer.borderColor = UIColor.black.cgColor
                    innerView.layer.borderWidth = 1
                }
            }
             alert.addAction(UIAlertAction(title: "OK !!!", style: UIAlertAction.Style.default, handler: { _ in
                
                blurVisualEffectView.removeFromSuperview()
                    //Cancel Action
                }))
        
           
            alert.view.tintColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 141.0/255.0, alpha: 1)
              self.view.addSubview(blurVisualEffectView)
                self.present(alert, animated: true, completion: nil)
            }
    
}
