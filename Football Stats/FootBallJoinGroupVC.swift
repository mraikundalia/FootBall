//
//  FootBallJoinGroupVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallJoinGroupVC: UIViewController {

    @IBOutlet var txtcreateleague: UITextField!
    @IBOutlet var txtleaguepassword: UITextField!
    @IBOutlet var txtenterleaguenumber: UITextField!
    @IBOutlet var btnadd: UIButton!
    @IBOutlet var btncreate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnadd.clipsToBounds = true
        btnadd.layer.cornerRadius = 15;
        btncreate.clipsToBounds = true
        btncreate.layer.cornerRadius = 15;
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
