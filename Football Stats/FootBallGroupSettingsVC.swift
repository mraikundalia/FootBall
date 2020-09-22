//
//  FootBallGroupSettingsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallGroupSettingsVC: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {

    @IBOutlet var btndelegroup: UIButton!
    
       var imagePicker = UIImagePickerController()
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
            alert.addAction(cameraAction)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
            alert.addAction(cameraAction1)
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
                  profileimage.image  = img

              }
              else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                      profileimage.image = image
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
    @IBAction func switchmanofAction(_ sender: Any)
    {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btndefaultgames.clipsToBounds = true
               btndefaultgames.layer.cornerRadius = 2
               btndefaultgames.layer.borderColor = UIColor.lightGray.cgColor
               btndefaultgames.layer.borderWidth = 1
        
               btnminimumvotes.clipsToBounds = true
                  btnminimumvotes.layer.cornerRadius = 2
                  btnminimumvotes.layer.borderColor = UIColor.lightGray.cgColor
                  btnminimumvotes.layer.borderWidth = 1
    
                btnmanofmatch.clipsToBounds = true
              btnmanofmatch.layer.cornerRadius = 2
              btnmanofmatch.layer.borderColor = UIColor.lightGray.cgColor
              btnmanofmatch.layer.borderWidth = 1

                btngroupnum.clipsToBounds = true
              btngroupnum.layer.cornerRadius = 2
              btngroupnum.layer.borderColor = UIColor.lightGray.cgColor
              btngroupnum.layer.borderWidth = 1

        
                btngroupname.clipsToBounds = true
                 btngroupname.layer.cornerRadius = 2
                 btngroupname.layer.borderColor = UIColor.lightGray.cgColor
                 btngroupname.layer.borderWidth = 1
        
         btngrouppassword.clipsToBounds = true
          btngrouppassword.layer.cornerRadius = 2
          btngrouppassword.layer.borderColor = UIColor.lightGray.cgColor
          btngrouppassword.layer.borderWidth = 1
        
               btnselectminimumgames.clipsToBounds = true
                btnselectminimumgames.layer.cornerRadius = 2
                btnselectminimumgames.layer.borderColor = UIColor.lightGray.cgColor
                btnselectminimumgames.layer.borderWidth = 1
           btndelegroup.clipsToBounds = true
           btndelegroup.layer.cornerRadius = 2
           btndelegroup.layer.borderColor = UIColor.lightGray.cgColor
           btndelegroup.layer.borderWidth = 1
        profileimage.clipsToBounds = true
        profileimage.layer.cornerRadius = profileimage.frame.width/2
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
           let alert = UIAlertController(title: "Delete My Account", message: "Are you sure do u want to delete your account?",         preferredStyle: UIAlertController.Style.alert)

           alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                  //Cancel Action
              }))
              alert.addAction(UIAlertAction(title: "Delete",
                                            style: UIAlertAction.Style.default,
                                            handler: {(_: UIAlertAction!) in
                                              //Sign out action
              }))
              self.present(alert, animated: true, completion: nil)
          }
}
