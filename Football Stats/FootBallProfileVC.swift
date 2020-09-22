//
//  FootBallProfileVC.swift
//  Football Stats
//
//  Created by Chakri on 15/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallProfileVC: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    
    @IBOutlet var defaultdatabase1: UILabel!
    
    @IBOutlet var defaultdatbaseheightCon: NSLayoutConstraint!
    
    @IBOutlet var defaultdatabasearrowimage: UIImageView!
    
    
    @IBOutlet var btnnext: UIButton!
    @IBOutlet var btndatabse: UIButton!
    
    
    @IBAction func btnnextAction(_ sender: Any)
    {
        
        let login: FootBallMainSegmentVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallMainSegmentVC") as! FootBallMainSegmentVC)
        login?.text = "Profile"

        self.navigationController?.pushViewController(login!, animated: true)
        
        
    }
    
    
    enum TabIndex : Int {
           case firstChildTab = 0
           case secondChildTab = 1
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Default Database
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
              
        // Do any additional setup after loading the view.
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


           picker.dismiss(animated: true,completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    imagePicker.dismiss(animated: true, completion: nil)
//    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//        profileimage.image = image
//    }
      
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
