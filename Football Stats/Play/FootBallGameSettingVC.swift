//
//  FootBallGameSettingVC.swift
//  Football Stats
//
//  Created by Chakri on 22/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
import Reachability

class FootBallGameSettingVC: UIViewController ,NIDropDownDelegate, UITextFieldDelegate
{
    class NetworkState
    {
        class func isConnected() ->Bool
        {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    @IBOutlet var txtdate: UITextField!
    @IBOutlet var btntime: UIButton!
    
    @IBOutlet var lbladdresstex: UILabel!
    
    
    
    
    func niDropDownDelegateMethod(_ sender: NIDropDown!)
    {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
        if btndropdown.tag == 2
        {
            btnreviseplayers.setTitle(title, for:.normal)
        }
        else if btndropdown.tag == 0
        {
        btnalperton.setTitle(title, for: .normal)
        }
        else if btndropdown.tag == 1
       {
       btngametype.setTitle(title, for: .normal)
       }
       
    }
    
    func niDropDownHidden(_ sender: NIDropDown!)
    {
        
        btndropdown.isHidden = true
    }
         var hud : MBProgressHUD!
    
    @IBAction func btndateAction(_ sender: Any)
    {
    }
    
    @IBOutlet var txtamount: UITextField!
    
    
    @IBAction func btnconfirmAction(_ sender: Any) {
        imfrom = "Confirm Game"
        self.Gamesettingsupdate()
    }
    
