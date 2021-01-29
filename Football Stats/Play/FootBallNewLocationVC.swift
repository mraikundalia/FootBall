//
//  FootBallNewLocationVC.swift
//  Football Stats
//
//  Created by Chakri on 22/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import Reachability
import iOSDropDown

class FootBallNewLocationVC: UIViewController ,UITextFieldDelegate, NIDropDownDelegate {

    @IBOutlet var txtlocationname: UITextField!
    var btndropdown = NIDropDown ()

    class NetworkState
    {
        class func isConnected() ->Bool
        {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    @IBOutlet var txttown: UITextField!
    @IBOutlet var txtsixth: UITextField!
    @IBOutlet var txtseven: UITextField!
    @IBOutlet var txtfifth: UITextField!
    @IBOutlet var btndelete: UIButton!
    @IBAction func btnconfirmAction(_ sender: Any) {
        self.GameUpdateLocation()
    }
    var hud : MBProgressHUD!
    @IBOutlet var txtsecond: UITextField!
    
    @IBOutlet var txtthird: UITextField!
    
    @IBOutlet var txtpostaldown: UITextField!
    
    @IBOutlet var txtfourth: UITextField!
    
    @IBOutlet var txtfirst: UITextField!
    
    @IBOutlet var btnconfirmlocation: UIButton!
    
    @IBOutlet var delswitch: UISwitch!
   var myString =  ""
    @IBAction func DelswitchAction(_ sender: Any)
    {
        let value = delswitch.isOn
        if value == true
        {
         myString = "0"
         self.showSimpleAlert()
        }
        else
        {
         myString = "1"
        }
    }
    
    @IBAction func btnsearchpostalAction(_ sender: Any)
    {
//        if txtpstalname.text!.count < 6
//        {
//            showToast(message: "Please enter valid postal", font: UIFont.init(name: "", size: 13)!)
//        }
//        else
//        {
            self.GetPostalNames()
        //}
        
    }
    func niDropDownDelegateMethod(_ sender: NIDropDown!)
       {
           
       }
       
       func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
       {
        let array = self.postalarray[sender.tag]
        print(array)
         btnpostal.setTitle(title, for: .normal)
        if let partname = (array as AnyObject).value(forKey: "Postcode") as? String
   {
   self.txtpostaldown.text =  partname

   }
        if let partname = (array as AnyObject).value(forKey: "Line1") as? String
       {
       self.txtfirst.text =  partname

       }
        if let partname = (array as AnyObject).value(forKey: "Line2") as? String
       {
       self.txtsecond.text =  partname

       }
        if let partname = (array as AnyObject).value(forKey: "Line3") as? String
   {
       self.txtthird.text =  partname

       }

        if let partname = (array as AnyObject).value(forKey: "Line4") as? String
       {
       self.txtfourth.text =  partname

       }
        if let partname = (array as AnyObject).value(forKey: "Line5") as? String
      {
      self.txtfifth.text =  partname

      }
        if let partname = (array as AnyObject).value(forKey: "Line6") as? String
       {
       self.txtsixth.text =  partname

       }
        if let partname = (array as AnyObject).value(forKey: "Line7") as? String
       {
       self.txtseven.text =  partname

       }
       }
       func niDropDownHidden(_ sender: NIDropDown!)
       {
           btndropdown.isHidden = true
       }
    @IBAction func btnreviseplayers(_ sender: Any)
       {
           if btndropdown.isDescendant(of: self.view)
           {
              //myView is subview of self.view, remove it.
             btndropdown.removeFromSuperview()
          }
          else
          {
           let myFloatForR = 250
         var r = CGFloat(myFloatForR)
        // lazy var value: Float = 200
         btndropdown.isHidden = false
         btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (postalarray.value(forKey: "Postcode") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
         btndropdown.setDropDownSelectionColor(UIColor.gray)
         btndropdown.delegate = self
                  
           }
       }
    
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    var locationanem:String = ""
    var databasename:String = ""
    var databaseid :String = ""
    var locationarray = NSMutableArray()
    var postalarray = NSMutableArray()
    @IBOutlet var btndate: UIButton!
    
    @IBOutlet var btnpostal: UIButton!
    
    @IBAction func btnpostalAction(_ sender: Any) {
    }
    
    @IBOutlet var txtpstalname: UITextField!
    
    //MARK: //View Didload ///////////////////
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btndate.layer.cornerRadius = 9
        btndate.clipsToBounds = true
        btndate.layer.borderWidth = 1
        btndate.layer.borderColor = UIColor.black.cgColor
        btnpostal.layer.cornerRadius = 9
        btnpostal.clipsToBounds = true
        btnpostal.layer.borderWidth = 1
        btnpostal.layer.borderColor = UIColor.black.cgColor
        btndelete.clipsToBounds = true
        txtpstalname.delegate = self
        btnconfirmlocation.clipsToBounds = true
       btnconfirmlocation.layer.cornerRadius = 22
        txtlocationname.text = locationanem
        //btndate.setTitle(locationanem, for: .normal)
        //self.GetPostalNames()
        self.GetNewLocation()
       btndelete.clipsToBounds = true
      btndelete.layer.borderWidth = 1
      btndelete.layer.borderColor = UIColor.black.cgColor
      btndelete.layer.cornerRadius = 0
               
        // Do any additional setup after loading the view.
    }
    //MARK: APi CAllllll///////////
    
