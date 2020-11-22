//
//  FootBallGroupSettingsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import  Alamofire
import Reachability
class FootBallGroupSettingsVC: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate , NIDropDownDelegate{
    class NetworkState
    {
        class func isConnected() ->Bool
        {
            return NetworkReachabilityManager()!.isReachable
        }
    }
    var btndropdown = NIDropDown ()
    var hud : MBProgressHUD!
    var btnallowplay:String = ""

    @IBOutlet var lblminimumvotestxt: UILabel!
    @IBOutlet var minimumbtnvotesConstant: NSLayoutConstraint!
    @IBOutlet var minimumarrow: UIImageView!
    @IBOutlet var minimumvotelblheighcon: NSLayoutConstraint!
    @IBAction func allowiplayswtich(_ sender: Any) {
        
      let value = allowplayswitch.isOn
      if value == true
      {
       
       btnallowplay = "0"
        lblminimumvotestxt.text = "Minimum Games to get stats"
        minimumarrow.isHidden = false
        minimumvotelblheighcon.constant = 20
        minimumbtnvotesConstant.constant = 45
        btnminimumvotes.setTitle("5", for: .normal)
         //self.Updatebasicsetting()
          
      }
      else{
          btnallowplay = "1"
         lblminimumvotestxt.text = ""
        minimumarrow.isHidden = true
              minimumvotelblheighcon.constant = 0
              minimumbtnvotesConstant.constant = 0
          //self.Updatebasicsetting()
      }
    }
    @IBOutlet var allowplayswitch: UISwitch!
    @IBOutlet var btnmanofswitch: UISwitch!
    
    @IBOutlet var btnallow: UIButton!
    @IBAction func btnsaveAction(_ sender: Any) {
        self.UpdateGroupsettings()
        
    }
    @IBOutlet var btnsave: UIButton!
    
