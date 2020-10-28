//
//  AppDelegate.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureNotification(application: application)
        return true
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
        let userdefaults = UserDefaults.standard
        // userdefaults.set("segmenu", forKey: "refer")
        userdefaults.set(token, forKey: "Token")
        userdefaults.synchronize()
    let bundleID = Bundle.main.bundleIdentifier;
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
