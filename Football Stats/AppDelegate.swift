//
//  AppDelegate.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn
import Reachability
import LocalAuthentication
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var context = LAContext()
    var hud : MBProgressHUD!
var firstname  = ""
var Lastname  = ""
var email  = ""
 var type = ""
 var tokenvalue = ""
    var sessionid = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.GetSessionid()
        configureNotification(application: application)
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        GIDSignIn.sharedInstance().clientID = "106972369674-2e9l5ddp1o4ke65hkk29spual116k2l6.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self  // If AppDelegate conforms to GIDSignInDelegate
        
       // self.showauthentication()
        
        let reachability = try! Reachability()

               reachability.whenReachable = { reachability in
                   if reachability.connection == .wifi
                   {
                       print("Reachable via WiFi")
                   } else {
                       print("Reachable via Cellular")
                   }
               }
               reachability.whenUnreachable = { _ in
                   print("Not reachable")
               }

               do {
                   try reachability.startNotifier()
               } catch {
                   print("Unable to start notifier")
               }
        return true
    }
    
    
    
    func showauthentication()
    {
        let context = LAContext()
                
        var error: NSError?
                
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                 error: &error) {
                    
            if (context.biometryType == LABiometryType.faceID)
            {
                context.evaluatePolicy(
                  LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                  localizedReason: "Authentication is required for access",
                  reply: {(success, error) in
                      // Code to handle reply here
                     self.ShowAlert(_messagetxt: "device has  faceid")
                })
                //self.ShowAlert(_messagetxt: "device has no faceid")
                
            } else if context.biometryType == LABiometryType.touchID
            {
                // Device supports Touch ID
                 self.ShowAlert(_messagetxt: "device has  touch id")
            } else
            {
                // Device has no biometric support
            }
//        let topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
//     topWindow?.rootViewController = UIViewController()
//     topWindow?.windowLevel = UIWindow.Level.alert + 1
//        let context = LAContext()
//        var error: NSError?
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "Identify yourself!"
//
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
//            {
//                [weak self] success, authenticationError in
//
//                DispatchQueue.main.async {
//                    if success
//                    {
//                       // self?.unlockSecretMessage()
//                    }
//                    else
//                    {
//                        // error
//                        let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
//                        ac.addAction(UIAlertAction(title: "OK", style: .default))
//                        topWindow?.rootViewController?.present(ac, animated: true, completion: nil)
//
//
//                    }
//                }
//            }
//        } else
//        {
//            // no biometry
//        }

        
    }
    }
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
     GIDSignIn.sharedInstance().handle(url)
        
        return ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
  
    }
  
    func configureNotification(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert]) { granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
   
        // ...
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // 1. Convert device token to string
    let tokenParts = deviceToken.map { data -> String in
    return String(format: "%02.2hhx", data)
    }
    let token = tokenParts.joined()
    // 2. Print device token to use for PNs payloads
    print("Device Token: \(token)")
        
        tokenvalue =  token
        let userdefaults = UserDefaults.standard
        // userdefaults.set("segmenu", forKey: "refer")
        userdefaults.set(tokenvalue, forKey: "Token")
        userdefaults.synchronize()
    let bundleID = Bundle.main.bundleIdentifier;
        var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        topWindow?.windowLevel = UIWindow.Level.alert + 1

        let alert = UIAlertController(title: "APNS", message: tokenvalue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            // continue your work

            // important to hide the window after work completed.
            // this also keeps a reference to the window until the action is invoked.
            topWindow?.isHidden = true // if you want to hide the topwindow then use this
            topWindow = nil // if you want to hide the topwindow then use this
         })

        topWindow?.makeKeyAndVisible()
        topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    print("Bundle ID: \(token) \(bundleID)");
    // 3. Save the token to local storeage and post to app server to generate Push Notification. ...
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("failed to register for remote notifications: \(error.localizedDescription)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    print("Received push notification: \(userInfo)")
    let aps = userInfo["aps"] as! [String: Any]
    print("\(aps)")
        
    }
    func ShowAlert (_messagetxt : NSString)
    {
      DispatchQueue.main.async
        {
     var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
               topWindow?.rootViewController = UIViewController()
               topWindow?.windowLevel = UIWindow.Level.alert + 1
           let alert = UIAlertController(title: "Remove player for game", message: "Are you sure you want to remove player?", preferredStyle: UIAlertController.Style.alert)
         if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first
         {
         for innerView in actionSheet.subviews
         {
             innerView.backgroundColor = .white
             innerView.layer.cornerRadius = 15.0
             innerView.clipsToBounds = true
             innerView.layer.borderColor = UIColor.black.cgColor
             innerView.layer.borderWidth = 1
         }
         }
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                  //Cancel Action
             topWindow?.isHidden = true // if you want to hide the topwindow then use this
             topWindow = nil // if you want to hide the topwindow then use this
              }))
         topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {

        // Make sure the root controller has been set
        // (won't initially be set when the app is launched)
        let topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        if let navigationController = topWindow!.rootViewController as? UINavigationController {

            // If the visible view controller is the
            // view controller you'd like to rotate, allow
            // that window to support all orientations
            if navigationController.visibleViewController is FootBallAllStatsVC {
                return UIInterfaceOrientationMask.landscape
            }

            // Else only allow the window to support portrait orientation
            else {
                return UIInterfaceOrientationMask.portrait
            }
        }

        // If the root view controller hasn't been set yet, just
        // return anything
        return UIInterfaceOrientationMask.portrait
    }
    
     func GetSessionid(){
                        
            //[SVProgressHUD show];
            //SVProgressHUD.show()
        let topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
                   topWindow?.windowLevel = UIWindow.Level.alert + 1
           hud = MBProgressHUD.showAdded(to: topWindow, animated: true)
           hud.labelText = ""
           
        let str2 =  UserDefaults.standard.object(forKey: "registerid")
        
        //let string = NSString.init(format:"%d", str2 as Any)
      
    var verify_param: [String: Any] = [:]
        
    if ((str2) != nil)
   {
     verify_param = ["sessionID":"-1" as Any,"storedProcedureName": "get_seq_SessionID","input1": str2 as Any] as [String : Any]
        
    }
    else
   {
      verify_param = ["sessionID":"-1" as Any,"storedProcedureName": "get_seq_SessionID","input1": "0"] as [String : Any]
    }
     
        let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
        
        AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                        if let json = response.value {
                        let jsonResponse = json as! NSDictionary
                            
                            DispatchQueue.main.async{

                                self.hud.hide(true)

                            }
                            //let when = DispatchTime.now() + 2
    //                DispatchQueue.main.asyncAfter(deadline: when){
    //                    SVProgressHUD.dismiss()
    //                        }
                        print(jsonResponse)
                            
                        do
                        {
                            //t sizeDict = jsonResponse.objec["Data1"]
                            
                           
                            //jsonResponse["register_id"] as! CVarArg
                            var skippedArray = NSMutableArray()
                            
                            skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
      
                              let dataarray = skippedArray.firstObject as! NSDictionary
                            
                            //let keyExists = dataarray["register_id"] != nil
                                var stringvalue:String = ""
                        stringvalue = jsonResponse["status"] as! String
                            
                            if stringvalue == "Failure"
                            {
                                let dataarray = skippedArray.firstObject as! NSDictionary
                                                           
                                var stringvalue:String = ""
                                stringvalue = dataarray.value(forKey:"ErrorDescription") as! String
                                DispatchQueue.main.async{
                                    
                                    UserDefaults.standard.set(nil, forKey: "emailid")
                                    UserDefaults.standard.synchronize()
                                    
                                    
                                }
                            }
                            else
                            {
                                UserDefaults.standard.set(skippedArray.value(forKeyPath: "sessionID"), forKey: "Sessionid")
                                                                                     //Integer
                      
                                
                            }
    //                        if keyExists
    //                        {
    //                           UserDefaults.standard.set(skippedArray.value(forKeyPath: "register_id"), forKey: "registerid")
    //                                                      //Integer
    //                              let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
    //                                 self.navigationController?.pushViewController(login!, animated: true)
    //                        } else
    //                        {
    //                      let dataarray = skippedArray.firstObject as! NSDictionary
    //
    //                      var stringvalue:String = ""
    //                  stringvalue = dataarray.value(forKey:"returnV") as! String
    //
    //                     if (stringvalue == "Invalid email address" || stringvalue == "Failure - Invalid email address" )
    //                    {
    //
    //                     let alert = UIAlertController(title: "", message: stringvalue,         preferredStyle: UIAlertController.Style.alert)
    //
    //                     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
    //                            //Cancel Action
    //                        }))
    //                        alert.addAction(UIAlertAction(title: "OK",
    //                                                      style: UIAlertAction.Style.default,
    //                                                      handler: {(_: UIAlertAction!) in
    //                                                        //Sign out action
    //                        }))
    //                        self.present(alert, animated: true, completion: nil)
    //                     }
                            }
                            
                           
                            
                            //}
                            
                          }
                           
           //                if(jsonResponse["status"] as! String == "sucess"){
           //
           //                }
                       
                     }
                    }
}



