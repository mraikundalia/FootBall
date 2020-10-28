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

class FootballLoginVC: UIViewController  ,UITextFieldDelegate{
     
    @IBOutlet var btnrememberme: UIButton!
    @IBOutlet var txtemail: UITextField!
     var hud : MBProgressHUD!
    
    @IBOutlet var btnfacebook: UIButton!
    @IBOutlet var btngoogle: UIButton!
    
    @IBOutlet var btnapple: UIButton!
    @IBOutlet var btnlogin: UIButton!
    @IBOutlet var txtpassword: UITextField!
    
    
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
        
    }
    
    @IBAction func btngoogleAction(_ sender: Any)
    {
    }
    
    @IBAction func btnfacebookAction(_ sender: Any)
    {
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

//        var email: String  = ""
//       let  email =  UserDefaults.standard.object(forKey: "email") as! String
//       
//        if email.count > 0
//        {
//            txtemail.text =  email
//        }
        // Do any additional setup after loading the view.
    }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField .resignFirstResponder()
    }
   func loginMethod(){
                    
        //[SVProgressHUD show];
        //SVProgressHUD.show()
       hud = MBProgressHUD.showAdded(to: self.view, animated: true)

       hud.labelText = ""

    
   let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":txtemail.text!,"input3":txtpassword.text!] as [String : Any]
        //let verify_param = ["storedProcedureName": "sp_Login","input1":"Email","input2":"mehul.raikundalia@gmail.com","input3":"StrongSeparateWell"] as [String : Any]
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
                        
                        
                       // var string = String()
                        //string = skippedArray.value(forKey: "register_id") as! String
//                        let encoded = NSKeyedArchiver.archivedData(withRootObject: "register_id")
//                        UserDefaults.standard.set(encoded, forKey: "encodedData")
//                        var stringvalue:String = ""
//                        stringvalue = skippedArray.value(forKeyPath: "returnV") as! String
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
                                self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                            }
                        }
                        else
                        {
                            UserDefaults.standard.set(skippedArray.value(forKeyPath: "register_id"), forKey: "registerid")
                                                                                 //Integer
                     let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
                        self.navigationController?.pushViewController(login!, animated: true)
                            
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
extension UIView {
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
}
