//
//  FootBallGameSettingVC.swift
//  Football Stats
//
//  Created by Chakri on 22/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallGameSettingVC: UIViewController {

 
    
    @IBAction func btnback(_ sender: Any) {
 self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnsetnewlocation(_ sender: Any) {
        
        
        let login:FootBallNewLocationVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallNewLocationVC") as! FootBallNewLocationVC)
               self.navigationController?.pushViewController(login!, animated: true)
        
    }
    @IBOutlet var btndate: UIButton!
    
    
    @IBOutlet var btngametype: UIButton!
    
    @IBOutlet var btnreviseplayers: UIButton!
    
    @IBOutlet var btnalperton: UIButton!
    
    @IBOutlet var btnsidefootball: UIButton!

    @IBOutlet var btnprize: UIButton!
    
    
    @IBOutlet var btnconfirmgame: UIButton!
    
    @IBAction func btnreviseplayers(_ sender: Any) {
    }
    
    @IBAction func btngametype(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btndate.clipsToBounds = true
        btndate.layer.cornerRadius = 9
        btndate.layer.borderWidth = 1
        btndate.layer.borderColor = UIColor.darkGray.cgColor
        btngametype.clipsToBounds = true
              btngametype.layer.cornerRadius = 9
              btngametype.layer.borderWidth = 1
              btngametype.layer.borderColor = UIColor.darkGray.cgColor
        btnreviseplayers.clipsToBounds = true
         btnreviseplayers.layer.cornerRadius = 9
         btnreviseplayers.layer.borderWidth = 1
         btnreviseplayers.layer.borderColor = UIColor.darkGray.cgColor
        btnalperton.clipsToBounds = true
         btnalperton.layer.cornerRadius = 9
         btnalperton.layer.borderWidth = 1
         btnalperton.layer.borderColor = UIColor.darkGray.cgColor
           btnsidefootball.clipsToBounds = true
              btnsidefootball.layer.cornerRadius = 9
              btnsidefootball.layer.borderWidth = 1
              btnsidefootball.layer.borderColor = UIColor.darkGray.cgColor
        btnprize.clipsToBounds = true
        btnprize.layer.cornerRadius = 9
        btnprize.layer.borderWidth = 1
        btnprize.layer.borderColor = UIColor.darkGray.cgColor
        btnconfirmgame.clipsToBounds = true
        btnconfirmgame.layer.cornerRadius = 22
        
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
