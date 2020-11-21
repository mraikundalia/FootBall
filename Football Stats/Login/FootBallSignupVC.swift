//
//  FootBallSignupVC.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices
import Reachability

class FootBallSignupVC: UIViewController , UITextFieldDelegate ,GIDSignInDelegate , ASAuthorizationControllerDelegate {
    
    class NetworkState
          {
              class func isConnected() ->Bool
              {
                  return NetworkReachabilityManager()!.isReachable
              }
          }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          if let error = error {
               if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                 print("The user has not signed in before or they have since signed out.")
               } else {
                 print("\(error.localizedDescription)")
               }
               return
             }
             // Perform any operations on signed in user here.
             let userId = user.userID                  // For client-side use only!
             let idToken = user.authentication.idToken // Safe to send to the server
             let fullName = user.profile.name
             let givenName = user.profile.givenName
             let familyName = user.profile.familyName
             let email1 = user.profile.email
          
               email = user.profile.email!
               firstname = user.profile.name!
               Lastname  = user.profile.givenName!
               type  = "gmail"
               print(email1 as Any ,familyName as Any,givenName as Any,fullName as Any,idToken as Any,userId as Any)
             
          self.SignupCall()
        
    }
      var firstname  = ""
      var Lastname  = ""
      var email  = ""
       var type = ""
    
     var hud : MBProgressHUD!
    @IBOutlet var txtfirstname: UITextField!
    
    @IBOutlet var txtsurname: UITextField!
    
    @IBOutlet var txpassword: UITextField!
    
    @IBOutlet var txtemail: UITextField!

    @IBOutlet var txtconfirmpassword: UITextField!
    
    @IBOutlet var btnnext: UIButton!
    
    @IBOutlet var btnapple: UIButton!
    
    @IBOutlet var btnfacebook: UIButton!
    
    @IBOutlet var btngoogle: UIButton!
    
    
    @IBAction func btnclose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnnextAction(_ sender: Any)
    {
        
        
        if txtemail.text == "" || txtemail.text?.count == 0
               {
                   self.showToast(message: "Please Enter Email", font: UIFont.systemFont(ofSize: 13))
               }
            
        else if txtconfirmpassword.text == "" || txtconfirmpassword.text?.count == 0
               {
            self.showToast(message: "Please Enter Password", font: UIFont.systemFont(ofSize: 13))
               }
            else if txtfirstname.text == "" || txtfirstname.text?.count == 0
                 {
                self.showToast(message: "Please Enter First Name", font: UIFont.systemFont(ofSize: 13))
                 }
            else if txtsurname.text == "" || txtsurname.text?.count == 0
                 {
                self.showToast(message: "Please Enter Sur Name", font: UIFont.systemFont(ofSize: 13))
                 }
            else if txtconfirmpassword.text == txpassword.text
               {
                self.txpassword.resignFirstResponder()
                  self.txtconfirmpassword.resignFirstResponder()
                  self.txtsurname.resignFirstResponder()
                  self.txtfirstname.resignFirstResponder()
                  self.txtemail.resignFirstResponder()
                       self.SignupCall()
               }
               else
               {
              self.showToast(message: "Password Not Matching ", font: UIFont.systemFont(ofSize: 13))

               }
      

    }
    
    @IBAction func btnappleAction(_ sender: Any)
    {
        self.handleAppleIdRequest()
    }
    
    
    @IBAction func btngoogleAction(_ sender: Any)
    {
        type  = "gmail"
          GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    @IBAction func btnfacebookAction(_ sender: Any) {
    }
    
    //MARK: ///ViewDidLoad/////
    override func viewDidLoad()
    {
        super.viewDidLoad()
            btnnext.clipsToBounds = true
             btnnext.layer.cornerRadius = 10
             btnapple.clipsToBounds = true
             btnapple.layer.cornerRadius = 10;
               btnfacebook.clipsToBounds = true
               btnfacebook.layer.cornerRadius = 10;
               btngoogle.clipsToBounds = true
               btngoogle.layer.cornerRadius = 10;
        txtemail.delegate = self
        txtconfirmpassword.delegate = self
        txtsurname.delegate = self
        txtfirstname.delegate = self
        txpassword.delegate = self
        txtemail.clipsToBounds = true
        txtconfirmpassword.layer.cornerRadius = 5
        txtconfirmpassword.clipsToBounds = true
        txtfirstname.layer.cornerRadius = 5
        txtfirstname.clipsToBounds = true
        txtsurname.layer.cornerRadius = 5
        txtsurname.clipsToBounds = true
        txpassword.layer.cornerRadius = 5
        txpassword.clipsToBounds = true
        txtemail.layer.cornerRadius = 5
            txtemail.clipsToBounds = true
        
         GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
               switch (deviceIdiom) {

                    case .pad:
                        print("iPad style UI")
                        txtemail.font =  GlobalConstants.FontRegular
                        txtconfirmpassword.font = GlobalConstants.FontRegular
                        txtsurname.font = GlobalConstants.FontRegular
                        txtfirstname.font = GlobalConstants.FontRegular
                        txpassword.font = GlobalConstants.FontRegular
                        btnnext.titleLabel?.font = GlobalConstants.FontMedium
                    case .phone:
                        print("iPhone and iPod touch style UI")
                    
                    case .tv:
                        print("tvOS style UI")
                    default:
                        print("Unspecified UI idiom")
                    
                    }

        // Do any aetup after loading the view.
    }
    
    //MARK: /////Apple login///////
    @objc func handleAppleIdRequest() {
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.performRequests()
      }
      func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
      if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential
      {
      let userIdentifier = appleIDCredential.user
      let fullName = appleIDCredential.fullName
      let email1 = appleIDCredential.email
          print("Device Token: \(fullName as? String)","Device Token: \(email1 as? String)")
          type = "apple"
          firstname = (fullName as? String)!
          email =  (email1)!
          self.SignupCall()
      //print(User, id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email)))
          
          }
      }
      func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error)
      {
      // Handle error.
      }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField .resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField  == txtemail
            {
            if !self.isValidEmail(txtemail.text!)
            {
                // self.showToast(message: "Please Enter Valid Email", font: UIFont.systemFont(ofSize: 13))
            }
                                
            }
