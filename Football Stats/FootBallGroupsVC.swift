//
//  FootBallGroupsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import  Alamofire

class FootBallGroupsVC: UIViewController , UITableViewDelegate, UITableViewDataSource, NIDropDownDelegate
{
    
    var btndropdown = NIDropDown ()
       var hud : MBProgressHUD!
    @IBAction func btnselectAction(_ sender: Any) {
        
        let myFloatForR = 250
          var r = CGFloat(myFloatForR)
         // lazy var value: Float = 200
          btndropdown.isHidden = false
          btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (databasearray.value(forKey: "database_name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
          btndropdown.setDropDownSelectionColor(UIColor.gray)
          btndropdown.delegate = self
             btndropdown.tag = 2
    }
    
     var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
    //      var recents = ["THE GOBBLER", "THE VENETIAN"]
    //      var favorites = ["FRIES", "THE VENETIAN"]
    //    var Features = ["FRESH CUT FRIES", "STIR FRY QUINOA"]
           var menuimages = ["download", "download", "download" ,"download","download","download"]
    
   var databasearray =  NSMutableArray()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return skippedArray.count
        
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
              {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "FootBallPlayerTableCell", for: indexPath as IndexPath) as! FootBallPlayerTableCell
                
                  DispatchQueue.main.async{
                             let array = self.skippedArray[indexPath.row]
                             cell.profilename.text = (array as AnyObject).value(forKey: "Column1") as? String
                DispatchQueue.main.async{
                    //let image : UIImage = UIImage(named:((array as AnyObject).value(forKey: "seller_store_name") as! String) )!
                      //cell.profileimage.image = image
                //cell.storeImage.sd_setImage(with: URL(string:(array as AnyObject).value(forKey: "seller_store_image") as! String), placeholderImage: UIImage(named: ""))
                }
                           }
                  //cell.profilename.text = menu[indexPath.row]
                    //
                    //cell..selectionStyle = .none
             //  let image : UIImage = UIImage(named:menuimages[indexPath.row] )!
             //  cell.profileimage.image = image
                cell.profileimage.clipsToBounds = true
                cell.profileimage.layer.cornerRadius =  cell.profileimage.frame.size.width/2;
               
                 
                return cell
       }
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 70.0;//Choose your custom row height
          }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
              {
    //           if indexPath.row == 0
              // {
                let array = self.skippedArray[indexPath.row]
              //  cell.profilename.text = (array as AnyObject).value(forKey: "Column1")
              let login: FootBallPlayerAssociationVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallPlayerAssociationVC") as! FootBallPlayerAssociationVC)

                login!.playname = (array as AnyObject).value(forKey: "Column1") as! String
                login!.databasename = btndateofmatich.currentTitle!
               self.navigationController?.pushViewController(login!, animated: true)
   
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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btndateofmatich.layer.cornerRadius = 10
        btndateofmatich.clipsToBounds = true
        btndateofmatich.layer.borderWidth = 1
        btndateofmatich.layer.borderColor = UIColor.lightGray.cgColor
       // databasearray = UserDefaults.standard.object(forKey: "database") as! NSMutableArray
        //self.GroupsCall()
        self.Profilecall()

        // Do any additional setup after loading the view.
    }
    func GroupsCall()
           {
             //SVProgressHUD.show()
   //            var string = String.self
   //            string = UserDefaults.standard.integer(forKey: "registerid")
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                               hud.labelText = "Loading..."
               let str2 =  UserDefaults.standard.object(forKey: "registerid")
                      // let string = btndateofmatich.currentTitle
                   //String(UserDefaults.standard.integer(forKey: "registerid"))
            let verify_param = ["storedProcedureName":"getDatabaseGroup","input1":str2 as Any ,"input2":btndateofmatich.currentTitle!] as [String : Any]
                   let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                      AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
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
                         //UserDefaults.standard.set(jsonResponse.object(forKey: "register_id"), forKey: "registerid")
                      // var skippedArray = NSMutableArray()
                        self.skippedArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                        self.grouptable.reloadData()
                   
                      // let dataarray = skippedArray.firstObject as! NSDictionary
                       
                      

                       //Integer
   //                      let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
   //                         self.navigationController?.pushViewController(login!, animated: true)
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
    
    
     func Profilecall()
            {

                hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                    hud.labelText = "Loading..."
              //SVProgressHUD.show()
    //            var string = String.self
    //            string = UserDefaults.standard.integer(forKey: "registerid")
                let str2 =  UserDefaults.standard.object(forKey: "registerid")
                        
                    //String(UserDefaults.standard.integer(forKey: "registerid"))
                let verify_param = ["storedProcedureName":"getDatabaseNames","input1":str2 as Any] as [String : Any]
                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                       AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
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
                          //UserDefaults.standard.set(jsonResponse.object(forKey: "register_id"), forKey: "registerid")
                        var skippedArray = NSMutableArray()
                        skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                        
                        let dataarray = skippedArray.firstObject as! NSDictionary
                       
                        self.databasearray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                      
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
}
