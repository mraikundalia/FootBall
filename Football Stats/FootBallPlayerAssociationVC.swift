//
//  FootBallPlayerAssociationVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallPlayerAssociationVC: UIViewController {

    
    @IBOutlet var borderview1: UIView!
    
    @IBOutlet var borderview2: UIView!
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btncheckAction2(_ sender: Any)
    {
    }
    @IBAction func btncheckAction1(_ sender: Any)
    {
        
    }
    
    @IBAction func btncheckAction3(_ sender: Any)
    {
        if (btncheck3.isSelected == true)
           {
            btncheck3.backgroundColor = UIColor.white

            btncheck3.isSelected = false;
           }
           else
           {
            btncheck3.backgroundColor = UIColor.red
          self.showSimpleAlert()
            btncheck3.isSelected = true;
           }
       
    }
    
    @IBOutlet var txtemail: UITextField!
    
    @IBOutlet var btncheck3: UIButton!
    @IBOutlet var txtplayerid: UITextField!
    @IBOutlet var textname: UITextField!
    @IBOutlet var txtgroupnickname: UITextField!
    @IBOutlet var btncheck2: UIButton!
    @IBOutlet var btncheck1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btncheck3.clipsToBounds = true
        btncheck3.layer.cornerRadius = 2
        btncheck3.layer.borderColor = UIColor.darkGray.cgColor
        btncheck3.layer.borderWidth = 1
        btncheck2.clipsToBounds = true
               btncheck2.layer.cornerRadius = 2
               btncheck2.layer.borderColor = UIColor.darkGray.cgColor
               btncheck2.layer.borderWidth = 1
         btncheck1.clipsToBounds = true
               btncheck1.layer.cornerRadius = 2
               btncheck1.layer.borderColor = UIColor.darkGray.cgColor
               btncheck1.layer.borderWidth = 1
                   borderview1.clipsToBounds = true
                      borderview1.layer.cornerRadius = 2
                      borderview1.layer.borderColor = UIColor.darkGray.cgColor
                      borderview1.layer.borderWidth = 1
        borderview2.clipsToBounds = true
        borderview2.layer.cornerRadius = 2
        borderview2.layer.borderColor = UIColor.darkGray.cgColor
        borderview2.layer.borderWidth = 1
        
        btncheck3.backgroundColor = UIColor.white
         btncheck2.backgroundColor = UIColor.white
         btncheck1.backgroundColor = UIColor.white
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
    func showSimpleAlert()
         {
             let alert = UIAlertController(title: "Un-Associate User", message: "Are you sure do u want to Un Associate the user?",         preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                    //Cancel Action
                }))
                alert.addAction(UIAlertAction(title: "Un Associate",
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                                                //Sign out action
                }))
                self.present(alert, animated: true, completion: nil)
            }
}
