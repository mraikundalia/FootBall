//
//  SingletonClass.swift
//  Socialeb_Swift
//
//  Created by Crystal Logic on 04/07/17.
//  Copyright © 2017 Crystal-Logic Pvt Ltd. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD
import Alamofire
@objc protocol singletonProtocol
{
    @objc optional func getResponse(_ apiResponse : AnyObject?)
    
    @objc optional func getErrorResponse(_ errorResponse : AnyObject?)
    
}

class SingletonClass: NSObject,singletonProtocol
{
    
    // Protocol delegate
    var delegate : singletonProtocol?
    //var  viewdelegate : UIView!
    static let sharedInstance = SingletonClass()
    
    func Apicall(parameters : NSDictionary, currentViewController  : UIViewController, method : String, headerField : String,backgroundAPICall:Bool) -> Void
    {
//                let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
        let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
        AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: parameters as? Parameters, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                     if let json = response.value {
                     let jsonResponse = json as! NSDictionary
                     print(jsonResponse)
                     do
                     {
                        let when = DispatchTime.now() + 2
                         DispatchQueue.main.asyncAfter(deadline: when){
                         self.delegate?.getResponse!(json as AnyObject)
                         }
                    }
                  }
                 }
            
//        let manager = AFHTTPSessionManager(baseURL: URL(string: url))
//        manager.responseSerializer = AFHTTPResponseSerializer()
//        manager.responseSerializer.acceptableContentTypes =  NSSet(set: ["application/json"]) as? Set<String>
//        manager.post(url, parameters: parameters, headers: nil, progress: nil, success:{ (task:URLSessionDataTask, responseObject) -> Void in
//
//                 //let responseData = String(data: responseObject as! Data, encoding: String.Encoding.utf8)
//
//
//                //print(responseData ?? "123")
//                let json = try? JSONSerialization.jsonObject(with: responseObject as! Data, options: [])
//
//                print("\(String(describing: json))")
//                // Call Success Response Delegate
//                self.delegate?.getResponse!(json as AnyObject)
////                MBProgressHUD.hide(for: currentViewController.view, animated: true);
//                // Stop Loader
//
//            }, failure: { (task:URLSessionDataTask?, error:Error) -> Void in
//                // print("API response error---->\(error.localizedDescription)")
//
//                SVProgressHUD.dismiss()
//
//            })
        
    }

}
extension URL {

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        self = urlComponents.url!
    }
}
