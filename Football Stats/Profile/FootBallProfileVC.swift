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
import FSCalendar
import D2PDatePicker
import Reachability


class FootBallProfileVC: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate , DKDropMenuDelegate , NIDropDownDelegate , UITextFieldDelegate, FSCalendarDataSource, FSCalendarDelegate, D2PDatePickerDelegate
{
    class NetworkState
       {
         class func isConnected() ->Bool
         {
             return NetworkReachabilityManager()!.isReachable
         }
       }
    func didChange(toDate date: Date)
    {
        print(date)
        datePickerView.removeFromSuperview()
    }
    
    
     var datePickerView: D2PDatePicker!
    @IBOutlet var btndob: UIButton!
    @IBOutlet var FsCalendarview: FSCalendar!
      var picker : UIDatePicker = UIDatePicker()
    @IBOutlet var lbldefaultdatabase: UILabel!
    var blurEffect = UIBlurEffect()
    var blurEffectView = UIVisualEffectView ()
    func niDropDownDelegateMethod(_ sender: NIDropDown!)
    {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
        if btndropdown.tag == 1
        {
            btnnext.setTitle("Save", for: .normal)
            btnteamsupport.setTitle(title, for:.normal)
        }
        else if btndropdown1.tag == 99
        {
            btnnext.setTitle("Save", for: .normal)
             btngender.setTitle(title, for: .normal)
        }
        else if btndropdown.tag == 2
       {
        btnnext.setTitle("Save", for: .normal)
       btndatabse.setTitle(title, for: .normal)
       }
    }
    
    func niDropDownHidden(_ sender: NIDropDown!)
    {
       
        btndropdown.isHidden = true
    }
    
    @IBAction func databaseAction(_ sender: Any)
    {
        if btndropdown.isDescendant(of: self.view) {
                         //myView is subview of self.view, remove it.
                        btndropdown.removeFromSuperview()
                     }
                     else
                     {
        let myFloatForR = 250
               var r = CGFloat(myFloatForR)
              // lazy var value: Float = 200
               btndropdown.isHidden = false
               btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (database.value(forKey: "database_name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
               btndropdown.setDropDownSelectionColor(UIColor.gray)
               btndropdown.delegate = self
                  btndropdown.tag = 2
        }
    }
    
    
    @IBAction func btndateofAction(_ sender: Any)
    {
        
        txtsurname.resignFirstResponder()
        txtfirstname.resignFirstResponder()
        txtmobileno.resignFirstResponder()
     
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.clipsToBounds = true;
        picker.layer.cornerRadius = 20;
        picker.layer.borderWidth = 1;
        picker.layer.borderColor =  UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 44.0/255.0, alpha: 1).cgColor
        picker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: UIControl.Event.valueChanged)
         let pickerSize : CGSize = picker.sizeThatFits(CGSize.zero)
         picker.frame = CGRect(x:30.0, y:230, width:pickerSize.width, height:300)
         // you probably don't want to set background color as black
        picker.backgroundColor = UIColor.white
        let myFirstButton = UIButton()

        myFirstButton.setTitle("Done", for: .normal)
        myFirstButton.setTitleColor(UIColor.blue, for: .normal)
        myFirstButton.frame = CGRect(x: 15, y: picker.frame.size.height+20, width: 100, height: 40)
        myFirstButton.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        picker.addSubview(myFirstButton)
        self.view.addSubview(picker)
        // Init DatePickerView
        
    }
    @objc func pressed(sender: UIButton!)
    {
        var alertView = UIAlertView()
        alertView.addButton(withTitle: "Ok")
        alertView.title = "title"
        alertView.message = "message"
        alertView.show()
    }
 @objc func dueDateChanged(sender:UIDatePicker)
 {
       let dateFormatter = DateFormatter()
    //dateFormatter.dateFormat = "dd MMM yyyy"
    dateFormatter.dateFormat = "dd-MM-yyyy"
    let strDate = dateFormatter.string(from: sender.date)
    txtdateofbirth.text = String(strDate)
  // btndob.setTitle(dateFormatter.string(from: sender.date), for: .normal)
     btnnext.setTitle("Save", for: .normal)
    picker.removeFromSuperview()
   }
    