/*
 
 message = "near by stores";
 status = ok;
 stores =     (
             {
         "seller_city" = Kakinada;
         "seller_distance" = 0;
         "seller_id" = 35;
         "seller_store_image" = "https://www.ellocart.in/uploads/sellers/ELOCXc9puoudexIz/f8334f748067cd8b7ba975bebf9c0d3e.jpeg";
         "seller_store_name" = "Revansh Electronics";
     },
             {
         "seller_city" = Kakinada;
         "seller_distance" = 0;
         "seller_id" = 40;
         "seller_store_image" = "https://www.ellocart.in/uploads/sellers/ELOCe9Mtk0tAJFcN/fd92db091cce41b5fdbab26578358249.jpeg";
         "seller_store_name" = "Vamsi Fancy Store";
     }
 );
 
 
 service calling
 
 
 
 if(jsonResponse["status"] as! String == "ok"){
    self.shopNamesArray = jsonResponse["stores"] as! NSArray
    self.userHomeTableView.dataSource = self
    self.userHomeTableView.delegate = self
    self.userHomeTableView.reloadData()
    self.noshopLabel.alpha = 0.0
 }
 else{
 
 }
 
 // cellfor row
 
 let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetail", for: indexPath as IndexPath) as! UserCartCell
              DispatchQueue.main.async{
              let array = self.shopNamesArray[indexPath.row]
              cell.userCartProductName.text = (array as AnyObject).value(forKey: "seller_store_name") as? String
 DispatchQueue.main.async{
 cell.storeImage.sd_setImage(with: URL(string:(array as AnyObject).value(forKey: "seller_store_image") as! String), placeholderImage: UIImage(named: ""))
 }
            }
 */
