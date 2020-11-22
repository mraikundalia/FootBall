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
import Reachability

class FootBallPlayVC: UIViewController , UITableViewDelegate, UITableViewDataSource , NIDropDownDelegate{
    class NetworkState
      {
          class func isConnected() ->Bool
          {
              return NetworkReachabilityManager()!.isReachable
          }
      }
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
    var playername =  ""
     var gamesarray = [String]()
    @IBAction func btntuesdayAction(_ sender: Any) {
        
        if btndropdown.isDescendant(of: self.view) {
                                //myView is subview of self.view, remove it.
                               btndropdown.removeFromSuperview()
             tuesdayheightcon.constant = 130
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
        btntuesday.layer.cornerRadius = 8
       //btnxspace.layer.borderColor = UIColor.black.cgColor
      // btnxspace.layer.borderWidth = 1
    btncheckbox.clipsToBounds = true
    btncheckbox.layer.borderColor = UIColor.darkGray.cgColor
    btncheckbox.layer.borderWidth = 1
        hudshow =  "No"
        playertable.isEditing = true
        
        self.GetDatabaseNames()
//        let defaults : UserDefaults = UserDefaults.standard
//             hotelName = (defaults.value(forKey: "database_name") as! String?)!
//         if(hotelName != "")
//         {
//             btntuesday .setTitle(hotelName, for: .normal)
//             self.PlayCall()
//          }
        playertable.allowsSelection = true
    }
    var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
       //      var recents = ["THE GOBBLER", "THE VENETIAN"]
       //      var favorites = ["FRIES", "THE VENETIAN"]
       //    var Features = ["FRESH CUT FRIES", "STIR FRY QUINOA"]
var menuimages = ["download", "download", "download" ,"download","download","download" ]
    override func viewDidAppear(_ animated: Bool)
    {
       let defaults : UserDefaults = UserDefaults.standard
                   hotelName = (defaults.value(forKey: "database_name") as! String?)!
               if(hotelName != "")
               {
                   btntuesday .setTitle(hotelName, for: .normal)
                   self.PlayCall()
                }
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return self.skippedArray.count
            
        }
        
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
                  {
                    if indexPath.row == 0
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "FootBallPlayerTableCell", for: indexPath as IndexPath) as! FootBallPlayerTableCell
                        return cell
                    }
                    else
                    {
                          let cell = tableView.dequeueReusableCell(withIdentifier: "FootBallPlayerTableCell", for: indexPath as IndexPath) as! FootBallPlayerTableCell
                                            
                      DispatchQueue.main.async{
                       let array = self.skippedArray[indexPath.row]
                        let x : Int = (array as AnyObject).value(forKey: "PlayerNumber") as! Int
                           // (array  as AnyObject).value(forKey: "ICanPlay_id") as? String
                        let myString = String(x)
                        cell.serialnum.text = myString
                        cell.serialnum.clipsToBounds = true
                        let string  = (array  as AnyObject).value(forKey: "playedLastGames") as? String
                        if string == "B,B,B,B,B,B,B,B,B,B"
                        {
                            cell.lost1.backgroundColor = UIColor.white;               cell.lost1.clipsToBounds = true
//                               cell.lost1.layer.cornerRadius = 2
//                               cell.lost1.layer.borderColor = UIColor.black.cgColor
//                               cell.lost1.layer.borderWidth = 1
                            
                            cell.lost2.backgroundColor = UIColor.white;               //cell.lost2.clipsToBounds = true
//                               cell.lost2.layer.cornerRadius = 2
//                               cell.lost2.layer.borderColor = UIColor.black.cgColor
//                               cell.lost2.layer.borderWidth = 1
                            
                          cell.lost3.backgroundColor = UIColor.white;               //cell.lost3.clipsToBounds = true
//                               cell.lost3.layer.cornerRadius = 2
//                               cell.lost3.layer.borderColor = UIColor.black.cgColor
//                               cell.lost3.layer.borderWidth = 1
                            
                            cell.lost4.backgroundColor = UIColor.white;               //cell.lost4.clipsToBounds = true
                               //cell.lost4.layer.cornerRadius = 2
                               //cell.lost4.layer.borderColor = UIColor.black.cgColor
                               //cell.lost4.layer.borderWidth = 1
                            
                            cell.lost5.backgroundColor = UIColor.white;               //cell.lost5.clipsToBounds = true
                               //cell.lost5.layer.cornerRadius = 2
                               //cell.lost5.layer.borderColor = UIColor.black.cgColor
                              // cell.lost5.layer.borderWidth = 1
                            
                            cell.lost6.backgroundColor = UIColor.white;               //cell.lost6.clipsToBounds = true
                               cell.lost6.layer.cornerRadius = 2
                               cell.lost6.layer.borderColor = UIColor.black.cgColor
                              // cell.lost6.layer.borderWidth = 1
                            
                            cell.lost7.backgroundColor = UIColor.white;               cell.lost7.clipsToBounds = true
                               cell.lost7.layer.cornerRadius = 2
                              // cell.lost7.layer.borderColor = UIColor.black.cgColor
                               //cell.lost7.layer.borderWidth = 1
                            
                            cell.lost8.backgroundColor = UIColor.white;               cell.lost8.clipsToBounds = true
                               cell.lost8.layer.cornerRadius = 2
                               //cell.lost8.layer.borderColor = UIColor.black.cgColor
                               //cell.lost8.layer.borderWidth = 1
                            
                            cell.lost9.backgroundColor = UIColor.white;               cell.lost9.clipsToBounds = true
                               cell.lost9.layer.cornerRadius = 2
                               //cell.lost9.layer.borderColor = UIColor.black.cgColor//cell.lost9.layer.borderWidth = 1
                            
                            cell.lost10.backgroundColor = UIColor.white;               cell.lost10.clipsToBounds = true
                               cell.lost10.layer.cornerRadius = 2
                               //cell.lost10.layer.borderColor = UIColor.black.cgColor
                               //cell.lost10.layer.borderWidth = 1
                            
                            

                        }
                        else
                        {
                             self.gamesarray = string!.components(separatedBy: ",")
                    for i in 0 ..< self.self.gamesarray.count
                    {
                         let test = self.gamesarray[i]
                        let string = String(i)
                         if test != ""
                         {
                            if string == "0" && test == "W"
                            {
                                cell.lost1.backgroundColor = UIColor.green
                                cell.lost1.clipsToBounds = true
                           cell.lost1.layer.cornerRadius = 2
                           cell.lost1.layer.borderColor = UIColor.black.cgColor
                           cell.lost1.layer.borderWidth = 1
                            }
                            else if  string == "0" && test == "L"
                            {
                                cell.lost1.backgroundColor = UIColor.red
                                cell.lost1.clipsToBounds = true
                               cell.lost1.layer.cornerRadius = 2
                               cell.lost1.layer.borderColor = UIColor.black.cgColor
                               cell.lost1.layer.borderWidth = 1
                            }
                            else if  string == "0" && test == "B"
                            {
                                cell.lost1.backgroundColor = UIColor.white
                                cell.lost1.clipsToBounds = true
                              cell.lost1.layer.cornerRadius = 2
                              cell.lost1.layer.borderColor = UIColor.black.cgColor
                              cell.lost1.layer.borderWidth = 1
                            }
                            else if string == "1" && test == "W"
                            {
                                cell.lost2.backgroundColor = UIColor.green
                                cell.lost2.clipsToBounds = true
                            cell.lost2.layer.cornerRadius = 2
                            cell.lost2.layer.borderColor = UIColor.black.cgColor
                            cell.lost2.layer.borderWidth = 1
                            }
                            else if  string == "1" && test == "L"
                            {
                                cell.lost2.backgroundColor = UIColor.red
                                cell.lost2.clipsToBounds = true
                                cell.lost2.layer.cornerRadius = 2
                                cell.lost2.layer.borderColor = UIColor.black.cgColor
                                cell.lost2.layer.borderWidth = 1
                            }
                            else if  string == "1" && test == "B"
                            {
                                cell.lost2.backgroundColor = UIColor.white
                                cell.lost2.clipsToBounds = true
                                cell.lost2.layer.cornerRadius = 2
                                cell.lost2.layer.borderColor = UIColor.black.cgColor
                                cell.lost2.layer.borderWidth = 1
                            }
                            else if string == "2" && test == "W"
                            {
                                cell.lost3.backgroundColor = UIColor.green
                           cell.lost3.clipsToBounds = true
                           cell.lost3.layer.cornerRadius = 2
                           cell.lost3.layer.borderColor = UIColor.black.cgColor
                           cell.lost3.layer.borderWidth = 1
                            }
                            else if  string == "2" && test == "L"
                            {
                        cell.lost3.backgroundColor = UIColor.red
                        cell.lost3.clipsToBounds = true
                       cell.lost3.layer.cornerRadius = 2
                       cell.lost3.layer.borderColor = UIColor.black.cgColor
                       cell.lost3.layer.borderWidth = 1
                            }
                            else if  string == "2" && test == "B"
                            {
                                cell.lost3.backgroundColor = UIColor.white
                                cell.lost3.clipsToBounds = true
                                cell.lost3.layer.cornerRadius = 2
                                cell.lost3.layer.borderColor = UIColor.black.cgColor
                                cell.lost3.layer.borderWidth = 1
                            }
                            else if string == "3" && test == "W"
                            {
                                cell.lost4.backgroundColor = UIColor.green

                                cell.lost4.clipsToBounds = true
                                cell.lost4.layer.cornerRadius = 2
                                cell.lost4.layer.borderColor = UIColor.black.cgColor
                                cell.lost4.layer.borderWidth = 1
                            }
                            else if  string == "3" && test == "L"
                            {
                                cell.lost4.backgroundColor = UIColor.red
                                cell.lost4.clipsToBounds = true
                                cell.lost4.layer.cornerRadius = 2
                                cell.lost4.layer.borderColor = UIColor.black.cgColor
                                cell.lost4.layer.borderWidth = 1
                            }
                            else if  string == "3" && test == "B"
                            {
                                cell.lost4.backgroundColor = UIColor.white
                                cell.lost4.clipsToBounds = true
                                cell.lost4.layer.cornerRadius = 2
                                cell.lost4.layer.borderColor = UIColor.black.cgColor
                                cell.lost4.layer.borderWidth = 1
                            }
                            else if string == "4" && test == "W"
                            {
                                cell.lost5.backgroundColor = UIColor.green
                               cell.lost5.clipsToBounds = true
                               cell.lost5.layer.cornerRadius = 2
                               cell.lost5.layer.borderColor = UIColor.black.cgColor
                               cell.lost5.layer.borderWidth = 1
                            }
                            else if  string == "4" && test == "L"
                            {
                                cell.lost5.backgroundColor = UIColor.red
                                cell.lost5.clipsToBounds = true
                               cell.lost5.layer.cornerRadius = 2
                               cell.lost5.layer.borderColor = UIColor.black.cgColor
                               cell.lost5.layer.borderWidth = 1
                            }
                            else if  string == "4" && test == "B"
                            {
                                cell.lost5.backgroundColor = UIColor.white
                                cell.lost5.clipsToBounds = true
                              cell.lost5.layer.cornerRadius = 2
                              cell.lost5.layer.borderColor = UIColor.black.cgColor
                              cell.lost5.layer.borderWidth = 1
                            }
                           else  if string == "5" && test == "W"
                            {
                                cell.lost6.backgroundColor = UIColor.green
                                cell.lost6.clipsToBounds = true
                                cell.lost6.layer.cornerRadius = 2
                                cell.lost6.layer.borderColor = UIColor.black.cgColor
                                cell.lost6.layer.borderWidth = 1
                                
                            }
                            else if  string == "5" && test == "L"
                            {
                                cell.lost6.backgroundColor = UIColor.red
                                cell.lost6.clipsToBounds = true
                                cell.lost6.layer.cornerRadius = 2
                                cell.lost6.layer.borderColor = UIColor.black.cgColor
                                cell.lost6.layer.borderWidth = 1
                                
                            }
                            else if  string == "5" && test == "B"
                            {
                                cell.lost6.backgroundColor = UIColor.white
                                cell.lost6.clipsToBounds = true
                                cell.lost6.layer.cornerRadius = 2
                                cell.lost6.layer.borderColor = UIColor.black.cgColor
                                cell.lost6.layer.borderWidth = 1
                            }
                           else  if string == "6" && test == "W"
                       {
                           cell.lost7.backgroundColor = UIColor.green
                        cell.lost7.clipsToBounds = true
                cell.lost7.layer.cornerRadius = 2
                cell.lost7.layer.borderColor = UIColor.black.cgColor
                cell.lost7.layer.borderWidth = 1
                                            
                       }
                       else if  string == "6" && test == "L"
                       {
                           cell.lost7.backgroundColor = UIColor.red
                        cell.lost7.clipsToBounds = true
                        cell.lost7.layer.cornerRadius = 2
                        cell.lost7.layer.borderColor = UIColor.black.cgColor
                        cell.lost7.layer.borderWidth = 1
                                            
                       }
                       else if  string == "6" && test == "B"
                       {
                           cell.lost7.backgroundColor = UIColor.white
                        cell.lost7.clipsToBounds = true
                        cell.lost7.layer.cornerRadius = 2
                        cell.lost7.layer.borderColor = UIColor.black.cgColor
                        cell.lost7.layer.borderWidth = 1
                       }
                   else  if string == "7" && test == "W"
                    {
                        cell.lost8.backgroundColor = UIColor.green

                        cell.lost8.clipsToBounds = true
                        cell.lost8.layer.cornerRadius = 2
                        cell.lost8.layer.borderColor = UIColor.black.cgColor
                        cell.lost8.layer.borderWidth = 1
                        
                    }
                    else if  string == "7" && test == "L"
                    {
                        cell.lost8.backgroundColor = UIColor.red

                        cell.lost8.clipsToBounds = true
                        cell.lost8.layer.cornerRadius = 2
                        cell.lost8.layer.borderColor = UIColor.black.cgColor
                        cell.lost8.layer.borderWidth = 1
                        
                    }
                    else if  string == "7" && test == "B"
                    {
                        cell.lost8.backgroundColor = UIColor.white
                        cell.lost8.clipsToBounds = true
                        cell.lost8.layer.cornerRadius = 2
                        cell.lost8.layer.borderColor = UIColor.black.cgColor
                        cell.lost8.layer.borderWidth = 1
                    }
                  else if string == "8" && test == "W"
                   {
                       cell.lost9.backgroundColor = UIColor.green
                    cell.lost9.clipsToBounds = true
                    cell.lost9.layer.cornerRadius = 2
                    cell.lost9.layer.borderColor = UIColor.black.cgColor
                    cell.lost9.layer.borderWidth = 1
                   }
                   else if  string == "8" && test == "L"
                   {
                       cell.lost9.backgroundColor = UIColor.red
                    cell.lost9.clipsToBounds = true
                        cell.lost9.layer.cornerRadius = 2
                        cell.lost9.layer.borderColor = UIColor.black.cgColor
                        cell.lost9.layer.borderWidth = 1
                   }
                   else if  string == "8" && test == "B"
                   {
                       cell.lost9.backgroundColor = UIColor.white
                    cell.lost9.clipsToBounds = true
                       cell.lost9.layer.cornerRadius = 2
                       cell.lost9.layer.borderColor = UIColor.black.cgColor
                       cell.lost9.layer.borderWidth = 1
                    
                   }
                  else if string == "9" && test == "W"
                   {
                       cell.lost10.backgroundColor = UIColor.green
                    cell.lost10.clipsToBounds = true
                    cell.lost10.layer.cornerRadius = 2
                    cell.lost10.layer.borderColor = UIColor.black.cgColor
                    cell.lost10.layer.borderWidth = 1
                   }
                   else if  string == "9" && test == "L"
                   {
                       cell.lost10.backgroundColor = UIColor.red
                    cell.lost10.clipsToBounds = true
                    cell.lost10.layer.cornerRadius = 2
                    cell.lost10.layer.borderColor = UIColor.black.cgColor
                    cell.lost10.layer.borderWidth = 1
                   }
                   else if  string == "9" && test == "B"
                   {
                    cell.lost10.backgroundColor = UIColor.white;               cell.lost10.clipsToBounds = true
                       cell.lost10.layer.cornerRadius = 2
                       cell.lost10.layer.borderColor = UIColor.black.cgColor
                       cell.lost10.layer.borderWidth = 1
                   }
                            
    //                                 for (_, element) in self.leaveListData.enumerated()
    //                                 {
    //                                     if(element.leaveName == "\(test)")
    //                                     {
    //                                         self.leaveListFieldData.append(element)
    //                                     }
    //                                 }
                                 }
                                
                              }
                        }
                       
                            
                   
                        
      
                        
                   
                        

                    
                
                        
                        
                        
//                    if string == "B,L,L,B,B,B,B,B,B,B"
//                    {
//                        cell.lost1.backgroundColor = UIColor.white
//                         cell.lost2.backgroundColor = UIColor.red
//                         cell.lost3.backgroundColor = UIColor.red
//                         cell.lost4.backgroundColor = UIColor.white
//                        cell.lost5.backgroundColor = UIColor.white
//                         cell.lost6.backgroundColor = UIColor.white
//                         cell.lost7.backgroundColor = UIColor.white
//                         cell.lost9.backgroundColor = UIColor.white
//                        cell.lost10.backgroundColor = UIColor.white
//                        cell.lost8.backgroundColor = UIColor.white
//
//                    }
//                   else if string == "W,W,W,B,B,B,B,B,B,B"
//                    {
//                        cell.lost1.backgroundColor = UIColor.green
//                         cell.lost2.backgroundColor = UIColor.green
//                         cell.lost3.backgroundColor = UIColor.green
//                         cell.lost4.backgroundColor = UIColor.white
//                        cell.lost5.backgroundColor = UIColor.white
//                         cell.lost6.backgroundColor = UIColor.white
//                         cell.lost7.backgroundColor = UIColor.white
//                         cell.lost9.backgroundColor = UIColor.white
//                        cell.lost10.backgroundColor = UIColor.white
//                        cell.lost8.backgroundColor = UIColor.white
//
//                    }
//                   else if string == "B,L,B,L,B,B,B,B,B,B"
//                    {
//                        cell.lost1.backgroundColor = UIColor.white
//                         cell.lost2.backgroundColor = UIColor.red
//                         cell.lost3.backgroundColor = UIColor.white
//                         cell.lost4.backgroundColor = UIColor.red
//                        cell.lost5.backgroundColor = UIColor.white
//                         cell.lost6.backgroundColor = UIColor.white
//                         cell.lost7.backgroundColor = UIColor.white
//                         cell.lost9.backgroundColor = UIColor.white
//                        cell.lost10.backgroundColor = UIColor.white
//                        cell.lost8.backgroundColor = UIColor.white
//
//                    }
//                   else if string == "B,L,L,B,B,B,B,B,B,B"
//                    {
//                        cell.lost1.backgroundColor = UIColor.white
//                         cell.lost2.backgroundColor = UIColor.red
//                         cell.lost3.backgroundColor = UIColor.red
//                         cell.lost4.backgroundColor = UIColor.white
//                        cell.lost5.backgroundColor = UIColor.white
//                         cell.lost6.backgroundColor = UIColor.white
//                         cell.lost7.backgroundColor = UIColor.white
//                         cell.lost9.backgroundColor = UIColor.white
//                        cell.lost10.backgroundColor = UIColor.white
//                        cell.lost8.backgroundColor = UIColor.white
//
//                    }
//                   else  if string == "B,B,B,W,B,B,B,B,B,B"
//                    {
//                        cell.lost1.backgroundColor = UIColor.white
//                         cell.lost2.backgroundColor = UIColor.white
//                         cell.lost3.backgroundColor = UIColor.white
//                         cell.lost4.backgroundColor = UIColor.green
//                        cell.lost5.backgroundColor = UIColor.white
//                         cell.lost6.backgroundColor = UIColor.white
//                         cell.lost7.backgroundColor = UIColor.white
//                         cell.lost9.backgroundColor = UIColor.white
//                        cell.lost10.backgroundColor = UIColor.white
//                        cell.lost8.backgroundColor = UIColor.white
//
//                    }
//                    else if string == "L,L,B,L,B,B,B,B,B,B"
//                    {
//                      cell.lost1.backgroundColor = UIColor.red
//                         cell.lost2.backgroundColor = UIColor.red
//                         cell.lost3.backgroundColor = UIColor.white
//                         cell.lost4.backgroundColor = UIColor.red
//                        cell.lost5.backgroundColor = UIColor.white
//                         cell.lost6.backgroundColor = UIColor.white
//                         cell.lost7.backgroundColor = UIColor.white
//                         cell.lost9.backgroundColor = UIColor.white
//                        cell.lost10.backgroundColor = UIColor.white
//                        cell.lost8.backgroundColor = UIColor.white
//
//                    }
//                  else   if string == "W,L,L,L,B,B,B,B,B,B"
//                    {
//                        cell.lost1.backgroundColor = UIColor.green
//                         cell.lost2.backgroundColor = UIColor.red
//                         cell.lost3.backgroundColor = UIColor.red
//                         cell.lost4.backgroundColor = UIColor.red
//                        cell.lost5.backgroundColor = UIColor.white
//                         cell.lost6.backgroundColor = UIColor.white
//                         cell.lost7.backgroundColor = UIColor.white
//                         cell.lost9.backgroundColor = UIColor.white
//                        cell.lost10.backgroundColor = UIColor.white
//                        cell.lost8.backgroundColor = UIColor.white
//
//                    }
//                   else  if string == "W,B,W,W,B,B,B,B,B,B"
//                   {
//                       cell.lost1.backgroundColor = UIColor.green
//                        cell.lost2.backgroundColor = UIColor.white
//                        cell.lost3.backgroundColor = UIColor.green
//                        cell.lost4.backgroundColor = UIColor.green
//                       cell.lost5.backgroundColor = UIColor.white
//                        cell.lost6.backgroundColor = UIColor.white
//                        cell.lost7.backgroundColor = UIColor.white
//                        cell.lost9.backgroundColor = UIColor.white
//                       cell.lost10.backgroundColor = UIColor.white
//                    cell.lost8.backgroundColor = UIColor.white
//
//                   }
//                   else  if string == "L,W,L,L,B,B,B,B,B,B"
//                      {
//                          cell.lost1.backgroundColor = UIColor.red
//                           cell.lost2.backgroundColor = UIColor.red
//                           cell.lost3.backgroundColor = UIColor.red
//                           cell.lost4.backgroundColor = UIColor.red
//                          cell.lost5.backgroundColor = UIColor.white
//                           cell.lost6.backgroundColor = UIColor.white
//                           cell.lost7.backgroundColor = UIColor.white
//                           cell.lost9.backgroundColor = UIColor.white
//                          cell.lost10.backgroundColor = UIColor.white
//                        cell.lost8.backgroundColor = UIColor.white
//
//                      }
//               else if string == "L,L,W,W,B,B,B,B,B,B"
//             {
//                 cell.lost1.backgroundColor = UIColor.red
//                  cell.lost2.backgroundColor = UIColor.red
//                  cell.lost3.backgroundColor = UIColor.red
//                  cell.lost4.backgroundColor = UIColor.red
//                 cell.lost5.backgroundColor = UIColor.white
//                  cell.lost6.backgroundColor = UIColor.white
//                  cell.lost7.backgroundColor = UIColor.white
//                  cell.lost9.backgroundColor = UIColor.white
//                 cell.lost10.backgroundColor = UIColor.white
//                cell.lost8.backgroundColor = UIColor.white
//
//             }
//                else
//                            {
//                                cell.lost1.backgroundColor = UIColor.white
//                                 cell.lost2.backgroundColor = UIColor.white
//                                 cell.lost3.backgroundColor = UIColor.white
//                                 cell.lost4.backgroundColor = UIColor.white
//                                cell.lost5.backgroundColor = UIColor.white
//                                 cell.lost6.backgroundColor = UIColor.white
//                                 cell.lost7.backgroundColor = UIColor.white
//                                  cell.lost8.backgroundColor = UIColor.white
//                                 cell.lost9.backgroundColor = UIColor.white
//                                cell.lost10.backgroundColor = UIColor.white
//                            }
//
                        let tapped:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapedited(_:)))
                        tapped.numberOfTapsRequired = 2
                        
