//
//  FootBallContactVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallContactVC: UIViewController
{

    @IBAction func btnbackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var btnsend: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnsend.clipsToBounds = true
        btnsend.layer.cornerRadius = 20;
        contacttextview.clipsToBounds = true
        contacttextview.layer.cornerRadius = 10
        contacttextview.layer.borderColor = UIColor.lightGray.cgColor
        contacttextview.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet var contacttextview: UITextView!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