    func GetNewLocation()
                  {
                    if NetworkState.isConnected()
                    {
                         hud = MBProgressHUD.showAdded(to: self.view, animated: true)

       hud.labelText = ""
       
       let str2 =  UserDefaults.standard.object(forKey: "registerid")
       
              // let string = btndateofmatich.currentTitle
           //String(UserDefaults.standard.integer(forKey: "registerid"))
       let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
     let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getLocation","input1":str2 as Any ,"input2":databasename,"input3":"NEW"] as [String : Any]
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
            var skippedArray = NSMutableArray()
                 
                 self.locationarray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                
                 if self.locationarray.count>0
                 {
                     let result = self.locationarray[0] as? NSDictionary

                     if let partname = result!.value(forKey: "LocationName") as? String
              {
                 self.btndate.setTitle(partname, for: .normal)
                     

               }
             if let partname = result!.value(forKey: "line1") as? String
          {
             self.txtfirst.text = partname

           }
         if let partname = result!.value(forKey: "line2") as? String
               {
                  self.txtsecond.text = partname
                self.txtlocationname.text = partname

                }
        if let partname = result!.value(forKey: "line3") as? String
          {
             self.txtthird.text = partname

           }
         if let partname = result!.value(forKey: "line4") as? String
         {
            self.txtfourth.text = partname

          }
                if let partname = result!.value(forKey: "line5") as? String
                {
                self.txtfifth.text = partname

                }
                if let partname = result!.value(forKey: "line6") as? String
                {
                self.txtsixth.text = partname

                }
                if let partname = result!.value(forKey: "line7") as? String
                {
                self.txtseven.text = partname

                }
                if let partname = result!.value(forKey: "postcode") as? String
                {
                self.txtpostaldown.text = partname

                }
              }
               if stringvalue == "Success"
               {
                skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray

                  let dataarray = skippedArray.firstObject as! NSDictionary
                if let partname = dataarray.value(forKey: "database_id") as? Int
              {
                 let databaseid1 = String(partname)
                 self.databaseid = databaseid1
               }
                if let partname = dataarray.value(forKey: "canDelete") as? Int
               {
                  let databaseid1 = String(partname)
                if  databaseid1 == "0"
                {
                    self.btndelete.isHidden = true
                    self.delswitch.isHidden = true
                }
                else
                {
                    self.btndelete.isHidden = false
                    self.delswitch.isHidden = false
                }
                  
                }
               }
               else
               {
                   
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func GameUpdateLocation()
    {
        
            if NetworkState.isConnected()
            {
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                                hud.labelText = ""
                                
                                let str2 =  UserDefaults.standard.object(forKey: "registerid")
                              let databaseint = Int(databaseid)
                             //let myFloat = (btnprize.currentTitle! as NSString).floatValue
                                       // let string = btndateofmatich.currentTitle
                                    //String(UserDefaults.standard.integer(forKey: "registerid"))
                                 let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"addModifyLocation","input1":str2 as Any ,"input2":databaseint as Any,"input3":databaseint as Any,"input4":"","input5":txtlocationname.text!,"input6":txtfirst.text!,"input7": txtsecond.text!,"input8":txtthird.text!,"input9":txtfourth.text!,"input10":txtpostaldown.text!] as [String : Any]
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
                                    var skippedArray = NSMutableArray()
                                      skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                        
                                        if stringvalue == "Success"
                                        {
                                          self.navigationController?.popViewController(animated: true)
                                        }
                                        else
                                        {
                                            
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
    func GameDelLocation()
       {
           
               if NetworkState.isConnected()
               {
                   hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                                   hud.labelText = ""
                                   
                                   let str2 =  UserDefaults.standard.object(forKey: "registerid")
                                 let databaseint = Int(databaseid)
                let delvale = Int(myString)
                                //let myFloat = (btnprize.currentTitle! as NSString).floatValue
                                          // let string = btndateofmatich.currentTitle
                                       //String(UserDefaults.standard.integer(forKey: "registerid"))
                                    let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                                 let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"addModifyLocation","input1":str2 as Any ,"input2":databaseint as Any,"input3":databaseint as Any,"input4":"","input5":btndate.currentTitle!,"input6":txtfirst.text!,"input7": txtsecond.text!,"input8":txtthird.text!,"input9":txtfourth.text!,"input10":delvale as Any] as [String : Any]
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
                                       var skippedArray = NSMutableArray()
                                         skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                           
                                           if stringvalue == "Success"
                                           {
                                             self.navigationController?.popViewController(animated: true)
                                           }
                                           else
                                           {
                                               
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
    func GetPostalNames()
            {
                        
        if NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                hud.labelText = ""
            let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

          let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"GetPostCode","input1":txtpstalname.text!] as [String : Any]
              let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                  AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                  response in
                  DispatchQueue.main.async{
                          self.hud.hide(true)

                          }
                  if let json = response.value
                  {
          let jsonResponse = json as! NSDictionary
              print(jsonResponse)
                  do
                  {
                  
                  var stringvalue:String = ""
                      stringvalue = jsonResponse["status"] as! String
              var skippedArray = NSMutableArray()
                  if stringvalue == "Success"
                  {
                     skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                    if skippedArray.count > 0
                    {
                        let dataarray = skippedArray.firstObject as! NSDictionary
                        self.postalarray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                if let partname = dataarray.value(forKey: "Postcode") as? String
                                {
                                self.txtpostaldown.text =  partname

                                }
                                    if let partname = dataarray.value(forKey: "Line1") as? String
                                    {
                                    self.txtfirst.text =  partname

                                    }
                                    if let partname = dataarray.value(forKey: "Line2") as? String
                                    {
                                    self.txtsecond.text =  partname

                                    }
                                if let partname = dataarray.value(forKey: "Line3") as? String
                                {
                                    self.txtthird.text =  partname

                                    }

                                    if let partname = dataarray.value(forKey: "Line4") as? String
                                    {
                                    self.txtfourth.text =  partname

                                    }
                                    if let partname = dataarray.value(forKey: "Line5") as? String
                                   {
                                   self.txtfifth.text =  partname

                                   }
                                    if let partname = dataarray.value(forKey: "Line6") as? String
                                    {
                                    self.txtsixth.text =  partname

                                    }
                                    if let partname = dataarray.value(forKey: "Line7") as? String
                                    {
                                    self.txtseven.text =  partname

                                    }
                    }
          
                  }
                  else
                  {
                    let dataarray = jsonResponse["Data1"] as! NSDictionary
                    print(dataarray)
                    var errormessage  = ""
                    errormessage = dataarray.value(forKey: "ErrorDescription") as! String
                    print(errormessage)
                //errormessage = jsonResponse["Data1"]!["ErrorDescription"] as? String
                    self.showAlert(message: errormessage)
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
    func showSimpleAlert()
                 {
                   let blurEffect = UIBlurEffect(style: .extraLight)
                        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
                        blurVisualEffectView.frame = view.bounds
                        blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        blurVisualEffectView.alpha = 0.3
                     let alert = UIAlertController(title: "Delete Location", message: "Are you sure you want to Delete Location ?", preferredStyle: UIAlertController.Style.alert)
                   if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first {
                   for innerView in actionSheet.subviews {
                       innerView.backgroundColor = .white
                       innerView.layer.cornerRadius = 15.0
                       innerView.clipsToBounds = true
                       innerView.layer.borderColor = UIColor.black.cgColor
                       innerView.layer.borderWidth = 1
                   }
                   }
                     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                            //Cancel Action
                         blurVisualEffectView.removeFromSuperview()
                        }))
                        alert.addAction(UIAlertAction(title: "Delete",
                              style: UIAlertAction.Style.default,
                              handler: {(_: UIAlertAction!) in
                                self.GameDelLocation()
                            
                       blurVisualEffectView.removeFromSuperview()
                        }))
                   alert.view.tintColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 141.0/255.0, alpha: 1)
                    self.view.addSubview(blurVisualEffectView)
                        self.present(alert, animated: true, completion: nil)
                    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField .resignFirstResponder()
    }
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        {
            if textField  == txtpstalname
                {
                
                                    
                }
            return true
            }
}
