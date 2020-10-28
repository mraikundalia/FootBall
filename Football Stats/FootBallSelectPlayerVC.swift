//
//  FootBallSelectPlayerVC.swift
//  Football Stats
//
//  Created by Chakri on 27/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire

class FootBallSelectPlayerVC: UIViewController ,UITableViewDelegate,UITableViewDataSource , UISearchBarDelegate{
    
    var hud : MBProgressHUD!
    var btnallowplay:String = ""
    
    @IBOutlet var selectplayertbl: UITableView!
    var data: [String] = []
    var filterArray: [Any] = []
     var skippedArray = NSMutableArray()
    var searchActive = true
    var myString: String = ""
    var stringvalue1: String = ""
      var postionnum: String = ""
      var sortedteamid: String = ""
      var icanplayid: String = ""
    var databasearray =  NSMutableArray()
    var playername = ""

    var arrSelectedRows:[Int] = []

    @IBAction func btnbackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnaddplayerAction(_ sender: Any)
    {
        let login: FootBallAddPlayersVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallAddPlayersVC") as! FootBallAddPlayersVC)
        login!.playerid = sortedteamid
        login!.databasename = btnallowplay
    self.navigationController?.pushViewController(login!, animated: true)
    }
    
    // MARK:ViewDidLoad ///////////////////
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.GetAllPlayers()
    }