    @IBOutlet var lbldatabaseheightcon: NSLayoutConstraint!
    
    var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
  
    var btndropdown = NIDropDown ()
     var btndropdown1 = NIDropDown ()
    @IBOutlet var innerview: UIView!
    
    @IBOutlet var defaultdatabase1: UILabel!
    
    @IBOutlet var defaultdatbaseheightCon: NSLayoutConstraint!
    
    @IBOutlet var defaultdatabasearrowimage: UIImageView!
    
    var hud : MBProgressHUD!

    @IBOutlet var btnnext: UIButton!
    @IBOutlet var btndatabse: UIButton!
    
    @IBAction func btnActionteamsupport(_ sender: Any)
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
               btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (teamsupport.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
               btndropdown.setDropDownSelectionColor(UIColor.gray)
               btndropdown.delegate = self
        btndropdown.tag = 1
        }
    }
    
    @IBAction func btngenderAction(_ sender: Any)
    {
         btndropdown.removeFromSuperview()
        if btndropdown1.isDescendant(of: self.view) {
            //myView is subview of self.view, remove it.
            btndropdown1.removeFromSuperview()
        } 
        else
        {
            //myView is not subview of self.view, add it.
                  let myFloatForR = 100
                       var r = CGFloat(myFloatForR)
                      // lazy var value: Float = 200
                       btndropdown1.isHidden = false
                       btndropdown1.show((sender as! UIButton), theHeight: &r, theArr: (genderarray.value(forKey: "valueList") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
                       btndropdown1.setDropDownSelectionColor(UIColor.gray)
            
                       btndropdown1.delegate = self
                    btndropdown1.tag = 99
        }
        
           
    }
    @IBAction func btnnextAction(_ sender: Any)
    {
        
        if btnnext.currentTitle == "Next"
        {
        let login: FootBallMainSegmentVC? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallMainSegmentVC") as! FootBallMainSegmentVC)
        login?.text = "Profile"
        self.navigationController?.pushViewController(login!, animated: true)
        }
        else
        {
             hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                            hud.labelText = ""
                       let str2 =  UserDefaults.standard.object(forKey: "registerid")
                    //let myInt3 = (str2 as! NSString).integerValue

                    var imagestring = NSString()
                    if btndatabse.currentTitle == "Default Database"
                    {
                        imagestring = ""
                    }
                    else
                    {
                        imagestring = btndatabse.currentTitle! as NSString
                    }
                         let inputFormatter = DateFormatter()
                           inputFormatter.dateFormat = "dd-MM-yyyy"
                           let showDate = inputFormatter.date(from: txtdateofbirth.text!)
                           inputFormatter.dateFormat = "yyyy-MM-dd"
                           let resultString = inputFormatter.string(from: showDate!)
            
                   // imagestring = self.convertImageToBase64String(image: profileimage.image!) as NSString
                                    //String(UserDefaults.standard.integer(forKey: "registerid"))
                    let verify_param = ["storedProcedureName":"sp_updatePlayerProfile","input1":str2 as Any,"input2":txtfirstname.text!,"input3":txtsurname.text!,"input4":txtmobileno.text!,"input5":resultString ,"input6":btngender.currentTitle!,"input7":btnteamsupport.currentTitle!,"input8":imagestring] as [String : Any]
                                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                                       AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                                          response in
                                        //  SVProgressHUD.dismiss()
                                       if let json = response.value
                                       {
                                  let jsonResponse = json as! NSDictionary
                                      print(jsonResponse)
                                        DispatchQueue.main.async{
                                            self.btnnext.setTitle("Next", for: .normal)
                                                       self.hud.hide(true)

                                                       }
                                       do
                                       {
                                        

                                                
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
            //        self.navigationController?.pushViewController(login!, animated: true)
                                      }
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
        let ResetAction = UIAlertAction(title: "ResetIcon", style: UIAlertAction.Style.default)
        {
           UIAlertAction in
            self.profileimage.image = UIImage.init(named: "download-1")
            self.uploadprofile()
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
           alert.addAction(ResetAction)
            alert.addAction(cameraAction)
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
    
    
    // MARK: View DidLoad //////////////////////////////
    override func viewDidLoad()
    {
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
        btnnext.layer.cornerRadius = btnnext.frame.size.width/2
        txtfirstname.delegate = self
        txtsurname.delegate = self
        txtmobileno.delegate = self
        txtname.delegate = self
        //let userdefaults = UserDefaults.standard
                // userdefaults.set("segmenu", forKey: "refer")
            // userdefaults.set("back", forKey: "back")
                   // userdefaults.synchronize()
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
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNumberPad)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        txtmobileno.inputAccessoryView = numberToolbar
    }
    @objc func cancelNumberPad() {
        //Cancel with number pad
        txtmobileno.resignFirstResponder()
    }
    @objc func doneWithNumberPad() {
        //Done with number pad
        txtmobileno.resignFirstResponder()

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

         //var image : UIImage!

           if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
           {
               //img = img.resized(withPercentage: 0.1)!
            profileimage.image  = img.resized(withPercentage: 0.1)
            
            
           }
           else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileimage.image = image.resized(withPercentage: 0.1)
               }

        self.uploadprofile()
           picker.dismiss(animated: true,completion: nil)
    }
   
    // MARK: DKDropMenuDelegate
    func itemSelected(withIndex: Int, name: String)
    {
        print("\(name) selected");
        //let String  = NSString ()
    //String = name
        btngender.setTitle(name, for: .normal)
    }
    // MARK: Api Call/////////////////////////////
func uploadprofile()
    
{
    if NetworkState.isConnected()
    {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

            hud.labelText = ""
           let str2 =  UserDefaults.standard.object(forKey: "registerid")
        let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
        var imagestring = NSString()
        imagestring = self.convertImageToBase64String(image: profileimage.image!) as NSString
                        //String(UserDefaults.standard.integer(forKey: "registerid"))
        //let myInt3 = (str2 as! NSString).integerValue
        //let myInt3 = Int(str2) ?? 0
         //var value: Int { string.digits.integer ?? 0 }
        //let myInt3 = (str2 as! NSString).integerValue
        let verify_param = ["sessionID":sessionid as Any,"storedProcedureName":"updateProfilePicture","input1":str2 as Any ,"input2":imagestring] as [String : Any]
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
    else
    {
        self.showAlert(message: GlobalConstants.internetmessage)
    }
    
   
    }
     func Profilecall()
            {

        if NetworkState.isConnected()
        {
           hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                           hud.labelText = ""
                
                       let str2 =  UserDefaults.standard.object(forKey: "registerid")
                       let sessionid =  UserDefaults.standard.object(forKey: "Sessionid")
                       let verify_param = ["sessionID" :sessionid as Any,"storedProcedureName":"getMyProfile","input1":str2 as Any] as [String : Any]
                           let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                              AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                                 response in
                               DispatchQueue.main.async{

                                   self.hud.hide(true)

                                   }
                              if let json = response.value
                              {
                         let jsonResponse = json as! NSDictionary
                             print(jsonResponse)
                              do
                              {
                           
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
                               self.btndatabse.setTitle((dataarray.value(forKey: "database_name") as! String), for: .normal)
                               let userdefaults = UserDefaults.standard
                                   // userdefaults.set("segmenu", forKey: "refer")
                                userdefaults.set((dataarray.value(forKey: "database_name") as! String), forKey: "database_name")
                                   userdefaults.synchronize()
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
                               
                               self.genderarray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                                self.teamsupport = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
                               self.database = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                               
                               if self.database.count>0
                               {
                                   self.lbldatabaseheightcon.constant = 20
                                   self.btndatabse.isHidden = false
                                   self.defaultdatabasearrowimage.isHidden = false
                                   self.lbldefaultdatabase.text = "Default Database"
                                   
                                 //  UserDefaults.standard.array(dataarray, forKey:"databasearray")

                                   
                               }
                               else
                               {
                                   self.lbldatabaseheightcon.constant = 0
                                   self.btndatabse.isHidden = true
                                   self.defaultdatabasearrowimage.isHidden = true
                                   self.btnnext.setTitle("Next", for: .normal)
                               }

                               //Integer
           //                      let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
           //                         self.navigationController?.pushViewController(login!, animated: true)
                             }
                           }
                          }
        }
        else
        {
             self.showAlert(message: GlobalConstants.internetmessage)
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
    // MARK:- UIGestureRecognizerDelegate
      
      fileprivate lazy var dateFormatter: DateFormatter =
      {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"
          return formatter
      }()
      
      func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool)
      {
         // self.calendarHeightConstraint.constant = bounds.height
          self.view.layoutIfNeeded()
      }
      
      func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
      {
          print("did select date \(self.dateFormatter.string(from: date))")
        
          let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        
        //let myStringafd = formatter.string(from: yourDate!)
           // self.stringvalue1 =
        DispatchQueue.main.async {
             UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
             self.FsCalendarview.frame = CGRect(x: 0, y: 1000 , width: self.view.frame.size.width, height: self.FsCalendarview.frame.size.height);
               

             self.FsCalendarview.transform = CGAffineTransform(translationX: 0, y: 0)

               }, completion: nil)
           }
        blurEffectView.removeFromSuperview()
        for recognizer in self.view.gestureRecognizers ?? [] {
            self.view.removeGestureRecognizer(recognizer)
        }
          print("selected dates is \(selectedDates)")
        //FsCalendarview.removeFromSuperview()
       // blurEffectView.removeFromSuperview()
        txtdateofbirth.text = String((self.dateFormatter.string(from: date)))
        //btndob.setTitle(  , for: .normal)
          if monthPosition == .next || monthPosition == .previous {
              calendar.setCurrentPage(date, animated: true)
          }
      }

      func calendarCurrentPageDidChange(_ calendar: FSCalendar)
      {
          print("\(self.dateFormatter.string(from: calendar.currentPage))")
        
      }
    
    // MARK: Text Field Delegates //////////////////////////////
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//
//             return true
//          }
        func textFieldDidBeginEditing(_textField: UITextField)
        {
            if _textField ==  txtsurname
            {
                btnnext.setTitle("Save", for: .normal)

            }
            if _textField == txtfirstname
               {

                btnnext.setTitle("Save", for: .normal)

                }
            if _textField == txtmobileno
            {

             btnnext.setTitle("Save", for: .normal)

             }
            
        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
        {
//            // return NO to disallow editing.
            if textField == txtfirstname
               {

             btnnext.setTitle("Save", for: .normal)

                }
            if textField == txtsurname
            {
                txtfirstname.resignFirstResponder()
       btnnext.setTitle("Save", for: .normal)
            }
            if textField == txtmobileno
                 {
                     txtfirstname.resignFirstResponder()
                    txtsurname.resignFirstResponder()
            btnnext.setTitle("Save", for: .normal)
                 }
            return true
        }

        func textFieldShouldEndEditing(_textField: UITextField!) -> Bool
        {  //delegate method
            
//            if _textField == txtemail
//            {
//                if txtemail.text?.count == 0
//                {
//                    txtemail.placeholder = "Example@Email.com"
//                }
//            }
            return false
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

//    if textField == txtemail
//    {
//        if txtemail.text?.count == 0
//        {
//            txtemail.placeholder = "Example@Email.com"
//        }
//        else if txtemail.text!.count > 0
//        {
//            txtemail.placeholder = "Email"
//        }
//
//            print("replacementString : \(string)")
//        }
            return true

        
        }
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField .resignFirstResponder()
        return true
    }
}
extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
extension ViewController: D2PDatePickerDelegate {
    
    func didChange(toDate date: Date) {
        print(date)
    }
    
}
