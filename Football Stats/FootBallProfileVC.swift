//
//  FootBallProfileVC.swift
//  Football Stats
//
//  Created by Chakri on 15/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown

class FootBallProfileVC: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate , DKDropMenuDelegate , NIDropDownDelegate
{
    func niDropDownDelegateMethod(_ sender: NIDropDown!) {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
        if btndropdown.tag == 1
        {
            btnteamsupport.setTitle(title, for:.normal)
        }
        else if btndropdown.tag == 0
        {
        btngender.setTitle(title, for: .normal)
        }
        else if btndropdown.tag == 2
               {
               btndatabse.setTitle(title, for: .normal)
               }
    }
    
    func niDropDownHidden(_ sender: NIDropDown!)
    {
       
        btndropdown.isHidden = true
    }
    
    @IBAction func databaseAction(_ sender: Any) {
        let myFloatForR = 250
               var r = CGFloat(myFloatForR)
              // lazy var value: Float = 200
               btndropdown.isHidden = false
               btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (database.value(forKey: "database_name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
               btndropdown.setDropDownSelectionColor(UIColor.gray)
               btndropdown.delegate = self
                  btndropdown.tag = 2
    }
    
    
    @IBOutlet var lbldatabaseheightcon: NSLayoutConstraint!
    
    var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
  
    var btndropdown = NIDropDown ()
    
    @IBOutlet var innerview: UIView!
    
    @IBOutlet var defaultdatabase1: UILabel!
    
    @IBOutlet var defaultdatbaseheightCon: NSLayoutConstraint!
    
    @IBOutlet var defaultdatabasearrowimage: UIImageView!
    
    var hud : MBProgressHUD!

    @IBOutlet var btnnext: UIButton!
    @IBOutlet var btndatabse: UIButton!
    
    @IBAction func btnActionteamsupport(_ sender: Any)
    {
        let myFloatForR = 250
               var r = CGFloat(myFloatForR)
              // lazy var value: Float = 200
               btndropdown.isHidden = false
               btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (teamsupport.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
               btndropdown.setDropDownSelectionColor(UIColor.gray)
               btndropdown.delegate = self
        btndropdown.tag = 1
    }
    
    @IBAction func btngenderAction(_ sender: Any)
    {
//       dkdropdown.add(names: ["hello", "goodbye", "why?"])
//              dkdropdown.delegate = self
        
        //var f =  CGFloat()
       // f = 200
    //btndropdown = NIDropDown.show(sender, theHeight: &f, theArr: menu, theImgArr: nil, theDirection: "down", withViewController: self)
        let myFloatForR = 100
        var r = CGFloat(myFloatForR)
       // lazy var value: Float = 200
        btndropdown.isHidden = false
        btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (genderarray.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
        btndropdown.setDropDownSelectionColor(UIColor.gray)
        btndropdown.delegate = self
        btndropdown.tag = 0
//          if(btn == nil) {
//                CGFloat f = 200;
//                dropDown1 = [[NIDropDown alloc]showDropDown:sender theHeight:&f theArr:arr theImgArr:arrImage theDirection:@"down" withViewController:self];
//                [dropDown1 setDropDownSelectionColor:[UIColor grayColor]];
//                dropDown1.delegate = self;
//            }
//            else {
//                [dropDown1 hideDropDown:sender];
//        //        [self rel];
//            }
           
    }
    @IBAction func btnnextAction(_ sender: Any)
    {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                hud.labelText = "Loading..."
           let str2 =  UserDefaults.standard.object(forKey: "registerid")
        //let myInt3 = (str2 as! NSString).integerValue

       // var imagestring = NSString()
       // imagestring = self.convertImageToBase64String(image: profileimage.image!) as NSString
                        //String(UserDefaults.standard.integer(forKey: "registerid"))
        let verify_param = ["storedProcedureName":"sp_updatePlayerProfile","input1":str2 as Any,"input2":txtfirstname.text!,"input3":txtsurname.text!,"input4":txtmobileno.text!,"input5":txtdateofbirth.text!,"input6":btngender.currentTitle!,"input7":btnteamsupport.currentTitle!,"input8":btndatabse.currentTitle!] as [String : Any]
                        let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                           AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
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
                            
//                            let login: FootBallMainSegmentVC? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallMainSegmentVC") as! FootBallMainSegmentVC)
//                login?.text = "Profile"
//
//                self.navigationController?.pushViewController(login!, animated: true)
                                    
//                              UserDefaults.standard.set(jsonResponse.object(forKey: "register_id"), forKey: "registerid")
//                            var skippedArray = NSMutableArray()
//                            skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
//
//                            let dataarray = skippedArray.firstObject as! NSDictionary
//                            self.txtname.text = (dataarray.value(forKey: "emailadd") as! String)
//                              self.txtfirstname.text = (dataarray.value(forKey: "firstName") as! String)
//                            self.txtsurname.text = (dataarray.value(forKey: "surName") as! String)
//                            self.btnteamsupport.setTitle((dataarray.value(forKey: "team_supported") as! String), for: .normal)
//                            self.txtdateofbirth .text = (dataarray.value(forKey: "dob") as! String)
//                            self.txtmobileno.text = (dataarray.value(forKey: "mobilenumber") as! String)
                            //self.genderarray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                      
                            //Integer
//                              let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
//                                 self.navigationController?.pushViewController(login!, animated: true)
                          }
                        }
                       }

        
    }
    
    
     func  convertImageToBase64String(image : UIImage ) -> String
    {
        let strBase64 =  image.pngData()?.base64EncodedString()
        return strBase64!
    }
   
    var imagePicker = UIImagePickerController()

    @IBAction func btncameraaction(_ sender: Any)
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
            alert.addAction(cameraAction)
           alert.addAction(cameraAction1)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet var profileimage: UIImageView!
    
    @IBOutlet var txtname: UITextField!
    
    @IBOutlet var txtfirstname: UITextField!
    
    
    @IBOutlet var txtsurname: UITextField!
    
    @IBOutlet var txtdateofbirth: UITextField!
    
    @IBOutlet var txtmobileno: UITextField!
    
    @IBOutlet var btngender: UIButton!
    
    
    @IBOutlet var btnteamsupport: UIButton!
    
    var genderarray = NSMutableArray()
    var teamsupport = NSMutableArray()
    var database = NSMutableArray ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Default Database
        self.Profilecall()
        btndatabse.clipsToBounds = true
        btndatabse.layer.borderColor = UIColor.darkGray.cgColor
        btndatabse.layer.borderWidth = 1
        btngender.layer.borderColor = UIColor.darkGray.cgColor
              btngender.layer.borderWidth = 1
        btnteamsupport.layer.borderColor = UIColor.darkGray.cgColor
        btnteamsupport.layer.borderWidth = 1
        profileimage.layer.cornerRadius = profileimage.frame.size.width/2
        profileimage.clipsToBounds = true
        btnnext.clipsToBounds = true
        btnnext.layer.cornerRadius = 22
  
//        genderdropdown.optionArray = ["Option 1", "Option 2", "Option 3"]
//        //Its Id Values and its optional
//        genderdropdown.optionIds = [1,23,54,22]
//
//        // Image Array its optional
//        //dropDown.ImageArray = [👩🏻‍🦳,🙊,🥞]
//        // The the Closure returns Selected Index and String
//        genderdropdown.didSelect{(selectedText , index ,id) in
//        self.genderdropdown.text = "Selected String: \(selectedText) \n index: \(index)"
//        // Do any additional setup after loading the view.
//    }
    }
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

