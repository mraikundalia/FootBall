//
//  FootBallPlayVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
class FootBallPlayVC: UIViewController , UITableViewDelegate, UITableViewDataSource , NIDropDownDelegate{
  
    @IBOutlet var gameid: UILabel!
    @IBOutlet var lblgametypetext: UILabel!
    
    @IBOutlet var lblxspaceavail: UILabel!
    
    @IBOutlet var xreverse: UILabel!
    
    @IBOutlet var tuesdayheightcon: NSLayoutConstraint!
    var hud : MBProgressHUD!
    @IBOutlet var btngameset: UIButton!
    var stringvalue1 = ""
    var stringvaluename =  ""
    var hudshow =  ""
    var hotelName =  ""
    
    @IBAction func btntuesdayAction(_ sender: Any) {
        
        if btndropdown.isDescendant(of: self.view) {
                                //myView is subview of self.view, remove it.
                               btndropdown.removeFromSuperview()
                            }
                            else
                            {
            tuesdayheightcon.constant = 250
                let myFloatForR = 250
               
                 var r = CGFloat(myFloatForR)
                // lazy var value: Float = 200
                 btndropdown.isHidden = false
                 btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (defaultdatabase.value(forKey: "database_name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                 btndropdown.setDropDownSelectionColor(UIColor.gray)
                 btndropdown.delegate = self
                    btndropdown.tag = 2
               }
         
        
    }
    
    @IBAction func btngamesettings(_ sender: Any)
    {
        if btntuesday.currentTitle == "Select Database"
        {
            self.showToast(message: "Select DataBase", font: UIFont.systemFont(ofSize: 13))
        }
        else
        {
            let login: FootBallGameSettingVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallGameSettingVC") as! FootBallGameSettingVC)
            login!.btnallowplay =  btntuesday.currentTitle!
            self.navigationController?.pushViewController(login!, animated: true)
        }
        
    }
    
    
    @IBOutlet var btnaddPlayer: UIButton!
    @IBOutlet var bottomview: UIView!
    
    @IBOutlet var playertable: UITableView!
    @IBOutlet var borderview: UIView!
    
    @IBOutlet var btntuesday: UIButton!
    
    @IBOutlet var lbldate: UILabel!
    
    @IBOutlet var btndate: UIButton!
    
    @IBOutlet var btnxspace: UIButton!
    
     var myString: String = ""
    
    @IBOutlet var btncheckbox: UIButton!
    
    var dataarray = NSMutableArray()
    var defaultdatabase = NSMutableArray()
    var x = Int()
    var souceindex  = Int()
    var destination  = Int()
    var icanplay  = Int()
    @IBAction func btncheckboxAction(_ sender: Any)
    {
        if (btncheckbox.isSelected == true)
                        {
              myString = "0"
            btncheckbox.backgroundColor = UIColor.white
            btncheckbox.setBackgroundImage(UIImage(named: ""), for:.normal)
                btncheckbox.isSelected = false;
                            if btntuesday.currentTitle == "Select Database"
                            {
                                self.showToast(message: "Select DataBase", font: UIFont.systemFont(ofSize: 13))
                            }
                            else
                            {
                                self.untickicanPlayCall()
                            }
                            
                }
            else
            {
                    myString = "1"
                         //btncheck1.backgroundColor = UIColor.red
                btncheckbox.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)
                           //UserDefaults.standard.set(txtemail.text, forKey: "emailid")
                      
                    btncheckbox.isSelected = true;
                if btntuesday.currentTitle == "Select Database"
                {
                    self.showToast(message: "Select DataBase", font: UIFont.systemFont(ofSize: 13))
                }
                else
                {
                   self.tickicanPlayCall()
                }
                         
            }
    }
    @IBAction func btnaddplayer(_ sender: Any)
    {
        
        if btntuesday.currentTitle == "Select Database"
        {
            self.showToast(message: "Select DataBase", font: UIFont.systemFont(ofSize: 13))
        }
        else
        {
            let login: FootBallAddPlayersVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallAddPlayersVC") as! FootBallAddPlayersVC)
               login!.playerid = stringvalue1
            login!.databasename = btntuesday.currentTitle!
                self.navigationController?.pushViewController(login!, animated: true)
        }
      
    }
    var btndropdown = NIDropDown ()
      var databasearray =  NSMutableArray()
    var skippedArray = NSMutableArray()
// MARK: View did Load
    override func viewDidLoad()
    {
        super.viewDidLoad()
        bottomview.clipsToBounds = true
       // bottomview.layer.borderWidth = 1
       // bottomview.layer.borderColor = UIColor.darkGray.cgColor
        //borderview.clipsToBounds = true
      // borderview.layer.borderColor = UIColor.lightGray.cgColor
       //borderview.layer.borderWidth = 1
       btntuesday.clipsToBounds = true
       btntuesday.layer.borderColor = UIColor.black.cgColor
       btntuesday.layer.borderWidth = 1
       btnxspace.clipsToBounds = true
       //btnxspace.layer.borderColor = UIColor.black.cgColor
      // btnxspace.layer.borderWidth = 1
    btncheckbox.clipsToBounds = true
    btncheckbox.layer.borderColor = UIColor.darkGray.cgColor
    btncheckbox.layer.borderWidth = 1
        hudshow =  "No"
        playertable.isEditing = true
        
        self.GetDatabaseNames()
        let defaults : UserDefaults = UserDefaults.standard
             hotelName = (defaults.value(forKey: "database_name") as! String?)!
         if(hotelName != "")
         {
             btntuesday .setTitle(hotelName, for: .normal)
             self.PlayCall()
          }
    }
    var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
       //      var recents = ["THE GOBBLER", "THE VENETIAN"]
       //      var favorites = ["FRIES", "THE VENETIAN"]
       //    var Features = ["FRESH CUT FRIES", "STIR FRY QUINOA"]
var menuimages = ["download", "download", "download" ,"download","download","download" ]
    override func viewDidAppear(_ animated: Bool)
    {
       
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return self.skippedArray.count
            
        }
        
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
                  {
                      let cell = tableView.dequeueReusableCell(withIdentifier: "FootBallPlayerTableCell", for: indexPath as IndexPath) as! FootBallPlayerTableCell
                    
                      DispatchQueue.main.async{
                       let array = self.skippedArray[indexPath.row]
                        let x : Int = (array as AnyObject).value(forKey: "PlayerNumber") as! Int
                           // (array  as AnyObject).value(forKey: "ICanPlay_id") as? String
                        let myString = String(x)
                        cell.serialnum.text = myString
                        cell.serialnum.clipsToBounds = true
                        cell.serialnum.layer.cornerRadius =   cell.serialnum.frame.size.width/2
                        cell.serialnum.layer.borderWidth = 1
                        cell.serialnum.layer.borderColor = UIColor.darkGray.cgColor
                    cell.profilename.text = (array  as AnyObject).value(forKey: "name") as? String
                        cell.borderview.clipsToBounds = true
                        cell.borderview.layer.cornerRadius = 32
                        cell.borderview.layer.borderWidth = 1;
                        cell.borderview.layer.borderColor =  UIColor.lightGray.cgColor
                       
                            //UIColor.init(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 0).cgColor
                        cell.profileimage.clipsToBounds = true
                        cell.profileimage.layer.cornerRadius = cell.profileimage.frame.size.width/2
                        //(array as AnyObject).value(forKey: "ICanPlay_id") as? String
                    DispatchQueue.main.async{
                        if let partname = (array as AnyObject).value(forKey: "playerPicture") as? String
                      {
                          if partname.count>0
                          {
                              let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                         let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                         print(decodedimage)
                        cell.profileimage.image = decodedimage
                            
                          }
                   
                  
                      }
                    }
           
                    
          //cell.storeImage.sd_setImage(with: URL(string:(array as AnyObject).value(forKey: "seller_store_image") as! String), placeholderImage: UIImage(named: ""))
                    
                                  
                    }
//                      cell.profilename.text = menu[indexPath.row]
//                        //
//                        //cell..selectionStyle = .none
//                   let image : UIImage = UIImage(named:menuimages[indexPath.row] )!
//                   cell.profileimage.image = image
//                    cell.profileimage.clipsToBounds = true
//                    cell.profileimage.layer.cornerRadius =  cell.profileimage.frame.size.width/2;
                    
                    
                    
                    return cell
           }
              func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                  return 70.0;//Choose your custom row height
              }
        
          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
                  {
        //           if indexPath.row == 0
                  // {
                    self.showSimpleAlert()
  
                   }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
         return .none
     }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    {
         return false
     }

   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
   
   {
         let movedObject = self.skippedArray[sourceIndexPath.row]
        self.skippedArray.remove(sourceIndexPath.row)
      let array = self.skippedArray[sourceIndexPath.row]
    if let partname = (array as AnyObject).value(forKey: "name") as? String
       {
        stringvaluename = partname
        }
    self.skippedArray.insert(movedObject, at: destinationIndexPath.row)
    
         debugPrint("\(sourceIndexPath.row) => \(destinationIndexPath.row)")
    souceindex = sourceIndexPath.row
    destination = destinationIndexPath.row
    if let partname = (array as AnyObject).value(forKey: "ICanPlay_id") as? Int
          {
           icanplay = partname
           }
  
    self.Reorderelements()
         // To check for correctness enable: self.tableView.reloadData()
    
     }
        //           else
        //           {
        //               let login: ConsiciousBirthdayVC? = (storyboard?.instantiateViewController(withIdentifier: "ConsiciousBirthdayVC") as! ConsiciousBirthdayVC)
        //               self.navigationController?.pushViewController(login!, animated: true)
        //           }
                  
            /*
            // MARK: - Navigation

            // In a storyboard-based application, you will often want to do a little preparation before navigation
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Get the new view controller using segue.destination.
                // Pass the selected object to the new view controller.
            }
            */

        
        
       
       

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    

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
                     blurVisualEffectView.alpha = 0.3
                  let alert = UIAlertController(title: "Remove player for game", message: "Are you sure you want to remove player?", preferredStyle: UIAlertController.Style.alert)
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
                     alert.addAction(UIAlertAction(title: "Remove Player",
                                                   style: UIAlertAction.Style.default,
                                                   handler: {(_: UIAlertAction!) in
                                                     //Sign out action
                    blurVisualEffectView.removeFromSuperview()
                     }))
                     self.present(alert, animated: true, completion: nil)
                 }
    
   
    func niDropDownDelegateMethod(_ sender: NIDropDown!) {
           
       }
       
       func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
       {
           tuesdayheightcon.constant = 130
               btntuesday.setTitle(title, for:.normal)
        self.skippedArray.removeAllObjects()
                self.PlayCall()
       }

       func niDropDownHidden(_ sender: NIDropDown!)
       {
           tuesdayheightcon.constant = 130
           btndropdown.isHidden = true
       }
     //MARK: Api Call/////////////
        
        func GetDatabaseNames()
                {


                    //hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                        //hud.labelText = ""
                  //SVProgressHUD.show()
        //            var string = String.self
        //            string = UserDefaults.standard.integer(forKey: "registerid")
                    let str2 =  UserDefaults.standard.object(forKey: "registerid")
                            
                        //String(UserDefaults.standard.integer(forKey: "registerid"))
                    let verify_param = ["storedProcedureName":"getDatabaseNames","input1":str2 as Any] as [String : Any]
                        let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                    AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                              response in
                            DispatchQueue.main.async{

                                //self.hud.hide(true)

                                }
                            //  SVProgressHUD.dismiss()
                           if let json = response.value
                           {
                      let jsonResponse = json as! NSDictionary
                          print(jsonResponse)
                           do
                           {
                              //UserDefaults.standard.set(jsonResponse.object(forKey: "register_id"), forKey: "registerid")
                            var skippedArray = NSMutableArray()
                            skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                            
                            let dataarray = skippedArray.firstObject as! NSDictionary
                           
                            self.defaultdatabase = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                          
                            if self.databasearray.count>0
                            {
                               // btndateofmatich .setTitle((self.databasearray.object(0), for: <#T##UIControl.State#>)
                              //  UserDefaults.standard.array(dataarray, forKey:"databasearray")

                            }
                            else
                            {
                               
                            }

                            //Integer
        //                      let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
        //                         self.navigationController?.pushViewController(login!, animated: true)
                          }
                        }
                       }
                  
                  }
        func PlayCall()
                  {
                    //SVProgressHUD.show()
          //            var string = String.self
          //            string = UserDefaults.standard.integer(forKey: "registerid")
                    
                    if hudshow ==  "No"
                    {
                      
                    hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                    hud.labelText = ""
                    }
                    else if hudshow ==  "YES"
                    {
                        
                    }
                    
                      let str2 =  UserDefaults.standard.object(forKey: "registerid")
                             // let string = btndateofmatich.currentTitle
                          //String(UserDefaults.standard.integer(forKey: "registerid"))
                   let verify_param = ["storedProcedureName":"getPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!] as [String : Any]
                          let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                    AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                                response in
                               DispatchQueue.main.async{

                                if self.hudshow ==  "No"
                                {
                                   self.hud.hide(true)
                                
                                }
                                else  if self.hudshow ==  "YES"
                                {
                                   self.hud.hide(true)
                                }
                                     

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
                            //et dataarray = skippedArray1.firstObject as! NSDictionary

                           // self.databasearray = (jsonResponse["Data2"] as? NSArray)! as! NSMutableArray
                            let result = self.databasearray[0] as? NSDictionary

                           // var stringvalue1 = ""
                      
                            if let partname = result!.value(forKey: "game_date") as? String
                                {
                                    let datestrmg:String = partname.replacingOccurrences(of: "T00:00:00", with: "", options: NSString.CompareOptions.literal, range: nil)
                                 
                                    self.lbldate.text = datestrmg
                            }
                            
                            if let partname = result!.value(forKey: "gametype") as? String
                           {
                          
                            self.lblgametypetext.text = partname
                            }
                            if let partname = result!.value(forKey: "spacesAvailable") as? String
                          {
                            // let str2 = String(partname)
                           self.lblxspaceavail.text = partname
                           }
                            if let partname = result!.value(forKey: "reserves") as? String
                             {
                                // let str2 = String(partname)
                              self.xreverse.text = partname
                              }
                            if let partname = result!.value(forKey: "Game_ID") as? Int
                            {
                            let str2 = String(partname)
                             self.gameid.text = str2
                             }
                            self.stringvalue1 =  NSString(format: "%@",(result!.value(forKey: "iCanPlay_id") as! CVarArg)) as String
                            print(self.stringvalue1)
                            
                            
                        self.skippedArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                            DispatchQueue.main.async{
                               self.playertable.reloadData()
                            }
                        
                            }
                        else
                      {
                         var skippedArray1 = NSMutableArray()
                      skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                       let dataarray = skippedArray1.firstObject as! NSDictionary
                        var stringvalue1:String = ""
                         stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                         self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                                }
                            }
                          }
                         }
                    
                    }
    func tickicanPlayCall()
                {
                  //SVProgressHUD.show()
        //            var string = String.self
        //            string = UserDefaults.standard.integer(forKey: "registerid")
                 hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.labelText = ""
                    let str2 =  UserDefaults.standard.object(forKey: "registerid")
                    let myInt1 = Int(myString)
                    //let playid = Int(stringvalue1)
                 let verify_param = ["storedProcedureName":"iCanPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!,"input3":"","input4":myInt1 as Any] as [String : Any]
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
                            
                      self.skippedArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                      self.playertable.reloadData()
                          }
                      else
                    {
                       var skippedArray1 = NSMutableArray()
                    skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                     let dataarray = skippedArray1.firstObject as! NSDictionary
                      var stringvalue1:String = ""
                       stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                       self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                              }
                          }
                        }
                       }
                  
                  }
    func untickicanPlayCall()
                  {
                    //SVProgressHUD.show()
          //            var string = String.self
          //            string = UserDefaults.standard.integer(forKey: "registerid")
                   hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                  hud.labelText = ""
                      let str2 =  UserDefaults.standard.object(forKey: "registerid")
                      let myInt1 = Int(myString)
                    // let playid = Int(stringvalue1)
                   let verify_param = ["storedProcedureName":"iCanPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!,"input3":"","input4":myInt1 as Any] as [String : Any]
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
                              
                        self.skippedArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                        self.playertable.reloadData()
                            }
                        else
                      {
                         var skippedArray1 = NSMutableArray()
                      skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                       let dataarray = skippedArray1.firstObject as! NSDictionary
                        var stringvalue1:String = ""
                         stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                         self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                                }
                            }
                          }
                         }
                    
                    }
    func icanPlayCall()
        {
                    //SVProgressHUD.show()
            //            var string = String.self
            //            string = UserDefaults.standard.integer(forKey: "registerid")
                    hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.labelText = ""
                        let str2 =  UserDefaults.standard.object(forKey: "registerid")
                        let myInt1 = Int(myString)
                    let verify_param = ["storedProcedureName":"getPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!,"input3":btntuesday.currentTitle!,"input4":myInt1 as Any] as [String : Any]
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
                    self.skippedArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                                
                        if stringvalue == "Success"
                        {
                                
                        self.skippedArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                        self.playertable.reloadData()
                            }
                        else
                        {
                        var skippedArray1 = NSMutableArray()
                        skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                        let dataarray = skippedArray1.firstObject as! NSDictionary
                        var stringvalue1:String = ""
                        stringvalue1 = dataarray.value(forKey:"Column1") as! String
                        self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                                }
                            }
                            }
                        }
                    
                    }
    func Reorderelements()
           {
                       //SVProgressHUD.show()
               //            var string = String.self
               //            string = UserDefaults.standard.integer(forKey: "registerid")
                       hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                       hud.labelText = ""
                           let str2 =  UserDefaults.standard.object(forKey: "registerid")
                           //let myInt1 = Int(myString)
                       let verify_param = ["storedProcedureName":"iCanPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!,"input3":stringvaluename,"input4":icanplay as Any,"input5":souceindex as Any,"input6":destination as Any] as [String : Any]
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
                         var skippedArray1 = NSMutableArray()
                            
                           skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                           let dataarray = skippedArray1.firstObject as! NSDictionary
                           var stringvalue1:String = ""
                           stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                           self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                            self.hudshow = "YES"
                            self.PlayCall()
                               }
                           else
                           {
                            
                           var skippedArray1 = NSMutableArray()
                           skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                           let dataarray = skippedArray1.firstObject as! NSDictionary
                           var stringvalue1:String = ""
                           stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                            if stringvalue1 == "Failure - Someone else has change the ordering already"
                            {
                                self.hudshow = "YES"
                                self.PlayCall()
                            }
                                
                           self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                             
                             }
                               }
                                
                               }
                           }
                       
                       }
       
}
