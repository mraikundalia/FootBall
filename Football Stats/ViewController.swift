//
//  ViewController.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController ,singletonProtocol,PeopleInfoMAP
{

    let UserLocation_model = Model()
      var arrMarkerInfo:[String] = []
      var arrLatitude:[String] = []
      var arrLongitude:[String] = []
      var arrProfileImage:[String] = []
      
      var arrayForListOfUserViewByMe:[AnyObject] = [AnyObject]()
    
    @IBAction func btnsignupAction(_ sender: Any)
    {
        let login: FootBallSignupVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallSignupVC") as! FootBallSignupVC)
              self.navigationController?.pushViewController(login!, animated: true)
    }
    @IBOutlet var btnsignup: UIButton!
    @IBOutlet var btnlogin: UIButton!
    
    @IBAction func btnloginAction(_ sender: Any)
    {
          let login: FootballLoginVC? = (storyboard?.instantiateViewController(withIdentifier: "FootballLoginVC") as! FootballLoginVC)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnsignup.clipsToBounds = true
        btnsignup.layer.cornerRadius = 10
        btnlogin.clipsToBounds = true
        btnlogin.layer.cornerRadius = 10;
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
               switch (deviceIdiom)
               {

                    case .pad:
                        print("iPad style UI")
                        
                        btnlogin.titleLabel?.font = GlobalConstants.FontMedium
                        btnsignup.titleLabel?.font = GlobalConstants.FontMedium
                    case .phone:
                        print("iPhone and iPod touch style UI")
                    
                    case .tv:
                        print("tvOS style UI")
                    default:
                        print("Unspecified UI idiom")
                    
                    }
       // self.LoginApiCall()
      //  self.loginMethod()
        //self.loginvalue()
        // Do any additional setup after loading the view.
    }
    
    func loginvalue()
    {
        self.UserLocation_model.peopleInfoMAPDelegate = self
        
        self.UserLocation_model.sendListOfUserRequest(self, storedProcedureName: "sp_Login", email: "Email", emailid: "mehul.raikundalia@gmail.com", password: "StrongSeparateWell", viewControllerName: "chakri")
        
//        self.UserLocation_model.sendListOfUserRequest(self, mobiletype: "IOS", mobiledeviceid: Device_ID, socialtoken: token as String, socialtype:"Facebook", viewControllerName:"chakri")
    }
    
//    func LoginApiCall()
//  {
//
//  //  let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
//   let url = URL(string: "http://868de1a00561.ngrok.io/api/FootBall/APIExecute?storedProcedureName=sp_Login&input1=Email&input2=mehul.raikundalia@gmail.com&input3=StrongSeparateWell")
//
//    guard let requestUrl = url else { fatalError() }
//    // Create URL Request
//    var request = URLRequest(url: requestUrl)
//    // Specify HTTP Method to use
//    request.httpMethod = "GET"
//    // Send HTTP Request
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//        // Check if Error took place
//        if let error = error {
//            print("Error took place \(error)")
//            return
//        }
//
//        // Read HTTP Response Status code
//        if let response = response as? HTTPURLResponse {
//            print("Response HTTP Status code: \(response.statusCode)")
//        }
//
//        // Convert HTTP Response Data to a simple String
//        if let data = data, let dataString = String(data: data, encoding: .utf8) {
//            print("Response data string:\n \(dataString)")
//            //let str = "{\"name\":\"James\"}"
//           //let dict = ["location": "garden"]
//
//           //let string = "[{\"form_id\":3465,\"canonical_name\":\"df_SAWERQ\",\"form_name\":\"Activity 4 with Images\",\"form_desc\":null}]"
//           let data = dataString.data(using: .utf8)!
//           do {
//               if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
//               {
//                  print(jsonArray) // use the json here
//               } else {
//                   print("bad json")
//               }
//           }
//           catch let error as NSError
//           {
//               print(error)
//           }
////            let dict = self.convertToDictionary(text: dataString)
////            print("Response data string:\n \(String(describing: dict))")
//        }
//
//    }
//    task.resume()
//
//    }
    
    
    @IBAction func loginMethod(){
                    
            let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
                 let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                 AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                 if let json = response.value {
                 let jsonResponse = json as! NSDictionary
                 print(jsonResponse)
                 do
                 {
                    
                    let alertController = UIAlertController(title: "", message: NSString(format: "%@",(jsonResponse["register_id"] as! CVarArg)) as String, preferredStyle: .alert)
                    self.present(alertController, animated: true){
                    }
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                    alertController.dismiss(animated: true, completion: nil)
                    }
                    
    //                if(jsonResponse["status"] as! String == "sucess"){
    //
    //                }
                }
              }
             }
        }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getResponseForMap()
    {
       // let intIndex = 1 // where intIndex < myDictionary.count
        //let index = UserLocation_model.viewingbymeDataDict// index 1
        //serLocation_model.viewingbymeDataDict.keys[index]
       //arrayForListOfUserViewByMe = UserLocation_model.viewingbymeDataDict["token"]!
        let temparray = self.UserLocation_model.arraydata
            //print("\(self.UserLocation_model.tokenString,temparray)")
        UserDefaults.standard.set(self.UserLocation_model.tokenString, forKey:"token")
        UserDefaults.standard.synchronize()
        self.Logicsuccess()
    }
    
    func Logicsuccess() -> Void
    {

        self.UserLocation_model.peopleInfoMAPDelegate = self
        self.UserLocation_model.LoginApiCall(_currentViewController: self, token: self.UserLocation_model.tokenString as NSString)
    }
    
    func getLoginResponse()
    {
        print("u got the response here");
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "BillBoardVC") as! BillBoardVC
//        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

}