    @IBOutlet var btndelegroup: UIButton!
     var btnvalue:String = ""
       var imagePicker = UIImagePickerController()
    
    
    @IBAction func defaultgamesAction(_ sender: Any) {
        if btndropdown.isDescendant(of: self.view)
        {
                                      //myView is subview of self.view, remove it.
         btndropdown.removeFromSuperview()
      }
      else
      {
        let myFloatForR = 250
          var r = CGFloat(myFloatForR)
         // lazy var value: Float = 200
          btndropdown.isHidden = false
          btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (defaultgamArray.value(forKey: "GameTypes") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
          btndropdown.setDropDownSelectionColor(UIColor.gray)
          btndropdown.delegate = self
             btndropdown.tag = 0
        }
    }
    @IBAction func minimumgamesAction(_ sender: Any) {
        if btndropdown.isDescendant(of: self.view)
        {
                                      //myView is subview of self.view, remove it.
         btndropdown.removeFromSuperview()
      }
      else
      {
        let myFloatForR = 250
                      var r = CGFloat(myFloatForR)
                     // lazy var value: Float = 200
                      btndropdown.isHidden = false
                      btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (maxmumgamesArray.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                      btndropdown.setDropDownSelectionColor(UIColor.gray)
                      btndropdown.delegate = self
                         btndropdown.tag = 1
        }
    }
    
    @IBAction func minvotesAction(_ sender: Any)
    {
        if btndropdown.isDescendant(of: self.view)
        {
                                      //myView is subview of self.view, remove it.
             btndropdown.removeFromSuperview()
          }
          else
          {
        let myFloatForR = 250
                      var r = CGFloat(myFloatForR)
                     // lazy var value: Float = 200
                      btndropdown.isHidden = false
                      btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (votesarray.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                      btndropdown.setDropDownSelectionColor(UIColor.gray)
                      btndropdown.delegate = self
                         btndropdown.tag = 2
        }
    }
    
    @IBAction func btncamAction(_ sender: Any)
    {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction1 = UIAlertAction(title: "ResetIcon", style: UIAlertAction.Style.default)
        {
           UIAlertAction in
           self.openCamera()
        }
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
            {
               UIAlertAction in
               self.openCamera()
            }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default)
            {
               UIAlertAction in
               self.openGallary()
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            {
               UIAlertAction in
            }

           // Add the actions
        imagePicker.delegate = self
            alert.addAction(cameraAction1)
            alert.addAction(cameraAction)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
           
        self.present(alert, animated: true, completion: nil)
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//                   print("Button capture")
//
//                   imagePicker.delegate = self
//                   imagePicker.sourceType = .savedPhotosAlbum
//                   imagePicker.allowsEditing = false
//
//                   present(imagePicker, animated: true, completion: nil)
//               }
    }
    
    @IBAction func btndelaction(_ sender: Any)
    {
        self.showSimpleAlert()
    }
  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

             // var image : UIImage!

              if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
              {
                profileimage.image  = img.resized(withPercentage: 0.1)
//                let image = UIImage(data: try! Data(contentsOf: URL(string:"http://i.stack.imgur.com/Xs4RX.jpg")!))!
//
//                let thumb1 = image.resized(withPercentage: 0.1)
//                let thumb2 = image.resized(toWidth: 72.0)
                 self.uploadprofilepicture()

              }
              else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
              {
                profileimage.image = image.resized(withPercentage: 0.1)
                self.uploadprofilepicture()
                  }


              picker.dismiss(animated: true,completion: nil)
       }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var btngroupnum: UIButton!
    
    @IBOutlet var btngroupname: UIButton!
   
    @IBOutlet var btngrouppassword: UIButton!
    
    @IBOutlet var btnselectminimumgames: UIButton!
    @IBOutlet var profileimage: UIImageView!
    
    @IBOutlet var btndefaultgames: UIButton!
    
    @IBOutlet var btnminimumvotes: UIButton!
    
    @IBOutlet var btnmanofmatch: UIButton!
    var manofmatch: String = ""
    @IBAction func switchmanofAction(_ sender: Any)
    {
        let value = btnmanofswitch.isOn
               if value == true
               {
                
                manofmatch = "0"
                  //self.Updatebasicsetting()
                   
               }
               else{
                   manofmatch = "1"
                   //self.Updatebasicsetting()
               }
    }
    
     var votesarray = NSMutableArray()
    var defaultgamArray = NSMutableArray()
    var maxmumgamesArray = NSMutableArray()
    
    
    // MARK: view didload/////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        btndefaultgames.clipsToBounds = true
               btndefaultgames.layer.cornerRadius = 2
        btndefaultgames.layer.borderColor = UIColor.black.cgColor
               btndefaultgames.layer.borderWidth = 1
        
               btnminimumvotes.clipsToBounds = true
                  btnminimumvotes.layer.cornerRadius = 2
                  btnminimumvotes.layer.borderColor = UIColor.black.cgColor
                  btnminimumvotes.layer.borderWidth = 1
    
                btnmanofmatch.clipsToBounds = true
              btnmanofmatch.layer.cornerRadius = 2
              btnmanofmatch.layer.borderColor = UIColor.black.cgColor
              btnmanofmatch.layer.borderWidth = 1

                btngroupnum.clipsToBounds = true
              btngroupnum.layer.cornerRadius = 2
              btngroupnum.layer.borderColor = UIColor.black.cgColor
              btngroupnum.layer.borderWidth = 1

        
                btngroupname.clipsToBounds = true
                 btngroupname.layer.cornerRadius = 2
                 btngroupname.layer.borderColor = UIColor.black.cgColor
                 btngroupname.layer.borderWidth = 1
        
         btngrouppassword.clipsToBounds = true
          btngrouppassword.layer.cornerRadius = 2
          btngrouppassword.layer.borderColor = UIColor.black.cgColor
          btngrouppassword.layer.borderWidth = 1
        
               btnselectminimumgames.clipsToBounds = true
                btnselectminimumgames.layer.cornerRadius = 2
                btnselectminimumgames.layer.borderColor = UIColor.black.cgColor
                btnselectminimumgames.layer.borderWidth = 1
           btndelegroup.clipsToBounds = true
           btndelegroup.layer.cornerRadius = 2
           btndelegroup.layer.borderColor = UIColor.black.cgColor
           btndelegroup.layer.borderWidth = 1
           btnsave.clipsToBounds = true
            btnsave.layer.cornerRadius = 22
              
        profileimage.clipsToBounds = true
        profileimage.layer.cornerRadius = profileimage.frame.width/2
        self.GroupSettingcall()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
       let alert = UIAlertController(title: "", message: "No Camera", preferredStyle: .actionSheet)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
             print("User click Approve button")
         }))
       
         self.present(alert, animated: true, completion: {
             print("completion block")
         })
        }
    }
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.delegate = self
          imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    func showSimpleAlert()
       {
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurVisualEffectView.alpha = 0.5
           let alert = UIAlertController(title: "Delete My Account", message: "Are you sure do u want to delete your account?",         preferredStyle: UIAlertController.Style.alert)
        if let subview = alert.view.subviews.first, let actionSheet = subview.subviews.first {
        for innerView in actionSheet.subviews {
            innerView.backgroundColor = .white
            innerView.layer.cornerRadius = 15.0
            innerView.clipsToBounds = true
            innerView.layer.borderColor = UIColor.black.cgColor
            innerView.layer.borderWidth = 1
        }
                }
           alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            blurVisualEffectView.removeFromSuperview()

                  //Cancel Action
              }))
              alert.addAction(UIAlertAction(title: "Delete",
                                            style: UIAlertAction.Style.default,
                                            handler: {(_: UIAlertAction!) in
            blurVisualEffectView.removeFromSuperview()

            self.DeleteAction()
              }))
         alert.view.tintColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 141.0/255.0, alpha: 1)
        self.view.addSubview(blurVisualEffectView)
        self.present(alert, animated: true, completion: nil)
          }
    
  
    
     func niDropDownDelegateMethod(_ sender: NIDropDown!) {
           
       }
       
       func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
       {
          
        if btndropdown.tag == 0
        {
             btndefaultgames.setTitle(title, for: .normal)
        }
         else if btndropdown.tag == 1
        {
             btnselectminimumgames.setTitle(title, for: .normal)
        }
           
        else if btndropdown.tag == 2
               {
                btnminimumvotes.setTitle(title, for: .normal)
               }// btndateofmatich.setTitle(title, for: .normal)
           //self.GroupsCall()
                  
       }
       
       func niDropDownHidden(_ sender: NIDropDown!)
       {
          
           btndropdown.isHidden = true
       }
    
    // MARK: Api Call /////////////////
      func GroupSettingcall()
                {
        if NetworkState.isConnected()
                {
                 hud = MBProgressHUD.showAdded(to: self.view, animated: true)

             hud.labelText = ""
     let str2 =  UserDefaults.standard.object(forKey: "registerid")
        let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
     let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"getDatabaseGroupSetting","input1":str2 as Any ,"input2":btnvalue] as [String : Any]
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
                
                if stringvalue ==  "Failure"
                {
                    var skippedArray = NSMutableArray()
                       skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                    let dataarray = skippedArray.firstObject as! NSDictionary
                            var stringvalue:String = ""
                            stringvalue = dataarray.value(forKey:"ErrorDescription") as! String
                            DispatchQueue.main.async{
                
                // self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                        self.showAlert(message: stringvalue)
                            }
                }
                else
                {
                    var skippedArray = NSMutableArray()
             skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
               self.votesarray = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
               self.defaultgamArray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
               self.maxmumgamesArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                  
             let dataarray = skippedArray.firstObject as! NSDictionary
               
               
                if let partname = dataarray.value(forKey: "database_name") as? String
              {
               self.btngroupname.setTitle(partname, for: .normal)
               
               }
               if let partname = dataarray.value(forKey: "database_number") as? String
                {
                   self.btngroupnum.setTitle(partname, for: .normal)
                 }
               if let partname = dataarray.value(forKey: "database_password") as? String
                {
                   self.btngrouppassword.setTitle(partname, for: .normal)
                 }
               if let partname = dataarray.value(forKey: "defaultGamesSetting") as? String
                {
                   self.btndefaultgames.setTitle(partname, for: .normal)
                 }
               if let partname = dataarray.value(forKey: "minGamesForStats") as? String
               {
                   
                   self.btnselectminimumgames.setTitle(partname, for: .normal)
                 
                 }
                }
           
                   }
                 }
        
                }
                    
               }
               else
           {
            self.showAlert(message: "Please Check Your Internet")
               }
                
                  }
    
    func DeleteAction()
          {
                                 
            if NetworkState.isConnected()
            {
                hud = MBProgressHUD.showAdded(to: self.view, animated: true)

              hud.labelText = ""
          let str2 =  UserDefaults.standard.object(forKey: "registerid")
        let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

          let verify_param = ["sessionID":sessionid as Any,"storedProcedureName": "sp_drop_database","input1":str2 as Any,"input2":"0"] as [String : Any]
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
                  //let dataarray = skippedArray.firstObject as! NSDictionary
                            
              var stringvalue:String = ""
              stringvalue = jsonResponse["status"] as! String
           
              if stringvalue == "Failure"
              {
                  let dataarray = skippedArray.firstObject as! NSDictionary
                                             
                  var stringvalue:String = ""
                  stringvalue = dataarray.value(forKey:"Update") as! String
                  DispatchQueue.main.async{

                    self.showAlert(message: stringvalue)

                  }
                
              }
                  else
              {
            let dataarray = skippedArray.firstObject as! NSDictionary
           var stringvalue:String = ""
           stringvalue = dataarray.value(forKey:"Update") as! String
              DispatchQueue.main.async{
             //self.showToast(message: stringvalue, font: UIFont.systemFont(ofSize: 12))
                self.showAlert(message: stringvalue)
                            }
                             }
                            //}
                          
                        }
                       }
                }
            }
            else
            {
                
            }
                  
    
    }
   //MARK: //// Api Call////////////////////
    func UpdateGroupsettings()
                  {
                    //SVProgressHUD.show()
        if  NetworkState.isConnected()
        {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

    hud.labelText = ""
    
      let str2 =  UserDefaults.standard.object(forKey: "registerid")
            let mom = Int(btnallowplay)
     let manof = Int(manofmatch)
            let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")

    let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"UpdateDatabaseGroupSetting","input1":str2 as Any ,"input2":btngroupnum.currentTitle!,"input3":btngroupname.currentTitle!,"input4":btnselectminimumgames.currentTitle!,"input5":btndefaultgames.currentTitle!,"input6":mom as Any,"input7":btnminimumvotes.currentTitle!,"input8":manof as Any] as [String : Any]
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
              
              var skippedArray = NSMutableArray()
            skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
              self.votesarray = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
              self.defaultgamArray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
              self.maxmumgamesArray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
            //let dataarray = skippedArray.firstObject as! NSDictionary

              
              
            }
          }
         }
        }
      else
        {
            self.showAlert(message: "Please check your Internet")
        }
                    
        }
   
    func uploadprofilepicture()
        
    {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

            hud.labelText = ""
           //let str2 =  UserDefaults.standard.object(forKey: "registerid")
        var imagestring = NSString()
        imagestring = self.convertImageToBase64String(image: profileimage.image!) as NSString
                        //String(UserDefaults.standard.integer(forKey: "registerid"))
        //let myInt3 = (str2 as! NSString).integerValue
        //let myInt3 = Int(str2) ?? 0
         //var value: Int { string.digits.integer ?? 0 }
        //let myInt3 = (str2 as! NSString).integerValue
        let verify_param = ["storedProcedureName":"updateDatabasePicture","input1":btnvalue ,"input2":imagestring] as [String : Any]
                        let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                           AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                              response in
                            //  SVProgressHUD.dismiss()
                           if let json = response.value
                           {
                      let jsonResponse = json as! NSDictionary
                          print(jsonResponse)
                            DispatchQueue.main.async{

                                           self.hud.hide(true)

                                           }
                           do
                           {
                            

                          }
                        }
                       }
       
        }
    func  convertImageToBase64String(image : UIImage ) -> String
       {
           let strBase64 =  image.pngData()?.base64EncodedString()
           return strBase64!
       }
      
}
extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