//MARK: TableView Delegate Methods
    
   
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
          {
             if filterArray.count>0
              {
                  return filterArray.count
              }
              else
              {
              return skippedArray.count
              }
              
          }
                      
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FootBallPlayerTableCell", for: indexPath as IndexPath) as! FootBallPlayerTableCell
              
                        DispatchQueue.main.async{
                          
                          if self.filterArray.count>0
                          {
                              let array = self.filterArray[indexPath.row]
                              cell.profilename.text = (array  as AnyObject).value(forKey: "name") as? String
                              cell.profileimage.clipsToBounds = true
                        cell.profileimage.layer.cornerRadius =  cell.profileimage.frame.size.width/2;
                        cell.checkbutton.clipsToBounds = true
                        cell.checkbutton.tag = indexPath.row
                        cell.checkbutton.layer.cornerRadius = cell.checkbutton.frame.size.width/2
                        if self.arrSelectedRows.contains(indexPath.row)
                        {
                           cell.checkbutton.setImage(UIImage(named:"checkmark"), for: .normal)
                        }
                       else
                        {
                            cell.checkbutton.setImage(UIImage(named:"checkBocUnchecked"), for: .normal)
                        }
                        cell.checkbutton.layer.borderColor = UIColor.darkGray.cgColor
                       cell.checkbutton.layer.borderWidth = 1
                        cell.checkbutton.addTarget(self, action: #selector(self.checkBoxSelection(_:)), for: .touchUpInside)
                          }
                         
                  let array = self.skippedArray[indexPath.row]
                  cell.profilename.text = (array  as AnyObject).value(forKey: "name") as? String
                  cell.profileimage.clipsToBounds = true
                    cell.profileimage.layer.cornerRadius =  cell.profileimage.frame.size.width/2;
                    cell.checkbutton.clipsToBounds = true
                    cell.checkbutton.tag = indexPath.row
                    cell.checkbutton.layer.cornerRadius = cell.checkbutton.frame.size.width/2
                  if self.arrSelectedRows.contains(indexPath.row)
                    {
                        cell.checkbutton.setImage(UIImage(named:"checkmark"), for: .normal)
                    }
                    else
                    {
                        cell.checkbutton.setImage(UIImage(named:"checkBocUnchecked"), for: .normal)
                    }
                    cell.checkbutton.layer.borderColor = UIColor.darkGray.cgColor
                   cell.checkbutton.layer.borderWidth = 1
                    cell.checkbutton.addTarget(self, action: #selector(self.checkBoxSelection(_:)), for: .touchUpInside)
                                                                 
                }
                           
                            
                   

               
              return cell
     }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70.0;//Choose your custom row height
        }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
            {
  //           if indexPath.row == 0
            // {
        
            
              
             }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
       {
           searchActive = true
       }

       func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
       {
           searchActive = false
             searchBar.endEditing(true)
       }
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
       {
           searchActive = false
             searchBar.endEditing(true)
           
       }
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
       {
           searchActive = false
             searchBar.endEditing(true)
       }


               func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

                   filterArray = skippedArray.filter { NSPredicate(format: "(name contains[c] %@)", searchText).evaluate(with: $0) }
                 
           //        filtered = (skippedArray.value(forKey: "name") as AnyObject).filter({ (text) -> Bool in
           //            let tmp:NSString = text as! NSString
           //            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
           //            return range.location != NSNotFound
           //        }) as! [String]

                   if (filterArray.count == 0
                       ){
                       searchActive = false
                      searchBar.endEditing(true)

                   }
                   else{
                       searchActive = true
                   }
                   self.selectplayertbl.reloadData()
               
               }

        @objc func checkBoxSelection(_ sender:UIButton)
          {
              
              if self.arrSelectedRows.contains(sender.tag)
              {
                  if filterArray.count>0
                  {
                      let array = self.filterArray[sender.tag]
                    playername = ((array  as AnyObject).value(forKey: "name") as? String)!
                     myString = "0"
                    self.arrSelectedRows.remove(at: self.arrSelectedRows.firstIndex(of: sender.tag)!)
                    if let partname = (array as AnyObject).value(forKey: "orderNumber") as? Int
                        {
                           let str2 = String(partname)
                          myString = str2
                         }
                  
                    
                  }
                  else
                  {
                      let array = self.skippedArray[sender.tag]
                    playername = ((array  as AnyObject).value(forKey: "name") as? String)!
                    if let partname = (array as AnyObject).value(forKey: "orderNumber") as? Int
                             {
                                let str2 = String(partname)
                               myString = str2
                              }
                     
                    self.arrSelectedRows.remove(at: self.arrSelectedRows.firstIndex(of: sender.tag)!)
                   
                  }

              }
              else
              {
                  if filterArray.count>0
                  {
                  let array = self.filterArray[sender.tag]
                 playername = ((array  as AnyObject).value(forKey: "name") as? String)!
                 self.arrSelectedRows.append(sender.tag)
                  myString = "1"
                   
                 // self.untickicanPlayCall()
                  }
                  else
                  {
                      let array = self.skippedArray[sender.tag]
                     playername = ((array  as AnyObject).value(forKey: "name") as? String)!
                     self.arrSelectedRows.append(sender.tag)
                      myString = "1"
                     self.Selectplayer()
                      //self.untickicanPlayCall()
                  }

              }
              selectplayertbl.reloadData()
          }
       
        
         //MARK: Api Call/////////////
            
          
           func GetAllPlayers()
                         {
                      
                        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        let sorted = Int(sortedteamid)
                        let postion = Int(postionnum)
                            let icanplay = Int(icanplayid)
                          let verify_param = ["storedProcedureName":"getTeamSelectionPlayers","input1":sorted  as Any ,"input2":postion as Any,"input3":icanplay as Any] as [String : Any]
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
                                   //et dataarray = skippedArray1.firstObject as! NSDictionary

                                  // self.databasearray = (jsonResponse["Data2"] as? NSArray)! as! NSMutableArray
                                   let result = self.databasearray[0] as? NSDictionary
                                  // var stringvalue1 = ""
                             
           //                        if let partname = self.dataarray.value(forKey: "reserves") as? Int
           //                            {
           //                               let str2 = String(partname)
           //                              self.btnreviseplayers.setTitle(str2, for: .normal)
           //                             }
                                  // self.stringvalue1 =  NSString(format: "%@",(result!.value(forKey: "iCanPlay_id") as! CVarArg)) as String
                                  // print(self.stringvalue1)
                        self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                var skippedArray1 = NSMutableArray()
                                skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                 let dataarray = skippedArray1.firstObject as! NSDictionary
                                  var stringvalue1:String = ""
                                   stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                                
                                if stringvalue1 == "All players allocation to the pitch"
                                {
                                     
                                }
                                else
                                {
                                    self.selectplayertbl.reloadData()
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
    //Api Call  /////////
       func Selectplayer()
                      {
                        //SVProgressHUD.show()
              //            var string = String.self
              //            string = UserDefaults.standard.integer(forKey: "registerid")
                       hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                      hud.labelText = ""
                         // let str2 =  UserDefaults.standard.object(forKey: "registerid")
                          let myInt1 = Int(sortedteamid)
                          let playid = Int(myString)
                        // let playernumber = Int(postionnum)
                        //"input4":"","input5":playernumber as Any
                       let verify_param = ["storedProcedureName":"sp_update_teamSelection","input1":myInt1 as Any ,"input2":playid as Any,"input3":playername] as [String : Any]
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
