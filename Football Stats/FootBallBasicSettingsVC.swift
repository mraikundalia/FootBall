//
//  FootBallBasicSettingsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
class FootBallBasicSettingsVC: UIViewController , NIDropDownDelegate
{
    var hud : MBProgressHUD!
var btndropdown = NIDropDown ()
    @IBOutlet var notificationswitch: UISwitch!
    @IBOutlet var btnnotifications: UIButton!
    @IBOutlet var btncolorselect: UIButton!
    @IBOutlet var btnsave: UIButton!
    
    @IBAction func btnsaveAction(_ sender: Any)
    {
        self.Updatebasicsetting()
    }
    @IBAction func btnteam1shirtAction(_ sender: Any) {
        let myFloatForR = 250
                      var r = CGFloat(myFloatForR)
                     // lazy var value: Float = 200
                      btndropdown.isHidden = false
                      btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (shirtscolors.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                      btndropdown.setDropDownSelectionColor(UIColor.gray)
                      btndropdown.delegate = self
                         btndropdown.tag = 0
    }
    
    
    @IBAction func btnteam2shirtAction(_ sender: Any) {
        let myFloatForR = 250
                      var r = CGFloat(myFloatForR)
                     // lazy var value: Float = 200
                      btndropdown.isHidden = false
                      btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (shirtscolors.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                      btndropdown.setDropDownSelectionColor(UIColor.gray)
                      btndropdown.delegate = self
                         btndropdown.tag = 1
    }
    
    @IBAction func btndateAction(_ sender: Any) {
        let myFloatForR = 250
                             var r = CGFloat(myFloatForR)
                            // lazy var value: Float = 200
                             btndropdown.isHidden = false
                             btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (datearray.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                             btndropdown.setDropDownSelectionColor(UIColor.gray)
                             btndropdown.delegate = self
                                btndropdown.tag = 2
    }
    var myString: String = ""
    
    @IBAction func switchAction(_ sender: Any)
    {
        let value = notificationswitch.isOn
        if value == true
        {
         
         myString = "0"
            self.Updatebasicsetting()
            
        }
        else{
            myString = "1"
            self.Updatebasicsetting()
        }
        
    }
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var btnteam2shirtcolor: UILabel!
    
    @IBOutlet var btnteam2color: UIButton!
    
    @IBOutlet var btnselectdate: UIButton!
     var shirtscolors = NSMutableArray()
     var datearray = NSMutableArray()
    let Stringvalue = NSString.self
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btncolorselect.clipsToBounds = true
        btncolorselect.layer.cornerRadius = 9
        btncolorselect.layer.borderWidth = 1;
        btncolorselect.layer.borderColor = UIColor.lightGray.cgColor
        btnteam2color.clipsToBounds = true
        btnteam2color.layer.cornerRadius = 9;
        btnteam2color.layer.borderWidth = 1;
        btnteam2color.layer.borderColor = UIColor.lightGray.cgColor
        btnselectdate.clipsToBounds = true
        btnselectdate.layer.cornerRadius = 9;
        btnselectdate.layer.borderWidth = 1;
        btnselectdate.layer.borderColor = UIColor.lightGray.cgColor
        btnnotifications.clipsToBounds = true
        btnnotifications.layer.cornerRadius = 9;
        btnnotifications.layer.borderWidth = 1;
        btnnotifications.layer.borderColor = UIColor.lightGray.cgColor
        btnsave.clipsToBounds = true
        btnsave.layer.cornerRadius = 10
        btnsave.layer.borderWidth = 1
        self.Getbasicsetting()
        // Do any additional setup after loading the view.
    }
    func Getbasicsetting()
    {
                           
               //[SVProgressHUD show];
               //SVProgressHUD.show()
              hud = MBProgressHUD.showAdded(to: self.view, animated: true)

              hud.labelText = "Loading..."
      let str2 =  UserDefaults.standard.object(forKey: "registerid")
          let verify_param = ["storedProcedureName": "getBasicSetting","input1":str2 as Any] as [String : Any]
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
                              self.btncolorselect.setTitle((dataarray.value(forKey: "ShirtColour_Team1") as! String), for: .normal)
                             self.btnteam2color.setTitle((dataarray.value(forKey: "ShirtColour_Team2") as! String), for: .normal)
                            //let assumedString: String! = (dataarray.value(forKey: "appDateFormat") as! String)

//                            if dataarray.value(forKey: "appDateFormat") = "<null>"
//                            {
//                                // do something with null JSON value here
//                            }
//                            else
//                            {
                                   self.btnselectdate.setTitle((dataarray.value(forKey: "appDateFormat") as! String), for: .normal)
                            //}
                            
                        
                            self.shirtscolors = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                            self.datearray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                               
                             }
                            //}
                          
                        }
                       }
       }
    func niDropDownDelegateMethod(_ sender: NIDropDown!) {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
        if btndropdown.tag == 0
        {
            btncolorselect.setTitle(title, for:.normal)
        }
        else if btndropdown.tag == 1
        {
        btnteam2color.setTitle(title, for: .normal)
        }
        else if btndropdown.tag == 2
               {
                
                let datestrmg:String = title.replacingOccurrences(of: "DD MMM YYYY", with: "", options: NSString.CompareOptions.literal, range: nil)

               btnselectdate.setTitle(datestrmg, for: .normal)
               }
    }
    
    func niDropDownHidden(_ sender: NIDropDown!)
    {
       
        btndropdown.isHidden = true
    }
    
    func Updatebasicsetting()
        {
                               
                   //[SVProgressHUD show];
                   //SVProgressHUD.show()
                  hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                  hud.labelText = "Loading..."
            let myInt1 = Int(myString)
          let str2 =  UserDefaults.standard.object(forKey: "registerid")
            let verify_param = ["storedProcedureName": "updateBasicSetting","input1":str2 as Any,"input2":btncolorselect.currentTitle!,"input3":btnteam2color.currentTitle!,"input4":btnselectdate.currentTitle!,"input5":myInt1 as Any] as [String : Any]
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
                                               
                               // let dataarray = skippedArray.firstObject as! NSDictionary
    //                              self.txtname.text = (dataarray.value(forKey: "emailadd") as! String)
    //                                self.txtfirstname.text = (dataarray.value(forKey: "firstName") as! String)
    //                              self.txtsurname.text = (dataarray.value(forKey: "surName") as! String)
    //                              self.btnteamsupport.setTitle((dataarray.value(forKey: "team_supported") as! String), for: .normal)
    //                              self.txtdateofbirth .text = (dataarray.value(forKey: "dob") as! String)
    //                              self.txtmobileno.text = (dataarray.value(forKey: "mobilenumber") as! String)
//                                  self.btncolorselect.setTitle((dataarray.value(forKey: "ShirtColour_Team1") as! String), for: .normal)
//                                 self.btnteam2color.setTitle((dataarray.value(forKey: "ShirtColour_Team2") as! String), for: .normal)
//                                self.btnselectdate.setTitle((dataarray.value(forKey: "appDateFormat") as! String), for: .normal)
//                                self.shirtscolors = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
//                                self.datearray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                                   
                                 }
                                //}
                              
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
