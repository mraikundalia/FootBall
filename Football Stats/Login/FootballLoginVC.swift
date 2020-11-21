//
//  FootballLoginVC.swift
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

class FootballLoginVC: UIViewController  ,UITextFieldDelegate ,GIDSignInDelegate , ASAuthorizationControllerDelegate
{
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
           
        self.loginMethod()
    }
    var firstname  = ""
    var Lastname  = ""
    var email  = ""
     var type = ""
    var deviceid = ""
    @IBOutlet var btnrememberme: UIButton!
    @IBOutlet var txtemail: UITextField!
     var hud : MBProgressHUD!
    
    @IBOutlet var btnfacebook: UIButton!
    @IBOutlet var btngoogle: UIButton!
    
    @IBOutlet var btnapple: UIButton!
    @IBOutlet var btnlogin: UIButton!
    @IBOutlet var txtpassword: UITextField!
    var token =  ""
   var tokenvalue = ""
    @IBOutlet weak var signInButton: GIDSignInButton!

    @IBAction func btncloseAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnremberAction(_ sender: Any)
    {
        if txtemail.text?.count == 0
        
        {
            self.showToast(message: "Please Enter Email", font: UIFont.systemFont(ofSize: 13))
        }
       else
        {
            if (btnrememberme.isSelected == true)
            {
             btnrememberme.backgroundColor = UIColor.white
              btnrememberme.setBackgroundImage(UIImage(named: ""), for:.normal)
               UserDefaults.standard.set(nil, forKey: "emailid")
             btnrememberme.isSelected = false;
              // txtemail.isUserInteractionEnabled = true
            }
            else
            {
             //btncheck1.backgroundColor = UIColor.red
              btnrememberme.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)
               //UserDefaults.standard.set(txtemail.text, forKey: "emailid")
          // txtemail.isUserInteractionEnabled = false
             btnrememberme.isSelected = true;
               let myValue:NSString = txtemail.text! as NSString

               UserDefaults.standard.set(myValue, forKey:"emailid")
               UserDefaults.standard.synchronize()
            }
        }
    }
    
    @IBOutlet var btnforgotpassword: UIButton!
    
    @IBAction func btnforgotAction(_ sender: Any)
    {
        let login: FootBallResetPasswordVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallResetPasswordVC") as! FootBallResetPasswordVC)
              self.navigationController?.pushViewController(login!, animated: true)
    }
    
    
    @IBAction func btnsignupAction(_ sender: Any)
    {
        let login: FootBallSignupVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallSignupVC") as! FootBallSignupVC)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    
    @IBOutlet var btnsignup: UIButton!
    @IBAction func btnloginAction(_ sender: Any)
    {
        if txtemail.text == "" || txtemail.text?.count == 0
        {
            self.showToast(message: "Please Enter Email", font: UIFont.systemFont(ofSize: 13))

            
        }
        else if txtpassword.text == "" || txtpassword.text?.count == 0
        {
            self.showToast(message: "Please Enter Password", font: UIFont.systemFont(ofSize: 13))
        }
        else
        {
            self.txtpassword.resignFirstResponder()
            self.txtemail.resignFirstResponder()
            self.loginMethod()
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
    
    @IBAction func btnfacebookAction(_ sender: Any)
    {
        // 1
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
         if (error == nil){
            let fbloginresult : LoginManagerLoginResult = result!
           // if user cancel the login
           if (result?.isCancelled)!{
                   return
           }
           if(fbloginresult.grantedPermissions.contains("email"))
           {
             self.getFBUserData()
           }
         }
       }
    }
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
          if (error == nil){
            //everything works print the user data
            print(result)
          }
        })
      }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnlogin.clipsToBounds = true
      btnlogin.layer.cornerRadius = 10
      btnapple.clipsToBounds = true
      btnapple.layer.cornerRadius = 10
        btnfacebook.clipsToBounds = true
        btnfacebook.layer.cornerRadius = 10
        btngoogle.clipsToBounds = true
        btngoogle.layer.cornerRadius = 10
        btnrememberme.clipsToBounds = true
        btnrememberme.layer.cornerRadius = 2
        btnrememberme.layer.borderWidth = 1
        btnrememberme.layer.borderColor = UIColor.darkGray.cgColor
        txtemail.clipsToBounds = true
        txtemail.layer.cornerRadius = 5
        txtpassword.clipsToBounds = true
        txtpassword.layer.cornerRadius = 5;
        txtemail.delegate = self
        txtpassword.delegate = self
        GIDSignIn.sharedInstance().delegate = self
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch (deviceIdiom) {

             case .pad:
                 print("iPad style UI")
                 txtemail.font =  GlobalConstants.FontRegular
                 txtpassword.font = GlobalConstants.FontRegular
                 btnsignup.titleLabel?.font = GlobalConstants.FontMedium
                 btnlogin.titleLabel?.font = GlobalConstants.FontMedium
             case .phone:
                 print("iPhone and iPod touch style UI")
             
             case .tv:
                 print("tvOS style UI")
             default:
                 print("Unspecified UI idiom")
             
             }
         // UserDefaults.standard.set(txtemail.text, forKey: "emailid")
        if let favorites = UserDefaults.standard.object(forKey: "emailid")
        {
             // userDefault has a value
            txtemail.text =  ((favorites as Any) as! String)
             btnrememberme.setBackgroundImage(UIImage(named: "checkmark"), for:.normal)
           // txtemail.isUserInteractionEnabled = false
           
            
        }
        else {
             // userDefault is nil (empty)
             btnrememberme.setBackgroundImage(UIImage(named: ""), for:.normal)
        }
      
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
//        let authorizationButton = ASAuthorizationAppleIDButton()
//        authorizationButton.addTarget(self, action: #selector(handleLogInWithAppleIDButtonPress), for: .touchUpInside)
//        loginProviderStackView.addArrangedSubview(authorizationButton)
    }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField .resignFirstResponder()
    }
    

    
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
        self.loginMethod()
    //print(User, id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email)))
        
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error)
    {
    // Handle error.
    }
   func loginMethod(){
                    
        //[SVProgressHUD show];
        //SVProgressHUD.show()
    if NetworkState.isConnected()
    {
         hud = MBProgressHUD.showAdded(to: self.view, animated: true)
               hud.labelText = ""
            let modelName = UIDevice.modelName
            let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
            deviceid = UUIDValue
            print("UUID: \(UUIDValue)")

     
           
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
           
            var verify_param: [String: Any] = [:]
        let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

            if type == "gmail"
          {
            verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "sp_Login","input1":"Google","input2":email,"input3":"","input4":"ios","input5":modelName,"input6":appDelegate.tokenvalue] as [String : Any]
            }
                else if type == "apple"
            {
                verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "sp_Login","input1":"Apple","input2":email,"input3":"","input4":"ios","input5":modelName,"input6":appDelegate.tokenvalue] as [String : Any]
            }
            else
           {
            verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "sp_Login","input1":"Email","input2":txtemail.text!,"input3":txtpassword.text!,"input4":"ios","input5":modelName,"input6":tokenvalue] as [String : Any]
            }
           
                //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
                            let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
            
            AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers: signin_headers).responseJSON { response in
                            if let json = response.value {
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
                                
                                //let keyExists = dataarray["register_id"] != nil
                                    var stringvalue:String = ""
                            stringvalue = jsonResponse["status"] as! String
                                
                                if stringvalue == "Failure"
                                {
                                    let dataarray = skippedArray.firstObject as! NSDictionary
                                                               
                                    var stringvalue:String = ""
                                    stringvalue = dataarray.value(forKey:"ErrorDescription") as! String
                                    DispatchQueue.main.async{
                        self.btnrememberme.setBackgroundImage(UIImage(named: ""), for:.normal)
                        UserDefaults.standard.set(nil, forKey: "emailid")
                        UserDefaults.standard.synchronize()
                        // self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                                self.showAlert(message: stringvalue)
                                    }
                                }
                                else
                                {
                                    UserDefaults.standard.set(skippedArray.value(forKeyPath: "register_id"), forKey: "registerid")
                                                                                         //Integer
                             let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
                                self.navigationController?.pushViewController(login!, animated: true)
                                    
                                }
                                }
                                
                               
                                
                            
                                
                              }
                               
             
                           
                         }
    }
    else
    {
         self.showToast(message: "NO Internet", font: UIFont.systemFont(ofSize: 14))
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

}
extension UIViewController {

func showToast(message : String, font: UIFont) {

  //  let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-75, y: self.view.frame.size.height-100, width: 150, height: 35))
    let toastLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height-180, width: self.view.frame.size.width, height: 45))
    toastLabel.backgroundColor = UIColor.black
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 5.0, delay: 0.2, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }



