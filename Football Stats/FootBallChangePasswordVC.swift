//
//  FootBallChangePasswordVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallChangePasswordVC: UIViewController {

    
    @IBOutlet var txtconfirmpassword: UITextField!
    @IBOutlet var txtnewpassword: UITextField!
    @IBOutlet var txtcurrentpassword: UITextField!
    
    @IBAction func btnbackAction(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnconfirmAction(_ sender: Any) {
    }
    @IBOutlet var btnconfirm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnconfirm.layer.cornerRadius = 20;
        btnconfirm.clipsToBounds = true
        
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
