//
//  FootBallPlayVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallPlayVC: UIViewController {

    
    @IBOutlet var borderview: UIView!
    
    @IBOutlet var btntuesday: UIButton!
    
    
    @IBOutlet var btndate: UIButton!
    
    @IBOutlet var btnxspace: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    //    self.tabBarController?.selectedIndex = 4
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool)
    {
        borderview.clipsToBounds = true
        borderview.layer.borderColor = UIColor.lightGray.cgColor
        borderview.layer.borderColor = UIColor.lightGray.cgColor
        
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
