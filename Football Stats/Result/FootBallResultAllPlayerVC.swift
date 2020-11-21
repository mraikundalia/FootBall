//
//  FootBallResultAllPlayerVC.swift
//  Football Stats
//
//  Created by Chakri on 29/10/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown

class FootBallResultAllPlayerVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource ,NIDropDownDelegate {
    func niDropDownDelegateMethod(_ sender: NIDropDown!) {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
        if btndropdown.tag == 0
        {
            btnteam.setTitle(title, for: .normal)
        }
        else if btndropdown.tag == 1
        {
            btnscore0.setTitle(title, for: .normal)
        }
        else if btndropdown.tag == 2
       {
           btnscore1.setTitle(title, for: .normal)
       }
    }
    
    func niDropDownHidden(_ sender: NIDropDown!) {
         btndropdown.isHidden = true
    }
    
    var hud : MBProgressHUD!
      var btndropdown = NIDropDown ()
    
    
    @IBAction func btnscore0Action(_ sender: Any) {
        if btndropdown.isDescendant(of: self.view) {
                            //myView is subview of self.view, remove it.
                           btndropdown.removeFromSuperview()
                        }
                        else
                        {
            let myFloatForR = 250
           
             var r = CGFloat(myFloatForR)
            // lazy var value: Float = 200
             btndropdown.isHidden = false
             btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (goalsArray.value(forKey:"goalsScored") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
             btndropdown.setDropDownSelectionColor(UIColor.gray)
             btndropdown.delegate = self
                btndropdown.tag = 1
           }
    }
    @IBAction func btnscore1Action(_ sender: Any) {
        if btndropdown.isDescendant(of: self.view) {
                            //myView is subview of self.view, remove it.
                           btndropdown.removeFromSuperview()
                        }
                        else
                        {
            let myFloatForR = 250
           
             var r = CGFloat(myFloatForR)
            // lazy var value: Float = 200
             btndropdown.isHidden = false
             btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (goalsArray.value(forKey:"goalsScored") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
             btndropdown.setDropDownSelectionColor(UIColor.gray)
             btndropdown.delegate = self
                btndropdown.tag = 2
           }
    }
    @IBAction func btnteamAction(_ sender: Any) {
        if btndropdown.isDescendant(of: self.view) {
                            //myView is subview of self.view, remove it.
                           btndropdown.removeFromSuperview()
                        }
                        else
                        {
            let myFloatForR = 250
           
             var r = CGFloat(myFloatForR)
            // lazy var value: Float = 200
             btndropdown.isHidden = false
             btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (teamaaray.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
             btndropdown.setDropDownSelectionColor(UIColor.gray)
             btndropdown.delegate = self
                btndropdown.tag = 0
           }
    }
    
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.GetMatchresultupdate()
        //self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var lblsubheadertitle: UILabel!
    @IBOutlet var lblheadertitle: UILabel!
    @IBOutlet var resultcollectionview: UICollectionView!
    var databasearray =  NSMutableArray()
    var defaultdatabase = NSMutableArray()
    var skippedArray = NSMutableArray()
    var goalsArray = NSMutableArray()
     var teamaaray = NSMutableArray()


    @IBOutlet var txtNotes: UITextView!
    @IBOutlet var btnscore0: UIButton!
    @IBOutlet var btnscore1: UIButton!
    @IBOutlet var btnteam: UIButton!
    var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese" ,"Chirsty","Pickle","Jack Cheese"]
    var databasename  = ""
      var playerid = ""
    var storedTeams_id = ""
 var gameid = ""
    
    class NetworkState {
        class func isConnected() ->Bool {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
                 flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-110, height:175)
                  flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right:0)
                  flowLayout.scrollDirection = .horizontal
                  flowLayout.minimumInteritemSpacing = 0.0
                  resultcollectionview.collectionViewLayout = flowLayout
              // Do any additional setup after loading the view.
              
             let bgImage = UIImageView();
              bgImage.image = UIImage(named: "pitchview1");
              bgImage.contentMode = .scaleToFill

           self.resultcollectionview?.backgroundView = bgImage
          self.GetMatchResult()
        btnteam.clipsToBounds = true
        btnteam.layer.cornerRadius = 2;
        btnteam.layer.borderColor = UIColor.black.cgColor
        btnteam.layer.borderWidth = 1;
        
        btnscore0.clipsToBounds = true
        btnscore0.layer.cornerRadius = 2;
        btnscore0.layer.borderColor = UIColor.black.cgColor
        btnscore0.layer.borderWidth = 1;
        
        btnscore1.clipsToBounds = true
        btnscore1.layer.cornerRadius = 2;
        btnscore1.layer.borderColor = UIColor.black.cgColor
        btnscore1.layer.borderWidth = 1;
        
        
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
            return skippedArray.count
        }
                     
                 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
                 {
                     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FootBallCollectionCel", for: indexPath as IndexPath) as! FootBallCollectionCel
                  if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                  {
                      layout.scrollDirection = .vertical
                  }
                  cell.mainimage.layer.cornerRadius = 8
                  cell.mainimage.clipsToBounds = true
                DispatchQueue.main.async{
//                cell.lblname.text = self.menu[indexPath.row]
//                cell.mainimage.image =  UIImage.init(named: "redshirt")
                  let array = self.skippedArray[indexPath.row]

                  let x : Int = (array as AnyObject).value(forKey: "visible") as! Int
                   //(array  as AnyObject).value(forKey: "ICanPlay_id") as? String
                  
                      let myString = String(x)
                  
                      cell.lblname.text = myString
                         
                  //(array as AnyObject).value(forKey: "ICanPlay_id") as? String
                      if x == 0
                      {
                         cell.contentView.isHidden = true
                          cell.layer.borderColor = UIColor.white.cgColor
                      }
                      else
                      {
                         cell.contentView.isHidden = false
                        cell.layer.borderColor = UIColor.black.cgColor //Set Default color here
                      cell.lblname.text = (array  as AnyObject).value(forKey: "name") as? String

                          cell.mainimage.sd_setImage(with: URL(string: ((array  as AnyObject).value(forKey: "shirtColour") as? String)!), placeholderImage: UIImage(named: "load"))

                        if let partname = (array as AnyObject).value(forKey: "CrownVisible") as? Int
                        {
                             let myString = String(partname)
                            if myString == "1"
                            {
                                cell.crownright.constant = 20
                            }
                            else
                            {
                                cell.crownright.constant = 0
                            }
                      
                         }
                

                 
                  }
                    }
                   
            //                if dataSource[indexPath.row] == "@" {
            //
            //
            //                }
            //                else {
            //
            //                }
            //
              return cell
                 }
              
           func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
           {
         
            let login: FootBallResultPlayerVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallResultPlayerVC") as! FootBallResultPlayerVC)
              let array = self.skippedArray[indexPath.row]
            if let partname = (array as AnyObject).value(forKey: "name") as? String
               {
                login!.playername = partname
                }
            login!.gameid = gameid
            self.navigationController?.pushViewController(login!, animated: true)
              
              }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = ((resultcollectionview.frame.width - 15) / 2) // 15 because of paddings
            print("cell width : \(width)")
            return CGSize(width: 130, height: 175)
        }
    
    //MARK: APi Call////////
    
     func GetMatchResult()
            {
              //SVProgressHUD.show()
    //            var string = String.self
    //            string = UserDefaults.standard.integer(forKey: "registerid")
              
                  hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                  hud.labelText = ""
             
               let strInt = Int(storedTeams_id)
                  let teamid = Int(playerid)
                let str2 =  UserDefaults.standard.object(forKey: "registerid")
                       // let string = btndateofmatich.currentTitle
                    //String(UserDefaults.standard.integer(forKey: "registerid"))
               let verify_param = ["storedProcedureName":"getMatchResult","input1":str2 as Any ,"input2":databasename,"input3":teamid as Any,
                "input4":strInt as Any] as [String : Any]
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
                      self.databasearray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                  // self.storedversion = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                   if self.databasearray.count == 0
                   {
                       self.showToast(message: "No Data", font: UIFont.systemFont(ofSize: 12))
                   }
                   else
                   {
                       let result = self.databasearray[0] as? NSDictionary
                                        // var stringvalue1 = ""
                   
                      if let partname = result!.value(forKey: "game_date") as? String
                           {
                              //let str2 = String(partname)
                           //self.storedTeams_id = str2
                            self.lblheadertitle.text = partname
                            }
                      if let partname = result!.value(forKey: "LocationName") as? String
                      {
                        self.lblsubheadertitle.text = partname
                        // let str2 = String(partname)
                     // self.icanplayid = str2
                       }
                    if let partname = result!.value(forKey: "game_ID") as? Int
                    {
                     
                      let str2 = String(partname)
                    self.gameid = str2
                     }
                   }
                       
                      //et dataarray = skippedArray1.firstObject as! NSDictionary

                     // self.databasearray = (jsonResponse["Data2"] as? NSArray)! as! NSMutableArray
                     
                     //self.storedTeams_id =  NSString(format: "%@",(result!.value(forKey: "storedTeams_id") as! CVarArg)) as String
                     // print(self.storedTeams_id)
                      
                  self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                   self.goalsArray = (jsonResponse["Data5"]! as! NSArray).mutableCopy() as! NSMutableArray
                    self.teamaaray = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
                   self.resultcollectionview.reloadData()
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
    func GetMatchresultupdate()
               {
      
                 
                     hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                     hud.labelText = ""
                
                     let gameid1 = Int(gameid)
                   let str2 =  UserDefaults.standard.object(forKey: "registerid")
                          // let string = btndateofmatich.currentTitle
                       //String(UserDefaults.standard.integer(forKey: "registerid"))
                let verify_param = ["storedProcedureName":"updateMatchResult","input1":str2 as Any ,"input2":gameid1 as Any,"input3":btnteam.currentTitle!,
                                    "input4":btnscore0.currentTitle!,  "input5":btnscore1.currentTitle!, "input6":txtNotes.text!] as [String : Any]
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
                         
                         self.databasearray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                     let result = self.databasearray[0] as? NSDictionary

                        if let partname = result!.value(forKey: "Confirmation") as? String
                        {
                            self.showToast(message: partname, font: UIFont.systemFont(ofSize: 13))
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
                      self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                             }
                         }
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
