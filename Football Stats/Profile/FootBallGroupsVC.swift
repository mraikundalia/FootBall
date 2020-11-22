//
//  FootBallGroupsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import  Alamofire
import Reachability
class FootBallGroupsVC: UIViewController , UITableViewDelegate, UITableViewDataSource, NIDropDownDelegate
{
    class NetworkState
          {
              class func isConnected() ->Bool
              {
                  return NetworkReachabilityManager()!.isReachable
              }
          }
    var btndropdown = NIDropDown ()
       var hud : MBProgressHUD!
     var filterArray: [Any] = []
    var searchActive = true

    @IBAction func btnselectAction(_ sender: Any)
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
          btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (databasearray.value(forKey: "database_name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
          btndropdown.setDropDownSelectionColor(UIColor.gray)
          btndropdown.delegate = self
             btndropdown.tag = 2
        }
    }
    
//     var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
//
//           var menuimages = ["download", "download", "download" ,"download","download","download"]
    
   var databasearray =  NSMutableArray()
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
                    if self.filterArray.count > 0
                    {
                        let array = self.filterArray[indexPath.row]
                        cell.profilename.text = (array as AnyObject).value(forKey: "Column1") as? String
                        DispatchQueue.main.async{
                                    //let image : UIImage = UIImage(named:((array as AnyObject).value(forKey: "seller_store_name") as! String) )!
                                      //cell.profileimage.image = image
                                //cell.storeImage.sd_setImage(with: URL(string:(array as AnyObject).value(forKey: "seller_store_image") as! String), placeholderImage: UIImage(named: ""))
                                }
                    }
                    else
                    {
                        let array = self.skippedArray[indexPath.row]
                    cell.profilename.text = (array as AnyObject).value(forKey: "Column1") as? String
                                DispatchQueue.main.async{
                                    //let image : UIImage = UIImage(named:((array as AnyObject).value(forKey: "seller_store_name") as! String) )!
                                      //cell.profileimage.image = image
                                //cell.storeImage.sd_setImage(with: URL(string:(array as AnyObject).value(forKey: "seller_store_image") as! String), placeholderImage: UIImage(named: ""))
                                }
                    }
                        
                     
                           }
                  //cell.profilename.text = menu[indexPath.row]
                    //
                    //cell..selectionStyle = .none
             //  let image : UIImage = UIImage(named:menuimages[indexPath.row] )!
             //  cell.profileimage.image = image
                cell.borderview.clipsToBounds = true
                   cell.borderview.layer.cornerRadius = 32
                   cell.borderview.layer.borderWidth = 1;
                   cell.borderview.layer.borderColor =  UIColor.lightGray.cgColor
                cell.profileimage.clipsToBounds = true
                cell.profileimage.layer.cornerRadius =  cell.profileimage.frame.size.width/2;
                               return cell
       }
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 85.0;//Choose your custom row height
          }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
              {
    //           if indexPath.row == 0
              // {
                if filterArray.count > 0
                {
                let array = self.filterArray[indexPath.row]
                 //  cell.profilename.text = (array as AnyObject).value(forKey: "Column1")
                 let login: FootBallPlayerAssociationVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallPlayerAssociationVC") as! FootBallPlayerAssociationVC)
                   login!.playname = (array as AnyObject).value(forKey: "Column1") as! String
                   login!.databasename = btndateofmatich.currentTitle!
                  self.navigationController?.pushViewController(login!, animated: true)
                }
                else
                {
                let array = self.skippedArray[indexPath.row]
                                 //  cell.profilename.text = (array as AnyObject).value(forKey: "Column1")
                 let login: FootBallPlayerAssociationVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallPlayerAssociationVC") as! FootBallPlayerAssociationVC)

                   login!.playname = (array as AnyObject).value(forKey: "Column1") as! String
                   login!.databasename = btndateofmatich.currentTitle!
                  self.navigationController?.pushViewController(login!, animated: true)
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
    @IBOutlet var searchbartext: UISearchBar!
    @IBOutlet var btndateofmatich: UIButton!
    
    @IBAction func btnActionGroupSettings(_ sender: Any)
    {
        let login: FootBallGroupSettingsVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallGroupSettingsVC") as! FootBallGroupSettingsVC)
        login!.btnvalue =  btndateofmatich.currentTitle!
        self.navigationController?.pushViewController(login!, animated: true)
    }
    @IBOutlet var grouptable: UITableView!

    var skippedArray = NSMutableArray()
    var hotelName =  ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        btndateofmatich.layer.cornerRadius = 8
        btndateofmatich.clipsToBounds = true
        btndateofmatich.layer.borderWidth = 1
        btndateofmatich.layer.borderColor = UIColor.lightGray.cgColor
        
       // databasearray = UserDefaults.standard.object(forKey: "database") as! NSMutableArray
        //self.GroupsCall()
        self.Profilecall()
        let defaults : UserDefaults = UserDefaults.standard
        hotelName = (defaults.value(forKey: "database_name") as! String?)!
       if(hotelName != "")
       {
        btndateofmatich .setTitle(hotelName, for: .normal)
        self.GroupsCall()
        }

        // Do any additional setup after loading the view.
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: NIDrop Delegat//////////////////////////
    func niDropDownDelegateMethod(_ sender: NIDropDown!) {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
       
               btndateofmatich.setTitle(title, for: .normal)
        self.GroupsCall()
               
    }
    
    func niDropDownHidden(_ sender: NIDropDown!)
    {
       
        btndropdown.isHidden = true
    }
    
   // MARK: Api Calls/////////////////////
     func Profilecall()
            {

      
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
                        var stringvalue:String = ""
                        stringvalue = jsonResponse["status"] as! String
                        var skippedArray = NSMutableArray()
                             skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                             
                             let dataarray = skippedArray.firstObject as! NSDictionary
                            
                        if stringvalue == "Success"
                          {
                                self.databasearray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                          }
                          else
                          {
                              var stringvalue1:String = ""
                              stringvalue1 = dataarray.value(forKey:"Update") as! String
                              self.showToast(message: stringvalue1, font: UIFont.systemFont(ofSize: 13))
                          }
        
                        
                  
                      }
                    }
                   }
              
              }
    //MARK: /////Api call/////////////
    func GroupsCall()
             {
     
                if NetworkState.isConnected()
                {
                    hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                                                   hud.labelText = ""
                                   let str2 =  UserDefaults.standard.object(forKey: "registerid")
                                       let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

                                let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getDatabaseGroup","input1":str2 as Any ,"input2":btndateofmatich.currentTitle!] as [String : Any]
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
                                             
                                              
                                            if stringvalue == "Success"
                                          {
                                            self.skippedArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                                            self.grouptable.reloadData()
                                            }
                                            else
                                            {
                                              var skippedArray1 = NSMutableArray()
                                             skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                              let dataarray = skippedArray1.firstObject as! NSDictionary
                                               var stringvalue1:String = ""
                                                stringvalue1 = dataarray.value(forKey:"Update") as! String
                                                self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                                            }
                                       
                                        

                                         }
                                       }
                                      }
                }
                else{
                    self.showAlert(message: "Please Check Your Internet")
                }
               }
    
    //MARK: /////Search Delegate Methods/////////////
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
            self.grouptable.reloadData()
        
        }
}
