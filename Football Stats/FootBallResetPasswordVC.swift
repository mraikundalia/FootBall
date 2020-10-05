//
//  FootBallResetPasswordVC.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
class FootBallResetPasswordVC: UIViewController , UITextFieldDelegate {
  var hud : MBProgressHUD!
    @IBOutlet var txtemail: UITextField!
    
    
    @IBOutlet var btnback: UIButton!
    @IBOutlet var btnnext: UIButton!
    
    
    @IBAction func btnbackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAction(_ sender: Any)
    {
        
        self.Passwordresetcall()
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
    func Passwordresetcall()
            {
              //SVProgressHUD.show()
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                       hud.labelText = "Loading..."
                let verify_param = ["storedProcedureName": "sp_forgottenPassword","input1":txtemail.text!] as [String : Any]
                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                       AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON {
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
                         // UserDefaults.standard.set(jsonResponse.object(forKey: "register_id"), forKey: "registerid")  //Integer
    //                      let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
    //                         self.navigationController?.pushViewController(login!, animated: true)
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

}