                        cell.borderview.tag = indexPath.row
                        
                       cell.borderview.addGestureRecognizer(tapped)
                        
                      // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapEdit(_:)))
                        //tapGesture!.delegate = self

                       // cell.borderview.addGestureRecognizer(tapGesture!)
                         
                                               // cell.serialnum.layer.cornerRadius =   cell.serialnum.frame.size.width/2
                                                //cell.serialnum.layer.borderWidth = 1
                                                //cell.serialnum.layer.borderColor = UIColor.darkGray.cgColor
                                            cell.profilename.text = (array  as AnyObject).value(forKey: "name") as? String
                                                cell.borderview.clipsToBounds = true
                                                cell.borderview.layer.cornerRadius = 22
                                                cell.borderview.layer.borderWidth = 1;
                                                cell.borderview.layer.borderColor =  UIColor.lightGray.cgColor
                                               // cell.borderview.addShadow(to :[.top,.left,.right,.bottom], radius: 2, opacity: 2, color: UIColor.lightGray.cgColor)
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
                    
           }
    
              func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if indexPath.row == 0
                {
                    return 0
                }
                else
                
                {
                      return 55.0
                }
                //Choose your custom row height
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
    //MARK: gestureRecognizer /////////////////////////////
    @objc func tapedited (_ sender: UITapGestureRecognizer)
    {
        print("indexPathRow == \(sender.view?.tag ?? 0)")

        let tag = sender.view!.tag
        let array = self.skippedArray[tag]
           //let x : Int = (array as AnyObject).value(forKey: "name") as! Int
              // (array  as AnyObject).value(forKey: "ICanPlay_id") as? String
        myString = String(x)
        playername = ((array  as AnyObject).value(forKey: "name") as? String)!
        self.showSimpleAlert()
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
                     alert.addAction(UIAlertAction(title: "Remove",
                                                   style: UIAlertAction.Style.default,
                                                   handler: {(_: UIAlertAction!) in
                                                     //Sign out action
                                                    self.untickicanPlayCall()
                    blurVisualEffectView.removeFromSuperview()
                     }))
                alert.view.tintColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 141.0/255.0, alpha: 1)
                 self.view.addSubview(blurVisualEffectView)
                     self.present(alert, animated: true, completion: nil)
                 }
    
   
    func niDropDownDelegateMethod(_ sender: NIDropDown!) {
           
       }
       
       func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
       {
           tuesdayheightcon.constant = 130
               btntuesday.setTitle(title, for:.normal)
       // self.skippedArray.removeAllObjects()
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

            if NetworkState.isConnected()
            {
                let str2 =  UserDefaults.standard.object(forKey: "registerid")
                             let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                                let verify_param = ["sessionID" :sessionid as Any,"storedProcedureName":"getDatabaseNames","input1":str2 as Any] as [String : Any]
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
                                        
                                        var skippedArray = NSMutableArray()
                                        skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                        
                                        //let dataarray = skippedArray.firstObject as! NSDictionary
                                       
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
               else
        {
            self.showAlert(message: GlobalConstants.internetmessage)
        }
                  
                  }
        func PlayCall()
                  {
        if NetworkState.isConnected()
        {
            if hudshow ==  "No"
        {
          
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

        hud.labelText = ""
        }
        else if hudshow ==  "YES"
        {
            
        }
        
          let str2 =  UserDefaults.standard.object(forKey: "registerid")
        let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

                 // let string = btndateofmatich.currentTitle
              //String(UserDefaults.standard.integer(forKey: "registerid"))
       let verify_param = ["sessionID" :sessionid as Any,"storedProcedureName":"getPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!] as [String : Any]
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
                if partname == "0 spaces available"
                {
                    //self.btnaddPlayer.isUserInteractionEnabled = false
                   // self.btncheckbox.isUserInteractionEnabled = false
                }
                else
                {
                    self.btnaddPlayer.isUserInteractionEnabled = true
                    self.btncheckbox.isUserInteractionEnabled = true
                }
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
    
    func tickicanPlayCall()
        {
    
        if NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.labelText = ""
            let str2 =  UserDefaults.standard.object(forKey: "registerid")
            let myInt1 = Int(myString)
            let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

            //let playid = Int(stringvalue1)
         let verify_param = ["sessionID" :sessionid as Any,"storedProcedureName":"iCanPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!,"input3":"","input4":myInt1 as Any] as [String : Any]
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
    func untickicanPlayCall()
            {
                  
                if NetworkState.isConnected()
                {
                    hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.labelText = ""
                let str2 =  UserDefaults.standard.object(forKey: "registerid")
                let myInt1 = Int("0")
              let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

              // let playid = Int(stringvalue1)
             let verify_param = ["sessionID" :sessionid as Any,"storedProcedureName":"iCanPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!,"input3":playername,"input4":myInt1 as Any] as [String : Any]
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
                   stringvalue1 = dataarray.value(forKey:"Confirmation") as! String
                   self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                      self.PlayCall()
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
    
    func icanPlayCall()
        {
  
            if NetworkState.isConnected()
            {
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)
     hud.labelText = ""
         let str2 =  UserDefaults.standard.object(forKey: "registerid")
         let myInt1 = Int(myString)
    let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
     let verify_param = ["sessionID" :sessionid as Any,"storedProcedureName":"getPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!,"input3":btntuesday.currentTitle!,"input4":myInt1 as Any] as [String : Any]
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
    
    func Reorderelements()
    {
        
        if NetworkState.isConnected()
        {
           hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.labelText = ""
               let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                let str2 =  UserDefaults.standard.object(forKey: "registerid")
                //let myInt1 = Int(myString)
            let verify_param = ["sessionID" :sessionid as Any,"storedProcedureName":"iCanPlay","input1":str2 as Any ,"input2":btntuesday.currentTitle!,"input3":stringvaluename,"input4":icanplay as Any,"input5":souceindex as Any,"input6":destination as Any] as [String : Any]
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
                            stringvalue1 = dataarray.value(forKey:"Confirmation") as! String
                           // self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
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
                             self.showAlert(message: stringvalue1)
                            //self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                              
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
    var lastContentOffset: CGFloat = 0
     func scrollViewDidScroll(_ scrollView: UIScrollView)
     {
     if let _ = scrollView as? UITableView
     {
        print("tableview")
        scrollView.isScrollEnabled = true
      }
     else
     {
     scrollView.isScrollEnabled = false
      }

      }
       
}
