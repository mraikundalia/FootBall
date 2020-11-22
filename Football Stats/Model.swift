//
//  Model.swift
//  Socialeb_Swift
//
//  Created by Crystal Logic on 04/07/17.
//  Copyright © 2017 Crystal-Logic Pvt Ltd. All rights reserved.
//

import UIKit
@objc protocol PeopleInfoMAP
{
    @objc optional func getResponseForMap()
     @objc optional func getLoginResponse()
}

class Model: NSObject,singletonProtocol,PeopleInfoMAP
{
    var peopleInfoMAPDelegate: PeopleInfoMAP?
    var viewingbymeDataDict = [String:[AnyObject]]()
    var viewingmeDataDict = [String:[AnyObject]]()
    var arraydata :[String]?
     var tokenString = String()
    
    func sendListOfUserRequest(_ currentViewController : UIViewController,storedProcedureName:String,email:String ,emailid:String, password:String,viewControllerName:String)
    {
      
        let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":email,"input3":password] as [String : Any]
      
       // let parameter = ["input1":email,"input2" :emailid ,"input3":password,"storedProcedureName":storedProcedureName,] as NSMutableDictionary?
      //  print("\(String(describing: parameter))")
        SingletonClass.sharedInstance.delegate = self
        
        SingletonClass.sharedInstance.Apicall(parameters: verify_param as NSDictionary, currentViewController: currentViewController, method: "POST", headerField: "", backgroundAPICall:false)
        
    }
    func Signupregister(_ currentViewController : UIViewController,storedProcedureName:String,email:String,emailid:String ,password:String, confirmpassword:String,firstname:String,surname:String,viewControllerName:String)
       {
           let parameter = ["storedProcedureName":storedProcedureName,"input1":email,"input2" :emailid ,"input3":password ,"input4":confirmpassword, "input5":firstname , "input6":surname] as NSMutableDictionary?
           print("\(String(describing: parameter))")
           SingletonClass.sharedInstance.delegate = self
           
        SingletonClass.sharedInstance.Apicall(parameters: parameter!, currentViewController: currentViewController, method: "POST", headerField: "", backgroundAPICall:false)
           
       }
    func getResponse(_ apiResponse: AnyObject?)
    {
        print("MY PROFILE RESPONSE IN MODEL --- \(String(describing: apiResponse))")
        arraydata = apiResponse as? [String]
        print("the array data is \(String(describing: arraydata))")
        
        if apiResponse is NSDictionary
        {
            //let status = apiResponse?.value(forKey: "register_id") as! String
            if let val = apiResponse?["register_id"]
                         {
                             if val != nil
                             {
                                 tokenString = apiResponse?.value(forKey: "register_id")  as! String
                                 let success = apiResponse?.value(forKey: "register_id") as AnyObject
                                 print("state is and success is....\(success)")
                                 
                                 peopleInfoMAPDelegate?.getResponseForMap!()
                             }
                             else {
                                 print("value is nil")
                                 peopleInfoMAPDelegate?.getLoginResponse!()

                             }
                         }
                         else
                         {
                             print("key is not present in dict")
                         }
//            if(status == "true")
//            {
//
//
//
//
//            }
//            else
//            {
//                print("false")
//            }
        }
        
    }
    func LoginApiCall(_currentViewController:UIViewController ,token:NSString)
    {
        let parameter = ["token":token] as NSMutableDictionary?
        print("\(String(describing: parameter))")
        
        SingletonClass.sharedInstance.delegate = self
        
        SingletonClass.sharedInstance.Apicall(parameters: parameter!, currentViewController: _currentViewController, method: "POST", headerField: "", backgroundAPICall:false)
        
    }
    func getuserResponse(_ loginapiResponse: AnyObject?)
    {
        print("MY PROFILE RESPONSE IN MODEL --- \(String(describing: loginapiResponse))")
        arraydata = loginapiResponse as? [String]
        print("the array data is \(String(describing: arraydata))")
        
        if loginapiResponse is NSDictionary
        {
            let status = loginapiResponse?.value(forKey: "success") as! String
            if(status == "true")
            {
                
                tokenString = loginapiResponse?.value(forKey: "status")  as! String
                let success = loginapiResponse?.value(forKey: "success") as AnyObject
                print("state is and success is....\(success)")
                
                peopleInfoMAPDelegate?.getLoginResponse!()
                
            }
            else
            {
                print("false")
            }
        }

    }
    
   
}
