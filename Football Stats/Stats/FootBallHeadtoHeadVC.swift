//
//  FootBallHeadtoHeadVC.swift
//  Football Stats
//
//  Created by Chakri on 07/11/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown

class FootBallHeadtoHeadVC: UIViewController , NIDropDownDelegate
{
 var hud : MBProgressHUD!
    var btndropdown = NIDropDown ()

    @IBOutlet var gamedplayedper: UILabel!
    
    @IBOutlet var playedtogetherper: UILabel!
    
    @IBOutlet var wintogetherper: UILabel!
    
    @IBOutlet var playagainstper: UILabel!
    
    
    @IBOutlet var btnname: UIButton!
    
    @IBOutlet var btnnameoponent: UIButton!
    
    @IBAction func btnnameAction(_ sender: Any)
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
                btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (namesarray.value(forKey: "name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                btndropdown.setDropDownSelectionColor(UIColor.gray)
                btndropdown.delegate = self
                   btndropdown.tag = 0
              }
    }
    
    
    @IBAction func btnnameoponentAction(_ sender: Any)
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
                btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (opoarray.value(forKey: "opponent_name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                btndropdown.setDropDownSelectionColor(UIColor.gray)
                btndropdown.delegate = self
                   btndropdown.tag = 1
              }
    }
    
    @IBOutlet var profilenameimg: UIImageView!
    
    @IBOutlet var profilenameoponentimg: UIImageView!
    
    @IBOutlet var lblapperance: UILabel!
    
    @IBOutlet var lblapperanceoponent: UILabel!
    
    
    @IBOutlet var lblwon: UILabel!
    
    @IBOutlet var lblwonoponent: UILabel!
    
    @IBOutlet var lbllost: UILabel!
    @IBOutlet var lbllostoponent: UILabel!
    
    @IBOutlet var lbldraw: UILabel!
    
    @IBOutlet var lbldrawoponent: UILabel!
    
    @IBOutlet var gamesplayed: UILabel!
    
    
    @IBOutlet var lblplayedtogether: UILabel!
    
    @IBOutlet var lblwintogether: UILabel!
    
    @IBOutlet var lblplayagainst: UILabel!
    
    @IBOutlet var lblheadtohead: UILabel!
    
    @IBOutlet var lblheadtoheadoponent: UILabel!
    @IBOutlet var btnheadtohead: UIButton!
    @IBAction func btnallheadtohead(_ sender: Any)
    {
        let login: FootBallAllHeadsVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallAllHeadsVC") as! FootBallAllHeadsVC)
         self.navigationController?.pushViewController(login!, animated: true)
        
    }
    
