//
//  FootBallNewLocationVC.swift
//  Football Stats
//
//  Created by Chakri on 22/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
class FootBallNewLocationVC: UIViewController {

    
    @IBOutlet var btndelete: UIButton!
    @IBAction func btnconfirmAction(_ sender: Any) {
        self.GameUpdateLocation()
    }
    var hud : MBProgressHUD!
    @IBOutlet var txtsecond: UITextField!
    
    @IBOutlet var txtthird: UITextField!
    
    @IBOutlet var txtpostaldown: UITextField!
    
    @IBOutlet var txtfourth: UITextField!
    
    @IBOutlet var txtfirst: UITextField!
    
    @IBOutlet var btnconfirmlocation: UIButton!
    
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    var locationanem:String = ""
    var databasename:String = ""
    var databaseid :String = ""
    @IBOutlet var btndate: UIButton!
    
    @IBOutlet var btnpostal: UIButton!
    
    @IBAction func btnpostalAction(_ sender: Any) {
    }
    
    @IBOutlet var txtpstalname: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btndate.layer.cornerRadius = 9
        btndate.clipsToBounds = true
        btndate.layer.borderWidth = 1
        btndate.layer.borderColor = UIColor.black.cgColor
        btnpostal.layer.cornerRadius = 9
        btnpostal.clipsToBounds = true
        btnpostal.layer.borderWidth = 1
        btnpostal.layer.borderColor = UIColor.black.cgColor
        btndelete.clipsToBounds = true
        
        btnconfirmlocation.clipsToBounds = true
       btnconfirmlocation.layer.cornerRadius = 22
        txtpstalname.text = "HA8 6PB"
        self.GetPostalNames()
        self.GetNewLocation()
        // Do any additional setup after loading the view.
    }
    func GetNewLocation()
                  {
                    //SVProgressHUD.show()
          //            var string = String.self
          //            string = UserDefaults.standard.integer(forKey: "registerid")
                   hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                      hud.labelText = ""
                      
                      let str2 =  UserDefaults.standard.object(forKey: "registerid")
                      
                             // let string = btndateofmatich.currentTitle
                          //String(UserDefaults.standard.integer(forKey: "registerid"))
                      
                      let verify_param = ["storedProcedureName":"getLocation","input1":str2 as Any ,"input2":databasename,"input3":locationanem] as [String : Any]
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
                                 let dataarray = skippedArray.firstObject as! NSDictionary
                               if let partname = dataarray.value(forKey: "database_id") as? String
                             {
                                self.databaseid = partname
        
                              }
                              }
                              else
                              {
                                  
                              }
                              
//                self.LocationArray = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
//              self.reverseplayers = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
//              self.gamesetting = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
//                  let dataarray = skippedArray.firstObject as! NSDictionary
//                      //let result = self.dataarray[0] as? NSDictionary
//
//                          //  var stringvalue1 = ""
//                              self.stringvalue1 =  NSString(format: "%@",(dataarray.value(forKey: "game_ID") as! CVarArg)) as String
//                              print(self.stringvalue1)
//
//                       if let partname = dataarray.value(forKey: "game_date") as? String
//                     {
//                      self.btndate.setTitle(partname, for: .normal)
//
//                      }
//                      if let partname = dataarray.value(forKey: "gametype") as? String
//                       {
//                          self.btngametype.setTitle(partname, for: .normal)
//                        }
//                      if let partname = dataarray.value(forKey: "locationName") as? String
//                       {
//                          self.btnalperton.setTitle(partname, for: .normal)
//                        }
//                      if let partname = dataarray.value(forKey: "reserves") as? Int
//                       {
//                          let str2 = String(partname)
//                         self.btnreviseplayers.setTitle(str2, for: .normal)
//                        }
//                      if let partname = dataarray.value(forKey: "gametype") as? String
//                      {
//
//                      self.btnsidefootball.setTitle(partname, for: .normal)
//
//                        }
//                      if let partname = dataarray.value(forKey: "cost") as? Int
//                       {
//                      let str2 = String(partname)
//
//                          self.btnprize.setTitle(str2, for: .normal)
//                        }
//

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
    func GameUpdateLocation()
                  {
                    //SVProgressHUD.show()
          //            var string = String.self
          //            string = UserDefaults.standard.integer(forKey: "registerid")
                   hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                      hud.labelText = ""
                      
                      let str2 =  UserDefaults.standard.object(forKey: "registerid")
                    let databaseint = Int(databaseid)
                   //let myFloat = (btnprize.currentTitle! as NSString).floatValue
                             // let string = btndateofmatich.currentTitle
                          //String(UserDefaults.standard.integer(forKey: "registerid"))
                      
                    let verify_param = ["storedProcedureName":"addModifyLocation","input1":str2 as Any ,"input2":databaseint as Any,"input3":databaseint as Any,"input4":"","input5":btndate.currentTitle!,"input6":txtfirst.text!,"input7": txtsecond.text!,"input8":txtthird.text!,"input9":txtfourth.text!,"input10":txtpostaldown.text!] as [String : Any]
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
                                  
                              }
                           
                            }
                          }
                         }
                    
                    }
    func GetPostalNames()
                      {
                        //SVProgressHUD.show()
              //            var string = String.self
              //            string = UserDefaults.standard.integer(forKey: "registerid")
                        
                      // hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                          //hud.labelText = ""
                        let verify_param = ["storedProcedureName":"GetPostCode","input1":txtpstalname.text!] as [String : Any]
                              let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                                 AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                                    response in
                                   DispatchQueue.main.async{
                                          //self.hud.hide(true)

                                          }
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
                                     let dataarray = skippedArray.firstObject as! NSDictionary
                                   if let partname = dataarray.value(forKey: "Postcode") as? String
                                 {
                                    self.txtpostaldown.text =  partname
            
                                  }
                               if let partname = dataarray.value(forKey: "Line1") as? String
                             {
                                self.txtfirst.text =  partname
        
                              }
                               if let partname = dataarray.value(forKey: "Line6") as? String
                             {
                                self.txtsecond.text =  partname
        
                              }
                                    if let partname = dataarray.value(forKey: "Line7") as? String
                                    {
                                       self.txtthird.text =  partname
               
                                     }

                                    if let partname = dataarray.value(forKey: "Line2") as? String
                                 {
                                    self.txtthird.text =  partname
            
                                  }

                                  }
                                  else
                                  {
                                      
                                  }
                                  
  

                                }
                              }
                             }
                        
                        }
}
