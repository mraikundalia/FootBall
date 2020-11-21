//
//  FootBallContactVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import  Alamofire
class FootBallContactVC: UIViewController, UITextViewDelegate
{

    
    @IBAction func btnsendAction(_ sender: Any) {
        
        self.getcontact()
    }
    
    @IBAction func btnbackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var btnsend: UIButton!
      var hud : MBProgressHUD!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnsend.clipsToBounds = true
        btnsend.layer.cornerRadius = 20;
        contacttextview.clipsToBounds = true
        contacttextview.layer.cornerRadius = 10
        contacttextview.layer.borderColor = UIColor.lightGray.cgColor
        contacttextview.layer.borderWidth = 1
        contacttextview.delegate = self
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet var contacttextview: UITextView!
    
    func getcontact(){
                          
             hud = MBProgressHUD.showAdded(to: self.view, animated: true)
             hud.labelText = ""
        let str2 =  UserDefaults.standard.object(forKey: "registerid")
         let verify_param = ["storedProcedureName": "proc_contactUs","input1":str2 as Any,"input2":contacttextview.text!] as [String : Any]
              //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
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
                             
                              
                            }
                 
                         
                       }
                      }
      }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    /* Older versions of Swift */
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
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

}