    var databasearray =  NSMutableArray()
    var skippedArray = NSMutableArray()
    var opoarray = NSMutableArray()
    var namesarray =  NSMutableArray()
    var oponentarray =  NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnheadtohead.clipsToBounds = true
        btnheadtohead.layer.cornerRadius = 8
        btnheadtohead.layer.borderColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 44.0/255.0, alpha: 1).cgColor
        btnheadtohead.layer.borderWidth = 1
        lblwon.clipsToBounds = true
        lblwon.layer.cornerRadius = 20
        lblwonoponent.clipsToBounds = true
        lblwonoponent.layer.cornerRadius = 20
        
        lblapperance.clipsToBounds = true
        lblapperance.layer.cornerRadius = 20
       lblapperanceoponent.clipsToBounds = true
       lblapperanceoponent.layer.cornerRadius = 20
        
        lbldraw.clipsToBounds = true
        lbldraw.layer.cornerRadius = 20
        lbldrawoponent.clipsToBounds = true
        lbldrawoponent.layer.cornerRadius = 20
        
        lbllost.clipsToBounds = true
       lbllost.layer.cornerRadius = 20
       lbllostoponent.clipsToBounds = true
       lbllostoponent.layer.cornerRadius = 20
        
        lblplayagainst.clipsToBounds = true
        lblplayagainst.layer.cornerRadius = 20
        
        lblplayedtogether.clipsToBounds = true
        lblplayedtogether.layer.cornerRadius = 20
        
        lblwintogether.clipsToBounds = true
        lblwintogether.layer.cornerRadius = 20
        
        lblheadtohead.clipsToBounds = true
        lblheadtohead.layer.cornerRadius = 20
        lblheadtoheadoponent.clipsToBounds = true
        lblheadtoheadoponent.layer.cornerRadius = 20
        
        gamesplayed.clipsToBounds = true
        gamesplayed.layer.cornerRadius = 20
        
        btnname.clipsToBounds = true
        btnname.layer.cornerRadius = 8
        btnname.layer.borderWidth = 1;
        btnname.layer.borderColor = UIColor.black.cgColor
        
       btnnameoponent.clipsToBounds = true
       btnnameoponent.layer.cornerRadius = 8
       btnnameoponent.layer.borderWidth = 1;
       btnnameoponent.layer.borderColor = UIColor.black.cgColor
        
        profilenameimg.clipsToBounds = true
        profilenameimg.layer.cornerRadius = profilenameimg.frame.size.width/2
        
        profilenameoponentimg.clipsToBounds = true
        profilenameoponentimg.layer.cornerRadius = profilenameimg.frame.size.width/2
        
        self.GetHeadTeamCall()
        // Do any additional setup after loading the view.
    }
    //MARK: API CALL////////////////////
    func GetHeadTeamCall()
    {
                   
       hud = MBProgressHUD.showAdded(to: self.view, animated: true)

       hud.labelText = ""
       
       let defaults : UserDefaults = UserDefaults.standard
       var hotelName =  ""
       hotelName = (defaults.value(forKey: "database_name") as! String?)!
         let str2 =  UserDefaults.standard.object(forKey: "registerid")
             
      let verify_param = ["storedProcedureName":"getHeadToHead","input1":str2 as Any ,"input2":hotelName] as [String : Any]
             let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
       AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                   response in
          
                  DispatchQueue.main.async
                      {
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
                                           
                                            
         if stringvalue == "Success"
           {
               
               self.databasearray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
            self.namesarray = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
            self.opoarray = (jsonResponse["Data5"]! as! NSArray).mutableCopy() as! NSMutableArray
                self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
               self.oponentarray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
            
               DispatchQueue.main.async
                {
                    let result = self.skippedArray[0] as? NSDictionary

                                               // var stringvalue1 = ""
               if let partname = result!.value(forKey: "playerName") as? String
                   {
                   
                    self.btnname.setTitle(partname, for: .normal)
               }
                    if let partname = result!.value(forKey: "ProfilePicture") as? String
                      {
                      if partname.count>0
                    {
                    let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                    print(decodedimage)
                    self.profilenameimg.image = decodedimage
                    }
                      
                  }
               }
            let result1 = self.oponentarray[0] as? NSDictionary

                        // var stringvalue1 = ""
               if let partname = result1!.value(forKey: "opponentName") as? String
                   {
                   
                    self.btnnameoponent.setTitle(partname, for: .normal)
               }
                    if let partname = result1!.value(forKey: "opponentProfilePicture") as? String
                      {
                      if partname.count>0
                    {
                    let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                    print(decodedimage)
                    self.profilenameoponentimg.image = decodedimage
                    }
                      
                  }
            let result2 = self.databasearray[0] as? NSDictionary

                // var stringvalue1 = ""
            if let partname = result2!.value(forKey: "name_TotalGames") as? Int
               {
                let str2 = String(partname)
                   self.lblapperance.text = " Apperance"+"  "+str2
               }
            if let partname = result2!.value(forKey: "opp_TotalGames") as? Int
            {
                  let str2 = String(partname)
                self.lblapperanceoponent.text = " Apperance"+"  "+str2
            }
          if let partname = result2!.value(forKey: "Won") as? Int
            {
                let str2 = String(partname)
                self.lblwon.text = "Won "+str2
            }
            if let partname = result2!.value(forKey: "Loss") as? Int
            {
                let str2 = String(partname)
                self.lbllost.text = "Loss "+str2
            }
            if let partname = result2!.value(forKey: "Draw") as? Int
           {
               let str2 = String(partname)
               self.lbldraw.text = "Draw "+str2
           }
            if let partname = result2!.value(forKey: "opponent_Won") as? Int
             {
                let str2 = String(partname)
                 self.lblwonoponent.text = "Won "+str2
             }
             if let partname = result2!.value(forKey: "opponent_Loss") as? Int
             {
                let str2 = String(partname)
                 self.lbllostoponent.text = "Loss "+str2
             }
             if let partname = result2!.value(forKey: "opponent_Draw") as? Int
            {
                let str2 = String(partname)
                self.lbldrawoponent.text = "Draw "+str2
            }
            if let partname = result2!.value(forKey: "playedTogether_percentage") as? Int
               {
                  let str2 = String(partname)
                   self.lblplayedtogether.text = "  Played together "+str2
               }
            if let partname = result2!.value(forKey: "BothPlaying") as? Int
           {
                   let str2 = String(partname)
              // self.gamesplayed.text = "  Games played against/with "+str2
            self.gamedplayedper.text =  str2+" %"
           }
            if let partname = result2!.value(forKey: "wonTogether") as? Int
            {
                    let str2 = String(partname)
                self.lblwintogether.text = "  Win togother % "
                self.wintogetherper.text = str2+" %"
            }
            if let partname = result2!.value(forKey: "playedAgainst") as? Int
           {
                   let str2 = String(partname)
               self.lblplayagainst.text = " Played against "+str2+" time(S)"
            
           }
            if let partname = result2!.value(forKey: "beaten_percentage") as? Int
                      {
                              let str2 = String(partname)
                          self.lblheadtohead.text = "Head-to-head "+str2+" %"
                      }
            
            if let partname = result2!.value(forKey: "lostTo_percentage") as? Int
                      {
                              let str2 = String(partname)
                          self.lblheadtoheadoponent.text = "Head-to-head "+str2+" %"
                      }
            if let partname = result2!.value(forKey: "playedTogether_percentage") as? Int
            {
                    let str2 = String(partname)
                self.playedtogetherper.text = str2+" %"
            }
            if let partname = result2!.value(forKey: "playedAgainst_percentage") as? Int
            {
                    let str2 = String(partname)
                self.playagainstper.text = str2+" %"
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
    func niDropDownDelegateMethod(_ sender: NIDropDown!)
       {
           
       }
       
       func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
       {
           
        if btndropdown.tag == 0
        {
               btnname.setTitle(title, for: .normal)
            self.GetNameHeadCall()
        }
        if btndropdown.tag == 1
       {
              btnnameoponent.setTitle(title, for: .normal)
        self.GetNameoponentHeadCall()
       }
             //  playername = title
       }
       
       func niDropDownHidden(_ sender: NIDropDown!) {
           btndropdown.isHidden = true

       }
    
    //MARK: API CALL////////////////////
       func GetNameHeadCall()
       {
                      
        
        
        if NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                  hud.labelText = ""
                  
                  let defaults : UserDefaults = UserDefaults.standard
                  var hotelName =  ""
                  hotelName = (defaults.value(forKey: "database_name") as! String?)!
                    let str2 =  UserDefaults.standard.object(forKey: "registerid")
                    let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

            let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getHeadToHead","input1":str2 as Any ,"input2":hotelName,"input3":btnname.currentTitle!,"input4":btnnameoponent.currentTitle!] as [String : Any]
                        let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                  AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                              response in
                     
                             DispatchQueue.main.async
                                 {
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
                                                      
                                                       
                    if stringvalue == "Success"
                      {
                          
                          self.databasearray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                       self.namesarray = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
                       self.opoarray = (jsonResponse["Data5"]! as! NSArray).mutableCopy() as! NSMutableArray
                           self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                          self.oponentarray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                       
                          DispatchQueue.main.async
                           {
                               let result = self.skippedArray[0] as? NSDictionary

                                                          // var stringvalue1 = ""
                          if let partname = result!.value(forKey: "playerName") as? String
                              {

                               self.btnname.setTitle(partname, for: .normal)
                          }
                               if let partname = result!.value(forKey: "ProfilePicture") as? String
                                 {
                                 if partname.count>0
                               {
                               let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                               let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                               print(decodedimage)
                               self.profilenameimg.image = decodedimage
                               }

                             }
                          }
                       let result1 = self.oponentarray[0] as? NSDictionary

                                   // var stringvalue1 = ""
                          if let partname = result1!.value(forKey: "opponentName") as? String
                              {

                               self.btnnameoponent.setTitle(partname, for: .normal)
                          }
                               if let partname = result1!.value(forKey: "opponentProfilePicture") as? String
                                 {
                                 if partname.count>0
                               {
                               let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                               let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                               print(decodedimage)
                               self.profilenameoponentimg.image = decodedimage
                               }

                             }
                       let result2 = self.databasearray[0] as? NSDictionary

                           // var stringvalue1 = ""
                       if let partname = result2!.value(forKey: "name_TotalGames") as? Int
                          {
                           let str2 = String(partname)
                              self.lblapperance.text = " Apperance"+"  "+str2
                          }
                       if let partname = result2!.value(forKey: "opp_TotalGames") as? Int
                       {
                             let str2 = String(partname)
                           self.lblapperanceoponent.text = " Apperance"+"  "+str2
                       }
                     if let partname = result2!.value(forKey: "Won") as? Int
                       {
                           let str2 = String(partname)
                           self.lblwon.text = "Won "+str2
                       }
                       if let partname = result2!.value(forKey: "Loss") as? Int
                       {
                           let str2 = String(partname)
                           self.lbllost.text = "Loss "+str2
                       }
                       if let partname = result2!.value(forKey: "Draw") as? Int
                      {
                          let str2 = String(partname)
                          self.lbldraw.text = "Draw "+str2
                      }
                       if let partname = result2!.value(forKey: "opponent_Won") as? Int
                        {
                           let str2 = String(partname)
                            self.lblwonoponent.text = "Won "+str2
                        }
                        if let partname = result2!.value(forKey: "opponent_Loss") as? Int
                        {
                           let str2 = String(partname)
                            self.lbllostoponent.text = "Loss "+str2
                        }
                        if let partname = result2!.value(forKey: "opponent_Draw") as? Int
                       {
                           let str2 = String(partname)
                           self.lbldrawoponent.text = "Draw "+str2
                       }
                       if let partname = result2!.value(forKey: "playedTogether_percentage") as? Int
                          {
                             let str2 = String(partname)
                              self.lblplayedtogether.text = "  Played together "+str2
                          }
                       if let partname = result2!.value(forKey: "BothPlaying") as? Int
                      {
                              let str2 = String(partname)
                         // self.gamesplayed.text = "  Games played against/with "+str2
                       self.gamedplayedper.text =  str2+" %"
                      }
                       if let partname = result2!.value(forKey: "wonTogether") as? Int
                       {
                               let str2 = String(partname)
                           self.lblwintogether.text = "  Win togother % "
                           self.wintogetherper.text = str2+" %"
                       }
                       if let partname = result2!.value(forKey: "playedAgainst") as? Int
                      {
                              let str2 = String(partname)
                          self.lblplayagainst.text = " Played against "+str2+" time(S)"

                      }
                       if let partname = result2!.value(forKey: "beaten_percentage") as? Int
                                 {
                                         let str2 = String(partname)
                                     self.lblheadtohead.text = "Head-to-head "+str2+" %"
                                 }

                       if let partname = result2!.value(forKey: "lostTo_percentage") as? Int
                                 {
                                         let str2 = String(partname)
                                     self.lblheadtoheadoponent.text = "Head-to-head "+str2+" %"
                                 }
                       if let partname = result2!.value(forKey: "playedTogether_percentage") as? Int
                       {
                               let str2 = String(partname)
                           self.playedtogetherper.text = str2+" %"
                       }
                       if let partname = result2!.value(forKey: "playedAgainst_percentage") as? Int
                       {
                               let str2 = String(partname)
                           self.playagainstper.text = str2+" %"
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
    //MARK: API CALL////////////////////
          func GetNameoponentHeadCall()
          {
                 
            
        if NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                hud.labelText = ""
                        
            let defaults : UserDefaults = UserDefaults.standard
            var hotelName =  ""
            hotelName = (defaults.value(forKey: "database_name") as! String?)!
        let str2 =  UserDefaults.standard.object(forKey: "registerid")
        let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

        let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getHeadToHead","input1":str2 as Any ,"input2":hotelName,"input3":btnnameoponent.currentTitle! ,"input4":btnname.currentTitle!] as [String : Any]
                              let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                        AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                                    response in
                           
                                   DispatchQueue.main.async
                                       {
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
                                                            
                                                             
                          if stringvalue == "Success"
                            {
                                
                                self.databasearray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                             self.namesarray = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
                             self.opoarray = (jsonResponse["Data5"]! as! NSArray).mutableCopy() as! NSMutableArray
                                 self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                self.oponentarray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray

                                DispatchQueue.main.async
                                 {
                                     let result = self.skippedArray[0] as? NSDictionary

                                                                // var stringvalue1 = ""
                                if let partname = result!.value(forKey: "playerName") as? String
                                    {

                                     self.btnname.setTitle(partname, for: .normal)
                                }
                                     if let partname = result!.value(forKey: "ProfilePicture") as? String
                                       {
                                       if partname.count>0
                                     {
                                     let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                                     let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                                     print(decodedimage)
                                     self.profilenameimg.image = decodedimage
                                     }

                                   }
                                }
                             let result1 = self.oponentarray[0] as? NSDictionary

                                         // var stringvalue1 = ""
                                if let partname = result1!.value(forKey: "opponentName") as? String
                                    {

                                     self.btnnameoponent.setTitle(partname, for: .normal)
                                }
                                     if let partname = result1!.value(forKey: "opponentProfilePicture") as? String
                                       {
                                       if partname.count>0
                                     {
                                     let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                                     let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                                     print(decodedimage)
                                     self.profilenameoponentimg.image = decodedimage
                                     }

                                   }
                             let result2 = self.databasearray[0] as? NSDictionary

                                 // var stringvalue1 = ""
                             if let partname = result2!.value(forKey: "name_TotalGames") as? Int
                                {
                                 let str2 = String(partname)
                                    self.lblapperance.text = " Apperance"+"  "+str2
                                }
                             if let partname = result2!.value(forKey: "opp_TotalGames") as? Int
                             {
                                   let str2 = String(partname)
                                 self.lblapperanceoponent.text = " Apperance"+"  "+str2
                             }
                           if let partname = result2!.value(forKey: "Won") as? Int
                             {
                                 let str2 = String(partname)
                                 self.lblwon.text = "Won "+str2
                             }
                             if let partname = result2!.value(forKey: "Loss") as? Int
                             {
                                 let str2 = String(partname)
                                 self.lbllost.text = "Loss "+str2
                             }
                             if let partname = result2!.value(forKey: "Draw") as? Int
                            {
                                let str2 = String(partname)
                                self.lbldraw.text = "Draw "+str2
                            }
                             if let partname = result2!.value(forKey: "opponent_Won") as? Int
                              {
                                 let str2 = String(partname)
                                  self.lblwonoponent.text = "Won "+str2
                              }
                              if let partname = result2!.value(forKey: "opponent_Loss") as? Int
                              {
                                 let str2 = String(partname)
                                  self.lbllostoponent.text = "Loss "+str2
                              }
                              if let partname = result2!.value(forKey: "opponent_Draw") as? Int
                             {
                                 let str2 = String(partname)
                                 self.lbldrawoponent.text = "Draw "+str2
                             }
                             if let partname = result2!.value(forKey: "playedTogether_percentage") as? Int
                                {
                                   let str2 = String(partname)
                                    self.lblplayedtogether.text = "  Played together "+str2
                                }
                             if let partname = result2!.value(forKey: "BothPlaying") as? Int
                            {
                                    let str2 = String(partname)
                               // self.gamesplayed.text = "  Games played against/with "+str2
                             self.gamedplayedper.text =  str2+" %"
                            }
                             if let partname = result2!.value(forKey: "wonTogether") as? Int
                             {
                                     let str2 = String(partname)
                                 self.lblwintogether.text = "  Win togother % "
                                 self.wintogetherper.text = str2+" %"
                             }
                             if let partname = result2!.value(forKey: "playedAgainst") as? Int
                            {
                                    let str2 = String(partname)
                                self.lblplayagainst.text = " Played against "+str2+" time(S)"

                            }
                             if let partname = result2!.value(forKey: "beaten_percentage") as? Int
                                       {
                                               let str2 = String(partname)
                                           self.lblheadtohead.text = "Head-to-head "+str2+" %"
                                       }

                             if let partname = result2!.value(forKey: "lostTo_percentage") as? Int
                                       {
                                               let str2 = String(partname)
                                           self.lblheadtoheadoponent.text = "Head-to-head "+str2+" %"
                                       }
                             if let partname = result2!.value(forKey: "playedTogether_percentage") as? Int
                             {
                                     let str2 = String(partname)
                                 self.playedtogetherper.text = str2+" %"
                             }
                             if let partname = result2!.value(forKey: "playedAgainst_percentage") as? Int
                             {
                                     let str2 = String(partname)
                                 self.playagainstper.text = str2+" %"
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

}
