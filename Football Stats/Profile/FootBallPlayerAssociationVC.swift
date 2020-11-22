//
//  FootBallPlayerAssociationVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import  Alamofire
import Reachability
class FootBallPlayerAssociationVC: UIViewController
{
    class NetworkState
    {
      class func isConnected() ->Bool
      {
          return NetworkReachabilityManager()!.isReachable
      }
    }
    var hud : MBProgressHUD!
    var playname:String = ""
    var databasename:String = ""
var isme: String = ""
    var iamadmin: String = ""
      var playerid: String = ""
    @IBOutlet var lblunassociate: UILabel!
    @IBOutlet var lblthisisme: UILabel!
    @IBOutlet var lbladmin: UILabel!
    @IBAction func btnsaveAction(_ sender: Any) {
        self.Updategroupchild()
    }
    @IBOutlet var btnsave: UIButton!
    @IBOutlet var borderview1: UIView!
    
    @IBOutlet var borderview2: UIView!
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btncheckAction2(_ sender: Any)
    {
        if (btncheck2.isSelected == true)
      {
       btncheck2.backgroundColor = UIColor.white
        btncheck2.setBackgroundImage(UIImage(named: ""), for:.normal)
      iamadmin = "0"
       btncheck2.isSelected = false;
      }
      else
      {
       //btncheck2.backgroundColor = UIColor.red
        btncheck2.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)
          iamadmin = "1"
       btncheck2.isSelected = true;
      }
    }
    @IBAction func btncheckAction1(_ sender: Any)
    {
        if (btncheck1.isSelected == true)
          {
           btncheck1.backgroundColor = UIColor.white
            btncheck1.setBackgroundImage(UIImage(named: ""), for:.normal)
         isme = "0"
           btncheck1.isSelected = false;
          }
          else
          {
           //btncheck1.backgroundColor = UIColor.red
            btncheck1.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)
        isme = "1"
           btncheck1.isSelected = true;
          }
    }
    
    @IBAction func btncheckAction3(_ sender: Any)
    {
        if (btncheck3.isSelected == true)
           {
            btncheck3.backgroundColor = UIColor.white
            btncheck3.setBackgroundImage(UIImage(named: ""), for: .normal)

            btncheck3.isSelected = false;
           }
           else
           {
            btncheck3.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)

          self.showSimpleAlert()
            btncheck3.isSelected = true;
           }
       
    }
    
    @IBOutlet var txtemail: UITextField!
    
    @IBOutlet var btncheck3: UIButton!
    @IBOutlet var txtplayerid: UITextField!
    @IBOutlet var textname: UITextField!
    @IBOutlet var txtgroupnickname: UITextField!
    @IBOutlet var btncheck2: UIButton!
    @IBOutlet var btncheck1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btncheck3.clipsToBounds = true
        btncheck3.layer.cornerRadius = 2
        btncheck3.layer.borderColor = UIColor.darkGray.cgColor
        btncheck3.layer.borderWidth = 1
        btncheck2.clipsToBounds = true
               btncheck2.layer.cornerRadius = 2
               btncheck2.layer.borderColor = UIColor.darkGray.cgColor
               btncheck2.layer.borderWidth = 1
         btncheck1.clipsToBounds = true
               btncheck1.layer.cornerRadius = 2
               btncheck1.layer.borderColor = UIColor.darkGray.cgColor
               btncheck1.layer.borderWidth = 1
                   borderview1.clipsToBounds = true
                      borderview1.layer.cornerRadius = 2
                      borderview1.layer.borderColor = UIColor.darkGray.cgColor
                      borderview1.layer.borderWidth = 1
        //borderview2.clipsToBounds = true
       // borderview2.layer.cornerRadius = 2
       // borderview2.layer.borderColor = UIColor.darkGray.cgColor
        //borderview2.layer.borderWidth = 1
        
        btnsave.clipsToBounds = true
        //borderview2.layer.cornerRadius = 22
        
        btncheck3.backgroundColor = UIColor.white
         btncheck2.backgroundColor = UIColor.white
         btncheck1.backgroundColor = UIColor.white
        btnsave.layer.cornerRadius = 22
        btnsave.clipsToBounds  = true
        self.GroupchildApi()
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
             let alert = UIAlertController(title: "Un-Associate User", message: "Are you sure do u want to Un Associate the user?",         preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                    //Cancel Action
                }))
                alert.addAction(UIAlertAction(title: "Un Associate",
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                                                self.Playerunassociate()
                }))
                self.present(alert, animated: true, completion: nil)
            }
    
    //MARK:///Api calll/////////
    func GroupchildApi()
                  {
                    //SVProgressHUD.show()
        if NetworkState.isConnected()
        {
                   hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                           hud.labelText = ""
                           
                        let str2 =  UserDefaults.standard.object(forKey: "registerid")
                let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
            let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getDatabaseGroup_child"
                            ,"input1":str2 as Any ,"input2":databasename,"input3":playname] as [String : Any]
                         let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                            AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                               response in
                              DispatchQueue.main.async{

                                     self.hud.hide(true)

                                     }
                             //  SVProgressHUD.dismiss()
                            if let json = response.value
                            {
                       let jsonResponse = json as! NSDictionary
                           print(jsonResponse)
                            do
                            {
                                
                       var stringvalue:String = ""
                       stringvalue = jsonResponse["status"] as! String
                    
                      

                                
    if stringvalue == "Success"
    {
        var skippedArray = NSMutableArray()
                    skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                        if skippedArray.count>0
                        {
                   let dataarray = skippedArray.firstObject as! NSDictionary
                     if let partname = dataarray.value(forKey: "emailadd") as? String
                   {
                      self.txtemail.text = partname

                    }
                    if let partname = dataarray.value(forKey: "fullName") as? String
                     {
                      self.textname.text = partname
                      }
                    if let partname = dataarray.value(forKey: "name") as? String
                     {
                      self.txtgroupnickname.text = partname
                      }
                    if let partname = dataarray.value(forKey: "playerID") as? String
                     {
                      self.txtplayerid.text = partname
                      
                      self.txtplayerid.isUserInteractionEnabled = false
                      }
  if let partname = dataarray.value(forKey: "ModifyAdminStatus") as? String
            {
             if partname == "No"
             {
              self.btncheck2.isHidden = true
              self.lbladmin.isHidden = true
              self.iamadmin = "0"
              }
             }
              
              if let partname = dataarray.value(forKey: "visibleUnAssociate") as? String
                   {
                    if partname == "No"
                    {
                      self.btncheck3.isHidden = true
                      self.lblunassociate.isHidden = true
                     }
                    }
              if let partname = dataarray.value(forKey: "thisIsMe") as? Int
              {
                let thisisme = Int(partname)
               if thisisme == 1
               {
                self.btncheck1.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)

                self.txtemail.isUserInteractionEnabled =  true
               
                }
                  else
               {
                    self.btncheck1.isHidden = true
                  self.lblthisisme.isHidden = true
                self.txtemail.isUserInteractionEnabled =  false

                  }
               }
              
              if let partname = dataarray.value(forKey: "visbleAdminPanel") as? String
              {
               if partname == "Yes"
               {
                 
                }
                  else
               {
                  self.borderview2.isHidden = true
                  }
               }
              if let partname = dataarray.value(forKey: "ModifyThisIsMe") as? String
              {
               if partname == "Yes"
               {
               
                }
                  else
               {
                  self.txtgroupnickname.isUserInteractionEnabled = true
                  }
               }
              
              if let partname = dataarray.value(forKey: "ModifyName") as? String
              {
               if partname == "Yes"
               {
                 
                }
                  else
               {
                  self.txtgroupnickname.isUserInteractionEnabled = true
                  
                  }
                  
               }
                }
    }
          else
         {
            let skippedArray = NSMutableArray()
            let dataarray = skippedArray.firstObject as! NSDictionary
                                         
              var stringvalue:String = ""
              stringvalue = dataarray.value(forKey:"ErrorDescription") as! String
              DispatchQueue.main.async{

                self.showAlert(message: stringvalue)
    }
               
               }
             
                                
                                
                                }
            }
        }
        }
                    
       else
        {
            self.showAlert(message: "Please Check Your Internet")
            
        }
                    
                    }
    func Playerunassociate()
            {
                    
                if NetworkState.isConnected()
                {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

           hud.labelText = ""
       //let str2 =  UserDefaults.standard.object(forKey: "registerid")
       let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

       let verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "unassociatePlayer","input1":txtplayerid.text!] as [String : Any]
            //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
            let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
            AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
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
                            
             //let dataarray = skippedArray.firstObject as! NSDictionary
                         
     var stringvalue:String = ""
        stringvalue = jsonResponse["status"] as! String
           
           if stringvalue == "Failure"
           {
               let dataarray = skippedArray.firstObject as! NSDictionary
                                          
               var stringvalue:String = ""
               stringvalue = dataarray.value(forKey:"returnV") as! String
               DispatchQueue.main.async{
                self.showAlert(message: stringvalue)
                   //self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))

               }
             
           }
               else
           {
         let dataarray = skippedArray.firstObject as! NSDictionary
        var stringvalue:String = ""
        stringvalue = dataarray.value(forKey:"returnV") as! String
           DispatchQueue.main.async{
            self.showAlert(message: stringvalue)

         // self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                         }
                          }
                         //}
                       
                     }
                    }
                }
                }
                else
                {
                    self.showAlert(message: "Please Check Your Internet")
                }
             
}
    
      func Updategroupchild()
                {
                    
        if NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                        hud.labelText = ""
                  let str2 =  UserDefaults.standard.object(forKey: "registerid")
                  let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                    let myInt1 = Int(isme)
                    let myInt2 = Int(iamadmin)
                  let plyid = Int(txtplayerid.text ?? "")
                  let verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "updateDatabaseGroup_child","input1":str2 as Any,"input2":plyid as Any,"input3":myInt1 as Any,"input4":txtgroupnickname.text!,"input5":myInt2 as Any] as [String : Any]
                         //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
                         let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                         AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
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
                            stringvalue = dataarray.value(forKey:"Update") as! String
                            DispatchQueue.main.async{
                                self.showAlert(message: stringvalue)
                                //self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))

                            }
                          
                        }
                            else
                        {
                      let dataarray = skippedArray.firstObject as! NSDictionary
                     var stringvalue:String = ""
                     stringvalue = dataarray.value(forKey:"Update") as! String
                        DispatchQueue.main.async{
                            self.showAlert(message: stringvalue)
                       //self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                                      }
                                       }
                                      //}
                                    
                                  }
                                 }
                         }
        }
        else
        {
            
        }
                    
    }
}