extension UIViewController {

func showAlert(message : String) {

  //  let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-75, y: self.view.frame.size.height-100, width: 150, height: 35))
    let blurEffect = UIBlurEffect(style: .extraLight)
         let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
         blurVisualEffectView.frame = view.bounds
         blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         blurVisualEffectView.alpha = 0.3
      let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
    if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first {
    for innerView in actionSheet.subviews {
        innerView.backgroundColor = .white
        innerView.layer.cornerRadius = 15.0
        innerView.clipsToBounds = true
        innerView.layer.borderColor = UIColor.black.cgColor
        innerView.layer.borderWidth = 1
    }
    }
         alert.addAction(UIAlertAction(title: "OK",
                                       style: UIAlertAction.Style.default,
                                       handler: {(_: UIAlertAction!) in
                                         //Sign out action
        blurVisualEffectView.removeFromSuperview()
         }))
    alert.view.tintColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 141.0/255.0, alpha: 1)
     self.view.addSubview(blurVisualEffectView)
    self.present(alert, animated: true, completion: nil)
} }



extension UIView
{
    func addShadow(to edges: [UIRectEdge], radius: CGFloat = 3.0, opacity: Float = 0.6, color: CGColor = UIColor.black.cgColor) {

        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity

            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
        }
    }

    func removeAllShadows() {
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    
    @objc func reachabilityChanged(note: Notification)
    {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network not reachable")
      case .none:
         print("Network not reachable")
        }
    }
}
public extension UIDevice {

static let modelName: String = {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                    return "iPad (8th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                    return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                    return "iPad Air (4th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

