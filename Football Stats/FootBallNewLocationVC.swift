//
//  FootBallNewLocationVC.swift
//  Football Stats
//
//  Created by Chakri on 22/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallNewLocationVC: UIViewController {

    @IBOutlet var txtsecond: UITextField!
    
    @IBOutlet var txtthird: UITextField!
    
    @IBOutlet var txtpostaldown: UITextField!
    
    @IBOutlet var txtfourth: UITextField!
    
    @IBOutlet var txtfirst: UITextField!
    
    @IBOutlet var btnconfirmlocation: UIButton!
    
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet var btndate: UIButton!
    
    @IBOutlet var btnpostal: UIButton!
    
    @IBAction func btnpostalAction(_ sender: Any) {
    }
    
    @IBOutlet var txtpstalname: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btndate.layer.cornerRadius = 9
        btndate.clipsToBounds = true
        btndate.layer.borderWidth = 1
        btndate.layer.borderColor = UIColor.darkGray.cgColor
        btnpostal.layer.cornerRadius = 9
        btnpostal.clipsToBounds = true
        btnpostal.layer.borderWidth = 1
        btnpostal.layer.borderColor = UIColor.darkGray.cgColor
        btnconfirmlocation.clipsToBounds = true
       btnconfirmlocation.layer.cornerRadius = 22
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

}