//        if textField  == txtconfirmpassword || textField == txpassword
//               {
//               let maxLength = 10
//                   let currentString: NSString = txtconfirmpassword!.text! as NSString
//               let newString: NSString =
//                   currentString.replacingCharacters(in: range, with: string) as NSString
//               return newString.length <= maxLength
//               }
       if ((txpassword.text?.elementsEqual(txtconfirmpassword.text!))! != true)
       {
          // Passwords do not match. Display alert message and return
          // self.showToast(message: "Password Not Match", font: UIFont.systemFont(ofSize: 13))
       
       }
            
      
               return true
        }

//    private func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
//                           replacementString string: String) -> Bool
//    {
//
//       // return true
//    }
    
       func SignupCall()
      {
        //SVProgressHUD.show()
        
        if NetworkState.isConnected()
        {
              
          let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
              
//            let a = "\(sessionid)"
//             print(a)
              hud = MBProgressHUD.showAdded(to: self.view, animated: true)

              hud.labelText = ""
              let appDelegate = UIApplication.shared.delegate as! AppDelegate

                 let modelName = UIDevice.modelName
              
              var verify_param: [String: Any] = [:]
                if type == "gmail"
              {
                  verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "sp_registerPlayer","input1":"Gmail","input2":email,"input3":"","input4":firstname,"input5":Lastname,"input6":"ios","input7":modelName,"input8":appDelegate.tokenvalue] as [String : Any]
              }
                 else if type == "apple"
                   {
                  verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "sp_registerPlayer","input1":"Apple","input2":txtemail.text!,"input3":"","input4":firstname,"input5":"","input6":"ios","input7":modelName,"input8":appDelegate.tokenvalue] as [String : Any]
                   }
                     else if type == "facebook"
                  {
                 verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "sp_registerPlayer","input1":"FaceBook","input2":txtemail.text!,"input3":"","input4":firstname,"input5":"","input6":"ios","input7":modelName,"input8":appDelegate.tokenvalue] as [String : Any]
                  }
              else
                {
                    verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "sp_registerPlayer","input1":"Email","input2":txtemail.text!,"input3":txtconfirmpassword.text!,"input4":txtfirstname.text!,"input5":txtsurname.text!,"input6":"ios","input7":modelName,"input8":appDelegate.tokenvalue] as [String : Any]
              }
                       let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
              AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON {
                          response in
                        //  SVProgressHUD.dismiss()
                       if let json = response.value
                       {
                  let jsonResponse = json as! NSDictionary
                      DispatchQueue.main.async{

                      self.hud.hide(true)

                      }
                      print(jsonResponse)
                       do
                       {
                          var skippedArray = NSMutableArray()
                                                
                          skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                          
                          let dataarray = skippedArray.firstObject as! NSDictionary
                        
                                                 
                          let keyExists = dataarray["registeredPlayer_ID"] != nil
                                                  
                          if keyExists
                          {
                                          
                  UserDefaults.standard.set(skippedArray.value(forKeyPath: "registeredPlayer_ID"), forKey: "registerid")  //Integer
                  let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
              self.navigationController?.pushViewController(login!, animated: true)
                  
                                  }
                              else{
                      var stringvalue:String = ""
                      stringvalue = dataarray.value(forKey:"ErrorDescription") as! String
                      //self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 14))
                              self.showAlert(message: stringvalue)
                              
                  }
                      }
                    }
                   }
        }
        else{
            self.showAlert(message:"Please Check Your Internet")
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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}