          // var image : UIImage!

           if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
           {
               profileimage.image  = img

           }
           else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                   profileimage.image = image
               }

        self.uploadprofile()
           picker.dismiss(animated: true,completion: nil)
    }
    func Profilecall()
        {

            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                hud.labelText = "Loading..."
          //SVProgressHUD.show()
//            var string = String.self
//            string = UserDefaults.standard.integer(forKey: "registerid")
            let str2 =  UserDefaults.standard.object(forKey: "registerid")
                    
                //String(UserDefaults.standard.integer(forKey: "registerid"))
            let verify_param = ["storedProcedureName":"getMyProfile","input1":str2 as Any] as [String : Any]
                let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                   AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
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
                      //UserDefaults.standard.set(jsonResponse.object(forKey: "register_id"), forKey: "registerid")
                    var skippedArray = NSMutableArray()
                    skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                
                    let dataarray = skippedArray.firstObject as! NSDictionary
                    self.txtname.text = (dataarray.value(forKey: "emailadd") as! String)
                      self.txtfirstname.text = (dataarray.value(forKey: "firstName") as! String)
                    self.txtsurname.text = (dataarray.value(forKey: "surName") as! String)
                    self.btnteamsupport.setTitle((dataarray.value(forKey: "team_supported") as! String), for: .normal)
                    self.txtdateofbirth .text = (dataarray.value(forKey: "dob") as! String)
                    self.txtmobileno.text = (dataarray.value(forKey: "mobilenumber") as! String)
                    self.btngender.setTitle((dataarray.value(forKey: "sex") as! String), for: .normal)
                    
                    DispatchQueue.main.async{
                        if let partname = dataarray.value(forKey: "playerPicture") as? String
                            {
                                if partname.count>0
                                {
                                    let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                               let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                               print(decodedimage)
                               self.profileimage.image = decodedimage
                                }
                         
                        
                            }
                            }
                   // var genderarray = NSMutableArray()
                    
                    self.genderarray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                     self.teamsupport = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
                    self.database = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                    
                    if self.database.count>0
                    {
                        self.lbldatabaseheightcon.constant = 20
                        self.btndatabse.isHidden = false
                        self.defaultdatabasearrowimage.isHidden = false
                      //  UserDefaults.standard.array(dataarray, forKey:"databasearray")

                        
                    }
                    else
                    {
                        self.lbldatabaseheightcon.constant = 0
                        self.btndatabse.isHidden = true
                        self.defaultdatabasearrowimage.isHidden = true
                    }

                    //Integer
//                      let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
//                         self.navigationController?.pushViewController(login!, animated: true)
                  }
                }
               }
          
          }
    // MARK: DKDropMenuDelegate
    func itemSelected(withIndex: Int, name: String)
    {
        print("\(name) selected");
        //let String  = NSString ()
    //String = name
        btngender.setTitle(name, for: .normal)
    }
func uploadprofile()
    
{
    hud = MBProgressHUD.showAdded(to: self.view, animated: true)

        hud.labelText = "Loading..."
       let str2 =  UserDefaults.standard.object(forKey: "registerid")
    var imagestring = NSString()
    imagestring = self.convertImageToBase64String(image: profileimage.image!) as NSString
                    //String(UserDefaults.standard.integer(forKey: "registerid"))
    //let myInt3 = (str2 as! NSString).integerValue
    //let myInt3 = Int(str2) ?? 0
     //var value: Int { string.digits.integer ?? 0 }
    //let myInt3 = (str2 as! NSString).integerValue
    let verify_param = ["storedProcedureName":"updateProfilePicture","input1":str2 as Any ,"input2":imagestring] as [String : Any]
                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                       AF.request("http://868de1a00561.ngrok.io/api/FootBall/APIExecute?", method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
