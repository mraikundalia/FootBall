//
//  FootBallJoinGroupVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
class FootBallJoinGroupVC: UIViewController {
    
  var hud : MBProgressHUD!
    @IBOutlet var txtcreateleague: UITextField!
    @IBOutlet var txtleaguepassword: UITextField!
    @IBOutlet var txtenterleaguenumber: UITextField!
    @IBOutlet var btnadd: UIButton!
    @IBOutlet var btncreate: UIButton!
    
    @IBAction func btnaddAction(_ sender: Any)
    {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                     hud.labelText = ""
        let str2 =  UserDefaults.standard.object(forKey: "registerid")

        let verify_param = ["storedProcedureName": "sp_enterIntoLeague","input1":str2 as Any,"input2":txtenterleaguenumber.text!,"input3":txtleaguepassword.text!] as [String : Any]

                 let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                 AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON {
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
                    //self.present(alert, animated: true, completion: nil)
                    }

            }
                }
              }
             }

    }
    
    
    @IBAction func btncreateAction(_ sender: Any) {

        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                     hud.labelText = ""
      let str2 =  UserDefaults.standard.object(forKey: "registerid")
        let verify_param = ["storedProcedureName": "sp_create_new_database","input1":str2 as Any,"input2":txtcreateleague.text!] as [String : Any]

                 let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                 AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON {
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
                    var stringvalue:String = ""
                        stringvalue = jsonResponse["status"] as! String
                    skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                        let dataarray = skippedArray.firstObject as! NSDictionary
                    if stringvalue == "Success"
                    {
                          self.showToast(message: "League Number Created", font: UIFont.systemFont(ofSize: 13))
                    }
                    else
                    {
                        var stringvalue1:String = ""
                        stringvalue1 = dataarray.value(forKey:"Update") as! String
                        self.showToast(message: stringvalue1, font: UIFont.systemFont(ofSize: 13))
                    }
                   
                }
              }
             }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnadd.clipsToBounds = true
        btnadd.layer.cornerRadius = 15;
        btncreate.clipsToBounds = true
        btncreate.layer.cornerRadius = 15;
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

}
