//
//  FootBallResultPlayerVC.swift
//  Football Stats
//
//  Created by Chakri on 29/10/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
import Reachability
class FootBallResultPlayerVC: UIViewController , NIDropDownDelegate, UITextViewDelegate
{
    class NetworkState
             {
                 class func isConnected() ->Bool
                 {
                     return NetworkReachabilityManager()!.isReachable
                 }
             }
    
    
    
    @IBOutlet var profileimage: UIImageView!
    
    @IBAction func btncheck(_ sender: Any) {
        
        if (btncheck.isSelected == true)
               {
             myString = "0"
           btncheck.backgroundColor = UIColor.white
           btncheck.setBackgroundImage(UIImage(named: ""), for:.normal)
               btncheck.isSelected = false;
          
         }
                   else
                   {
           myString = "1"
                //btncheck1.backgroundColor = UIColor.red
       btncheck.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)
                    btncheck.isSelected = true
                  //UserDefaults.standard.set(txtemail.text, forKey: "emailid")
      
                                
                   }
    }
    func niDropDownDelegateMethod(_ sender: NIDropDown!)
    {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
        
    }
    
    func niDropDownHidden(_ sender: NIDropDown!)
    {
        
    }
    
    
    var hud : MBProgressHUD!
      var btndropdown = NIDropDown ()
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.GetPayerUpdateResult()
    }
    
    @IBOutlet var lblmanofmatch: UILabel!
    @IBOutlet var lblheadertitle: UILabel!
    @IBOutlet var txtplayernote: UITextView!
    @IBOutlet var btnasists: UIButton!
    @IBOutlet var btngoals: UIButton!
    @IBOutlet var btncheck: UIButton!
     var myString  = ""
      var playername = ""
    var gameid = ""
    var momvotestr = ""
    var ismestr = ""
    var alreadyvotstr = ""
    var myvotestr = ""
    var databasearray =  NSMutableArray()
      var skippedArray = NSMutableArray()
      var momactive = NSMutableArray()
      var myVote = NSMutableArray()
     var alreadyVoted = NSMutableArray()
    var thisIsMe = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        btncheck.clipsToBounds = true
        btncheck.layer.cornerRadius = 5
        btncheck.layer.borderWidth = 1
        btncheck.layer.borderColor = UIColor.black.cgColor
        btngoals.layer.cornerRadius = 5;
        btngoals.layer.borderWidth = 1;
        btngoals.layer.borderColor = UIColor.black.cgColor
        btngoals.clipsToBounds = true
        btnasists.layer.cornerRadius = 5;
       btnasists.layer.borderWidth = 1;
       btnasists.layer.borderColor = UIColor.black.cgColor
       btnasists.clipsToBounds = true
      txtplayernote.layer.cornerRadius = 5;
      txtplayernote.layer.borderWidth = 1;
      txtplayernote.layer.borderColor = UIColor.black.cgColor
      txtplayernote.clipsToBounds = true
        profileimage.clipsToBounds = true
        profileimage.layer.cornerRadius =  profileimage.frame.size.width/2
        self.GetPayerResult()
        // Do any additional setup after loading the view.
    }
    
      //MARK: API CALL////////////////////
    func GetPayerResult()
   {

    if NetworkState.isConnected()
    {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

            hud.labelText = ""
            
            let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

              let str2 =  UserDefaults.standard.object(forKey: "registerid")
                     // let string = btndateofmatich.currentTitle
                  //String(UserDefaults.standard.integer(forKey: "registerid"))
           let gameidint = Int(gameid)
           
           let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getMatchResult_player","input1":str2 as Any ,"input2":gameidint as Any,"input3":playername] as [String : Any]
                  let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
            AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                        response in
               
                       DispatchQueue.main.async
                           {
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
                    
                    self.databasearray = (jsonResponse["Data5"]! as! NSArray).mutableCopy() as! NSMutableArray
                    //et dataarray = skippedArray1.firstObject as! NSDictionary

                   // self.databasearray = (jsonResponse["Data2"] as? NSArray)! as! NSMutableArray
                    let result = self.databasearray[0] as? NSDictionary

                   // var stringvalue1 = ""
              
                        if let partname = result!.value(forKey: "assists") as? Int
                            {
                                let str2 = String(partname)
                               self.btnasists.setTitle(str2, for: .normal)
                                //self.lbldate.text = datestrmg
                        }
                        if let partname = result!.value(forKey: "name") as? String
                       {

                       // self.lblgametypetext.text = partname
                           self.lblheadertitle.text = partname
                           
                        }
                        if let partname = result!.value(forKey: "goals") as? String
                      {
                        // let str2 = String(partname)
                       //self.lblxspaceavail.text = partname
                       self.btngoals.setTitle(partname, for: .normal)
                       }
                        if let partname = result!.value(forKey: "comments") as? String
                         {
                            // let str2 = String(partname)
                         // self.xreverse.text = partname
                           self.txtplayernote.text = partname
                          }
                      
                   if let partname = result!.value(forKey: "game_id") as? Int
                   {
                      let str2 = String(partname)
                       self.gameid = str2
                       
                    }
                        self.gameid =  NSString(format: "%@",(result!.value(forKey: "game_id") as! CVarArg)) as String
                        print(self.gameid)

                    
                //self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                      self.thisIsMe = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
                      self.myVote = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                      self.momactive = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                     self.alreadyVoted = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                     let isme = self.thisIsMe[0] as? NSDictionary
                   let myvote1 = self.myVote[0] as? NSDictionary
                      let already = self.myVote[0] as? NSDictionary
                      let momactive1 = self.momactive[0] as? NSDictionary
                   
                   if let partname = isme!.value(forKey: "thisIsMe") as? Int
                   {
                       if partname == 0
                        {
                            self.btncheck.isHidden = true
                            self.lblmanofmatch.isHidden = true
                        }
                        else
                        {
                            self.btncheck.isHidden = false
                            self.lblmanofmatch.isHidden = false
                        }
                  
                   
                    }
                   if let partname = myvote1!.value(forKey: "myVote") as? Int
                      {
                       let str2 = String(partname)
                       self.myvotestr = str2
                       
                      
                       }
                   if let partname = momactive1!.value(forKey: "MOMActive") as? Int
                      {
                        let str2 = String(partname)
                       self.momvotestr = str2
                       if partname == 0
                       {
                           self.btncheck.isHidden = true
                           self.lblmanofmatch.isHidden = true
                       }
                       else
                       {
                           self.btncheck.isHidden = false
                           self.lblmanofmatch.isHidden = false
                       }
                        
                      
                       }
                   if let partname = already!.value(forKey: "alreadyVoted") as? Int
                     {
                        let str2 = String(partname)
                       self.alreadyvotstr = str2
                       // let str2 = String(partname)
                     // self.xreverse.text = partname
                     
                      }
                   
                   if self.myvotestr == "1" && self.alreadyvotstr == "1"
                   {
                       self.btncheck.isHidden = true
                       self.lblmanofmatch.isHidden = true
                   }
                   else   if self.myvotestr == "0" && self.alreadyvotstr == "1"
                   {
                       self.btncheck.isHidden = false
                       self.lblmanofmatch.isHidden = false
                   }
                    DispatchQueue.main.async{
                    }
                
                    }
                        else
                      {
                         var skippedArray1 = NSMutableArray()
                      skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                       let dataarray = skippedArray1.firstObject as! NSDictionary
                        var stringvalue1:String = ""
                         stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                        // self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                        self.showAlert(message: stringvalue1)
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
    
    func GetPayerUpdateResult()
   {
        if NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                    hud.labelText = ""
                    
                    
                    let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

                      let str2 =  UserDefaults.standard.object(forKey: "registerid")
                             // let string = btndateofmatich.currentTitle
                          //String(UserDefaults.standard.integer(forKey: "registerid"))
                   let myInt1 = Int(momvotestr)
                   let gameid1 = Int(gameid)

                   let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"update_MatchResult_player","input1":str2 as Any ,"input2":gameid1 as Any,"input3":playername,"input4":myInt1 as Any,"input5":btngoals.currentTitle!,"input6":btnasists.currentTitle!,"input7":txtplayernote.text as Any] as [String : Any]
                          let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                    AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                                response in
                       
                               DispatchQueue.main.async
                                   {
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
                            
                           
                            self.databasearray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                            let result = self.databasearray[0] as? NSDictionary

                                if let partname = result!.value(forKey: "Confirmation") as? String
                                    {
                                    
                                        self.showAlert(message: partname)
                                       self.navigationController?.popViewController(animated: true)
                                    }
                            }
                                else
                              {
                                 var skippedArray1 = NSMutableArray()
                              skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                               let dataarray = skippedArray1.firstObject as! NSDictionary
                                var stringvalue1:String = ""
                                 stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                                 //self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                                self.showAlert(message: stringvalue1)
                               self.navigationController?.popViewController(animated: true)

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
