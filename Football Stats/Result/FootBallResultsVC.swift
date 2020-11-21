//
//  FootBallResultsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
import Reachability
class FootBallResultsVC: UIViewController , UITableViewDelegate, UITableViewDataSource, NIDropDownDelegate{
    class NetworkState
    {
        class func isConnected() ->Bool
        {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    func niDropDownDelegateMethod(_ sender: NIDropDown!) {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!) {
        
    }
    
    func niDropDownHidden(_ sender: NIDropDown!) {
        
    }
    
    
    @IBOutlet var resulttable: UITableView!
    @IBOutlet var btntuesday: UIButton!
    
    var databasearray =  NSMutableArray()
    var skippedArray = NSMutableArray()
    @IBAction func btntuesAction(_ sender: Any) {
        if btndropdown.isDescendant(of: self.view)
        {
           //myView is subview of self.view, remove it.
          btndropdown.removeFromSuperview()
       }
       else
       {
       // tuesdayheightcon.constant = 250
           let myFloatForR = 250
          
            var r = CGFloat(myFloatForR)
           // lazy var value: Float = 200
            btndropdown.isHidden = false
           // btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (defaultdatabase.value(forKey: "database_name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
            btndropdown.setDropDownSelectionColor(UIColor.gray)
            btndropdown.delegate = self
               btndropdown.tag = 2
          }
    }
    var hud : MBProgressHUD!
    var btndropdown = NIDropDown ()
    var hotelName =  ""
    var stored = ""
    //MARK: //ViewDidLoad ////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults : UserDefaults = UserDefaults.standard
            hotelName = (defaults.value(forKey: "database_name") as! String?)!
        if(hotelName != "")
        {
            btntuesday .setTitle(hotelName, for: .normal)
            self.GetResultCall()
            
        }
        btntuesday.clipsToBounds = true
        btntuesday.layer.cornerRadius = 8
        btntuesday.layer.borderColor = UIColor.black.cgColor
        btntuesday.layer.borderWidth = 1
       

        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
      
    }
    //MARK: TableviewDelegate methods/////////////
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            {
                return self.skippedArray.count
                
            }
            
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
                      {
                          let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableCell", for: indexPath as IndexPath) as! ResultTableCell
                        
                          DispatchQueue.main.async
                            {
                           let array = self.skippedArray[indexPath.row]
                           // let x : Int = (array as AnyObject).value(forKey: "Column1") as! Int
                               // (array  as AnyObject).value(forKey: "ICanPlay_id") as? String
                            //let myString = String(x)
                           // cell.lbldate.text = myString
                        cell.lbldate.text = (array  as AnyObject).value(forKey: "game_date") as? String
                      cell.footballside.text = (array  as AnyObject).value(forKey: "GameTypes") as? String
                      cell.totalgoals.text = (array  as AnyObject).value(forKey: "LocationName") as? String
                      cell.pitchtbc.text = (array  as AnyObject).value(forKey: "winningTeam") as? String

//                            cell.serialnum.clipsToBounds = true
//                            cell.serialnum.layer.cornerRadius =   cell.serialnum.frame.size.width/2
//                            cell.serialnum.layer.borderWidth = 1
//                            cell.serialnum.layer.borderColor = UIColor.darkGray.cgColor
//                        cell.profilename.text = (array  as AnyObject).value(forKey: "name") as? String
                            cell.borderview.clipsToBounds = true
                            cell.borderview.layer.cornerRadius = 10
                            cell.borderview.layer.borderWidth = 1;
                            cell.borderview.layer.borderColor =  UIColor.lightGray.cgColor

//                                //UIColor.init(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 0).cgColor
//                            cell.profileimage.clipsToBounds = true
//                            cell.profileimage.layer.cornerRadius = cell.profileimage.frame.size.width/2
                            //(array as AnyObject).value(forKey: "ICanPlay_id") as? String
                        DispatchQueue.main.async{
                            if let partname = (array as AnyObject).value(forKey: "playerPicture") as? String
                          {
                              if partname.count>0
                              {
                                  let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                             let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                             print(decodedimage)
                            //cell.profileimage.image = decodedimage
                                
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
                      return 80.0;//Choose your custom row height
                  }
            
              func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
                      {
            //           if indexPath.row == 0
                      // {
                        //self.showSimpleAlert()
                let array = self.skippedArray[indexPath.row]
                let x : Int = (array as AnyObject).value(forKey: "game_ID") as! Int
                let str2 = String(x)
                if let partname = (array as AnyObject).value(forKey: "storedTeams_id") as? Int
                {
                    stored = String(partname)
                }
               // let x1 : Int = (array as AnyObject).value(forKey: "storedTeams_id") as! Int
          
      let login: FootBallResultAllPlayerVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallResultAllPlayerVC") as! FootBallResultAllPlayerVC)
         login!.playerid = str2
        login!.storedTeams_id = stored
       login!.databasename = btntuesday.currentTitle!
    self.navigationController?.pushViewController(login!, animated: true)
                        
                        
                       }
  //MARK: API CALL////////////////////
      func GetResultCall()
                   {
             if NetworkState.isConnected()
               {
                      print("Internet is available.")
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)

         hud.labelText = ""
         
        let str2 =  UserDefaults.standard.object(forKey: "registerid")
                  // let string = btndateofmatich.currentTitle
               //String(UserDefaults.standard.integer(forKey: "registerid"))
        let verify_param = ["storedProcedureName":"getAllMatches","input1":str2 as Any ,"input2":btntuesday.currentTitle!] as [String : Any]
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
                 
                 self.databasearray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                
                 
             self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                 DispatchQueue.main.async{
                    self.resulttable.reloadData()
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
                      // ...
               }
                  else
             {
                self.showToast(message: "Internet Not Available", font: UIFont.systemFont(ofSize: 14))
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
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
      case .cellular:
          print("Reachable via Cellular")
      case .none:
        print("Network not reachable")
      case .unavailable: break
        
        }
    }
}
