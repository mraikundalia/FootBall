//
//  FootBallPickGameSettingVC.swift
//  Football Stats
//
//  Created by Chakri on 17/10/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
import Reachability

class FootBallPickGameSettingVC: UIViewController , NIDropDownDelegate
{
    
    class NetworkState
    {
        class func isConnected() ->Bool
        {
            return NetworkReachabilityManager()!.isReachable
        }
    }
      var hud : MBProgressHUD!
    
    @IBOutlet var lbladdresstext: UILabel!
    
    
    var LocationArray = NSMutableArray()
       var reverseplayers = NSMutableArray()
       var gamesetting = NSMutableArray()
         var btndropdown = NIDropDown ()
         var stringvalue1 = ""

    @IBOutlet var btndate: UIButton!
    
    @IBOutlet var btngametype: UIButton!
    
    @IBOutlet var btnpitchlocation: UIButton!
    
    @IBOutlet var backAction: UIButton!
    
    @IBAction func btnbackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var btncost: UIButton!
    
    @IBAction func btndatAction(_ sender: Any)
    {
//        let myFloatForR = 250
//               var r = CGFloat(myFloatForR)
//              // lazy var value: Float = 200
//               btndropdown.isHidden = false
//               btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (LocationArray.value(forKey: "LocationName") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
//               btndropdown.setDropDownSelectionColor(UIColor.gray)
//               btndropdown.delegate = self
//        btndropdown.tag = 0
    }
    @IBAction func btngametypeAction(_ sender: Any)
    {
//        let myFloatForR = 250
//               var r = CGFloat(myFloatForR)
//              // lazy var value: Float = 200
//               btndropdown.isHidden = false
//               btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (gamesetting.value(forKey: "GameTypes") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
//               btndropdown.setDropDownSelectionColor(UIColor.gray)
//               btndropdown.delegate = self
//        btndropdown.tag = 0
    }
    
    @IBAction func btnpitchAction(_ sender: Any) {
//        let myFloatForR = 250
//               var r = CGFloat(myFloatForR)
//              // lazy var value: Float = 200
//               btndropdown.isHidden = false
//               btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (LocationArray.value(forKey: "LocationName") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
//               btndropdown.setDropDownSelectionColor(UIColor.gray)
//               btndropdown.delegate = self
//             btndropdown.tag = 1
    }
    
    @IBAction func btncostAction(_ sender: Any)
    {
        
    }
    
      var btnallowplay:String = ""
    //MARK: // ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.Gamesettings()
        btndate.clipsToBounds = true
               btndate.layer.cornerRadius = 9
               btndate.layer.borderWidth = 1
               btndate.layer.borderColor = UIColor.black.cgColor
               btngametype.clipsToBounds = true
              btngametype.layer.cornerRadius = 9
             btngametype.layer.borderWidth = 1
                btngametype.layer.borderColor = UIColor.black.cgColor
             
               btnpitchlocation.clipsToBounds = true
                btnpitchlocation.layer.cornerRadius = 9
                btnpitchlocation.layer.borderWidth = 1
                btnpitchlocation.layer.borderColor = UIColor.black.cgColor
                btncost.clipsToBounds = true
               btncost.layer.cornerRadius = 9
               btncost.layer.borderWidth = 1
               btncost.layer.borderColor = UIColor.black.cgColor
        lbladdresstext.clipsToBounds = true
        lbladdresstext.layer.cornerRadius = 9
        lbladdresstext.layer.borderWidth = 1
        lbladdresstext.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    
    func niDropDownDelegateMethod(_ sender: NIDropDown!)
    {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
        if btndropdown.tag == 0
        {
            btngametype.setTitle(title, for:.normal)
        }
        else if btndropdown.tag == 1
        {
        btnpitchlocation.setTitle(title, for: .normal)
        }
    }
    
    func niDropDownHidden(_ sender: NIDropDown!)
    {
        
        btndropdown.isHidden = true
    }
    //MARK: Api CAll
    func Gamesettings()
                  {

                    
                    if NetworkState.isConnected()
                    {
                        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                      hud.labelText = ""
                      
                      let str2 =  UserDefaults.standard.object(forKey: "registerid")
                      let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                                          
        let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getGameSettings","input1":str2 as Any ,"input2":btnallowplay] as [String : Any]
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
                self.LocationArray = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
           self.reverseplayers = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
           self.gamesetting = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
               let dataarray = skippedArray.firstObject as! NSDictionary
                   //let result = self.dataarray[0] as? NSDictionary

                       //  var stringvalue1 = ""
                           //self.stringvalue1 =  NSString(format: "%@",(dataarray.value(forKey: "game_ID") as! CVarArg)) as String
                           if let partname = dataarray.value(forKey: "Game_ID") as? String
                           {
                               
                               self.stringvalue1 = partname
                               
                               print(self.stringvalue1)
                               
                            }
                           

                    if let partname = dataarray.value(forKey: "game_date") as? String
                  {
                   self.btndate.setTitle(partname, for: .normal)

                   }
                   if let partname = dataarray.value(forKey: "gametype") as? String
                    {
                       self.btngametype.setTitle(partname, for: .normal)
                     }
                   if let partname = dataarray.value(forKey: "locationName") as? String
                    {
                       self.btnpitchlocation.setTitle(partname, for: .normal)
                     }
                  if let partname = dataarray.value(forKey: "LocationAddress") as? String
                        {
                         self.lbladdresstext.text = partname
                         }
                  
                   if let partname = dataarray.value(forKey: "cost") as? Int
                    {
                   let str2 = String(partname)
                   let combined1 = "£" + str2
                       self.btncost.setTitle(combined1, for: .normal)
                     }
                                                                                        
                      }
                      else
                      {
                          
                      }
                      
     
                    }
                  }
                 }
                    }
                    else{
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