     var stringvalue1 = ""
    @IBAction func btnpitchlocation(_ sender: Any)
    {
        
        let myFloatForR = 250
                      var r = CGFloat(myFloatForR)
                     // lazy var value: Float = 200
                      btndropdown.isHidden = false
                      btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (LocationArray.value(forKey: "LocationName") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                      btndropdown.setDropDownSelectionColor(UIColor.gray)
                      btndropdown.delegate = self
               btndropdown.tag = 0
    }
    
    @IBAction func btnprice(_ sender: Any)
    {
        
    }
    
    
    @IBAction func btnback(_ sender: Any)
    {
        imfrom = "Back"
        self.Gamesettingsupdate()
    }
    
    @IBAction func btnsetnewlocation(_ sender: Any) {
        
        if btnalperton.currentTitle == "TBC"
        {
            
        }
        else
        {
        let login:FootBallNewLocationVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallNewLocationVC") as! FootBallNewLocationVC)
               login!.databasename = btnallowplay
               login!.locationanem = btnalperton.currentTitle!
               self.navigationController?.pushViewController(login!, animated: true)
        }
       
        
    }
    @IBOutlet var btndate: UIButton!
    
    var btnallowplay:String = ""
     var imfrom:String = ""
    @IBOutlet var btngametype: UIButton!
    
    @IBOutlet var btnreviseplayers: UIButton!
    
    @IBOutlet var btnalperton: UIButton!
    

    @IBOutlet var btnprize: UIButton!
    
    
    @IBOutlet var btnconfirmgame: UIButton!
    
    @IBAction func btnreviseplayers(_ sender: Any) {
        let myFloatForR = 250
                      var r = CGFloat(myFloatForR)
                     // lazy var value: Float = 200
                      btndropdown.isHidden = false
                      btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (reverseplayers.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                      btndropdown.setDropDownSelectionColor(UIColor.gray)
                      btndropdown.delegate = self
               btndropdown.tag = 2
    }
    
    @IBAction func btngametype(_ sender: Any)
    {
        let myFloatForR = 250
        var r = CGFloat(myFloatForR)
       // lazy var value: Float = 200
        btndropdown.isHidden = false
        btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (gamesetting.value(forKey: "GameTypes") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
        btndropdown.setDropDownSelectionColor(UIColor.gray)
        btndropdown.delegate = self
       btndropdown.tag = 1
        
    }
    var LocationArray = NSMutableArray()
    var reverseplayers = NSMutableArray()
    var gamesetting = NSMutableArray()
      var btndropdown = NIDropDown ()
    
    //MARK:   ViewDidLoad ///////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btndate.clipsToBounds = true
        btndate.layer.cornerRadius = 9
        btndate.layer.borderWidth = 1
        btndate.layer.borderColor = UIColor.black.cgColor
        btngametype.clipsToBounds = true
              btngametype.layer.cornerRadius = 9
              btngametype.layer.borderWidth = 1
              btngametype.layer.borderColor = UIColor.black.cgColor
        btnreviseplayers.clipsToBounds = true
         btnreviseplayers.layer.cornerRadius = 9
         btnreviseplayers.layer.borderWidth = 1
         btnreviseplayers.layer.borderColor = UIColor.black.cgColor
        btnalperton.clipsToBounds = true
         btnalperton.layer.cornerRadius = 9
         btnalperton.layer.borderWidth = 1
         btnalperton.layer.borderColor = UIColor.black.cgColor
         btnprize.clipsToBounds = true
        btnprize.layer.cornerRadius = 9
        btnprize.layer.borderWidth = 1
        btnprize.layer.borderColor = UIColor.black.cgColor
        btnprize.layer.cornerRadius = 9
        
        btntime.clipsToBounds = true
        btntime.layer.borderWidth = 1
        btntime.layer.borderColor = UIColor.black.cgColor
        btntime.layer.cornerRadius = 9
       
        lbladdresstex.clipsToBounds = true
        lbladdresstex.layer.borderWidth = 1
        lbladdresstex.layer.borderColor = UIColor.black.cgColor
        lbladdresstex.layer.cornerRadius = 9
        
        txtdate.clipsToBounds = true
       txtdate.layer.borderWidth = 1
       txtdate.layer.borderColor = UIColor.black.cgColor
       txtdate.layer.cornerRadius = 9
        
        btnconfirmgame.clipsToBounds = true
        btnconfirmgame.layer.cornerRadius = 22
        
        self.Gamesettings()
        txtamount.delegate = self
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
              numberToolbar.barStyle = .default
              numberToolbar.items = [
              UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
              UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
              UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
              numberToolbar.sizeToFit()
              txtamount.inputAccessoryView = numberToolbar
        // Do any additional setup after loading the view.
    }
    @objc func cancelNumberPad() {
           //Cancel with number pad
           txtamount.resignFirstResponder()
       }
       @objc func doneWithNumberPad() {
           //Done with number pad
           txtamount.resignFirstResponder()

       }
     //MARK:   ApiCall ///////////////////////
   func Gamesettings()
    {
        if NetworkState.isConnected()
        {
             hud = MBProgressHUD.showAdded(to: self.view, animated: true)

        hud.labelText = ""
        
        let str2 =  UserDefaults.standard.object(forKey: "registerid")
        let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

               // let string = btndateofmatich.currentTitle
            //String(UserDefaults.standard.integer(forKey: "registerid"))
        
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
                           self.btnalperton.setTitle(partname, for: .normal)
                         }
                       if let partname = dataarray.value(forKey: "reserves") as? Int
                        {
                           let str2 = String(partname)
                          self.btnreviseplayers.setTitle(str2, for: .normal)
                         }
                      if let partname = dataarray.value(forKey: "gameTime") as? String
                      {
                        self.btntime.setTitle(partname, for: .normal)
                       self.txtdate.text = partname
                       }
                       if let partname = dataarray.value(forKey: "LocationAddress") as? String
                         {
                           self.lbladdresstex.text = " "+partname
                          }
                     if let partname = dataarray.value(forKey: "buttontext") as? String
                       {
                        
                        self.btnconfirmgame.setTitle(partname, for: .normal)
                        }
                       if let partname = dataarray.value(forKey: "cost") as? Int
                        {
                       let str2 = String(partname)
                       let combined1 = " £" + str2
                           self.txtamount.text  = combined1
                          // self.btnprize.setTitle(combined1, for: .normal)
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
    
    func Gamesettingsupdate()
    {
       
        if NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

              hud.labelText = ""
              let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

              let str2 =  UserDefaults.standard.object(forKey: "registerid")
              let reviseplay = Int(btnreviseplayers.currentTitle!)
            let myFloat = (txtamount.text! as NSString).floatValue
                     // let string = btndateofmatich.currentTitle
                  //String(UserDefaults.standard.integer(forKey: "registerid"))
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd/MM/yyyy"
            let showDate = inputFormatter.date(from: btndate.currentTitle!)
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let resultString = inputFormatter.string(from: showDate!)
            print(resultString)
            // print("the date is \(mydate)")
            let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"updateGameSettings","input1":imfrom,"input2":str2 as Any ,"input3":btnallowplay,"input4":stringvalue1,"input5":resultString,"input6":btngametype.currentTitle!,"input7": reviseplay!,"input8":btnalperton.currentTitle!,"input9":myFloat] as [String : Any]
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
       {
           
           return textField .resignFirstResponder()
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
