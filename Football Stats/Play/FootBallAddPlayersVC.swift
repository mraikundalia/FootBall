//
//  FootBallAddPlayersVC.swift
//  Football Stats
//
//  Created by Chakri on 22/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import Reachability
class FootBallAddPlayersVC: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    class NetworkState
    {
        class func isConnected() ->Bool
        {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    var hud : MBProgressHUD!
  var playerid = ""
    var databasename  = ""
    var addplayername = ""
    var playername = ""
      var myString: String = ""
     var nohud: String = ""
    
    var member = [[String:AnyObject]]()

    var members = [String:AnyObject]()

    var searchActive = true
    var filtered = NSMutableArray()
    var data: [String] = []
    var filterArray: [Any] = []
    @IBAction func btnaddplayer(_ sender: Any) {
        
        self.showalertview()
    }
    var arrSelectedRows:[Int] = []
    @IBOutlet var tableview: UITableView!
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var btnaddplayer: UIButton!
    
    @IBAction func btnback(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
        //      var recents = ["THE GOBBLER", "THE VENETIAN"]
        //      var favorites = ["FRIES", "THE VENETIAN"]
        //    var Features = ["FRESH CUT FRIES", "STIR FRY QUINOA"]
    var menuimages = ["download", "download", "download" ,"download","download","download" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        //btnaddplayer.clipsToBounds = true
       // btnaddplayer.layer.cornerRadius = 22
        //btnaddplayer.layer.borderWidth = 1
        //btnaddplayer.layer.borderColor = UIColor.darkGray.cgColor
        self.PlayCall()
        // Do any additional setup after loading the view.
    }
     var skippedArray = NSMutableArray()
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
                                cell.borderview.clipsToBounds = true
                                   cell.borderview.layer.cornerRadius = 32
                                   cell.borderview.layer.borderWidth = 1;
                                   cell.borderview.layer.borderColor = UIColor.black.cgColor
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
                                    else
                                    {
                                    cell.borderview.clipsToBounds = true
                                    cell.borderview.layer.cornerRadius = 32
                                    cell.borderview.layer.borderWidth = 1;
                                    //cell.borderview.layer.borderColor = UIColor.init(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 0).cgColor
                                        cell.borderview.layer.borderColor =  UIColor.lightGray.cgColor

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
                                     
                                      
                                     // let x : Int = (array as AnyObject).value(forKey: "ICanPlay_id") as! Int
                        //let sname : NSString = (array  as AnyObject).value(forKey: "name") as? String
                                      
                                      //let myString = String(x)
                                      
                         
                                      //(array as AnyObject).value(forKey: "ICanPlay_id") as? String
                                DispatchQueue.main.async{
                            //let image : UIImage = UIImage(named:((array as AnyObject).value(forKey: "seller_store_name") as! String) )!
                              //cell.profileimage.image = image
                        //cell.storeImage.sd_setImage(with: URL(string:(array as AnyObject).value(forKey: "seller_store_image") as! String), placeholderImage: UIImage(named: ""))
                                                }
                                  }

                          //cell.profilename.text = menu[indexPath.row]
                            //
                            //cell..selectionStyle = .none
//                       let image : UIImage = UIImage(named:menuimages[indexPath.row] )!
//                       cell.profileimage.image = image
                      
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
              self.tickicanPlayCall()
            }
            else
            {
                let array = self.skippedArray[sender.tag]
              playername = ((array  as AnyObject).value(forKey: "name") as? String)!
               myString = "0"
              self.arrSelectedRows.remove(at: self.arrSelectedRows.firstIndex(of: sender.tag)!)
              self.tickicanPlayCall()
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
            self.untickicanPlayCall()
            }
            else
            {
            let array = self.skippedArray[sender.tag]
            if let partname = (array as AnyObject).value(forKey: "name") as? String
             {
                playername = partname
            }
               //playername = ((array  as AnyObject).value(forKey: "name") as? String)!
                
               self.arrSelectedRows.append(sender.tag)
                myString = "1"
                self.untickicanPlayCall()
            }
           
        }
        tableview.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showalertview()
{
    let blurEffect = UIBlurEffect(style: .extraLight)
      let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
      blurVisualEffectView.frame = view.bounds
      blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      blurVisualEffectView.alpha = 0.5
    let alertController = UIAlertController(title: "Add New Player Name", message: "", preferredStyle: UIAlertController.Style.alert)
    if let subview = alertController.view.subviews.first, let actionSheet = subview.subviews.first {
       for innerView in actionSheet.subviews {
           innerView.backgroundColor = .white
           innerView.layer.cornerRadius = 15.0
           innerView.clipsToBounds = true
           innerView.layer.borderColor = UIColor.black.cgColor
           innerView.layer.borderWidth = 1
       }
               }
    alertController.addTextField { (textField : UITextField!) -> Void in
          textField.placeholder = "Player Name"
     self.addplayername = textField.text!
        
      }
    let saveAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
        alert -> Void in
       // _ = alertController.textFields![0] as UITextField
        //_ = alertController.textFields![1] as UITextField
           blurVisualEffectView.removeFromSuperview()
      })
    
    let cancelAction = UIAlertAction(title: "Add Player", style: UIAlertAction.Style.default, handler: {
          (action : UIAlertAction!) -> Void in
        let text = (alertController.textFields?.first)!.text
        self.addplayername = text!
        if self.addplayername.count == 0
        {
            blurVisualEffectView.removeFromSuperview()
            self.showToast(message: "Please Enter Player Name", font: UIFont.systemFont(ofSize: 13))
        }
        else
        {
    blurVisualEffectView.removeFromSuperview()
        self.addplayer()
        }
    })
     alertController.view.tintColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 141.0/255.0, alpha: 1)
      alertController.addAction(saveAction)
      alertController.addAction(cancelAction)
      self.view.addSubview(blurVisualEffectView)
    self.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK:////////Api Call  /////////
    func tickicanPlayCall()
    {
        if NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                   hud.labelText = ""
                       let str2 =  UserDefaults.standard.object(forKey: "registerid")
                    let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

                       let myInt1 = Int(myString)
                       //let playid = Int(stringvalue1)
                    let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"iCanPlay","input1":str2 as Any ,"input2":databasename,"input3":playername,"input4":myInt1 as Any] as [String : Any]
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
                            // self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                                    self.showAlert(message: stringvalue1)

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
    
    
    
       func untickicanPlayCall()
    {

            if NetworkState.isConnected()
            {
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.labelText = ""
      let str2 =  UserDefaults.standard.object(forKey: "registerid")
      let myInt1 = Int(myString)
    // let playid = Int(stringvalue1)
     let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

     let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"iCanPlay","input1":str2 as Any ,"input2":databasename,"input3":playername,"input4":myInt1 as Any] as [String : Any]
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
        // self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
         self.showAlert(message: stringvalue1)

       // self.skippedArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
        //self.tableview.reloadData()
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
    
    
    func PlayCall()
                {

                    
        if NetworkState.isConnected()
        {
               if nohud == "YES"
            {
                
            }
            else
            {
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                hud.labelText = ""
            }
       
            
            //let str2 =  UserDefaults.standard.object(forKey: "registerid")
                   // let string = btndateofmatich.currentTitle
                //String(UserDefaults.standard.integer(forKey: "registerid"))
             let playeridvalue = Int(playerid)
            let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

            let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getPlayerList","input1":databasename ,"input2":playeridvalue as Any] as [String : Any]
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
                                      
            //                          self.databasearray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
            //
            //                         // self.databasearray = (jsonResponse["Data2"] as? NSArray)! as! NSMutableArray
            //                          let result = self.databasearray[0] as? NSDictionary
            //
            //                         // var stringvalue1 = ""
            //                          self.stringvalue1 =  NSString(format: "%@",(result!.value(forKey: "iCanPlay_id") as! CVarArg)) as String
            //                          print(self.stringvalue1)
            //
            //
         self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
         self.tableview.reloadData()
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
     func addplayer()
            {
              
                if NetworkState.isConnected()
                {
                    hud = MBProgressHUD.showAdded(to: self.view, animated: true)

          hud.labelText = ""
          let str2 =  UserDefaults.standard.object(forKey: "registerid")
        let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

        let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"sp_addNewPlayer","input1":str2 as Any ,"input2":databasename ,"input3":addplayername] as [String : Any]
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
              self.nohud = "YES"
              self.PlayCall()

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
        self.tableview.reloadData()
    
    }
//    func updateSearchResults(for searchController:
//         UISearchController) {
//
//     if (searchController.searchBar.text?.count)! > 0 {
//         guard let searchText = searchController.searchBar.text,
//         searchText != "" else {
//             return
//         }
//         filtered.removeAll()
//        let filterArray: [Any] = skippedArray.filter { NSPredicate(format: "(name contains[c] %@)", searchText).evaluate(with: $0) }
//
//             filtered = filterArray as! [String]
//
//
//         filtered = (filteredArray as
//          NSArray).filtered(using: searchPredicate)
//
//         print ("array = \(usersDataFromResponse)")
//
//         self.tableview.reloadData()
//      }
//
//
//    }
}


