//
//  FootBallGroupsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallGroupsVC: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    
    
     var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
    //      var recents = ["THE GOBBLER", "THE VENETIAN"]
    //      var favorites = ["FRIES", "THE VENETIAN"]
    //    var Features = ["FRESH CUT FRIES", "STIR FRY QUINOA"]
           var menuimages = ["download", "download", "download" ,"download","download","download" ]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menu.count
        
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
              {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "FootBallPlayerTableCell", for: indexPath as IndexPath) as! FootBallPlayerTableCell
                  cell.profilename.text = menu[indexPath.row]
                    //
                    //cell..selectionStyle = .none
               let image : UIImage = UIImage(named:menuimages[indexPath.row] )!
               cell.profileimage.image = image
                cell.profileimage.clipsToBounds = true
                cell.profileimage.layer.cornerRadius =  cell.profileimage.frame.size.width/2;
               
                 
                return cell
       }
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 70.0;//Choose your custom row height
          }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
              {
    //           if indexPath.row == 0
              // {
              let login: FootBallPlayerAssociationVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallPlayerAssociationVC") as! FootBallPlayerAssociationVC)
               self.navigationController?.pushViewController(login!, animated: true)
    //            let login: ConsiciousCustomizeorderVC? = (storyboard?.instantiateViewController(withIdentifier: "ConsiciousCustomizeorderVC") as! ConsiciousCustomizeorderVC)
    //                self.navigationController?.pushViewController(login!, animated: true)
    //                        let login: ConsiciousMenuDetail1ViewController? = (storyboard?.instantiateViewController(withIdentifier: "ConsiciousMenuDetail1ViewController") as! ConsiciousMenuDetail1ViewController)
    //                            self.navigationController?.pushViewController(login!, animated: true)
          //  ller?.pushViewController(login!, animated: true)
                
               }
    //           else
    //           {
    //               let login: ConsiciousBirthdayVC? = (storyboard?.instantiateViewController(withIdentifier: "ConsiciousBirthdayVC") as! ConsiciousBirthdayVC)
    //               self.navigationController?.pushViewController(login!, animated: true)
    //           }
              
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    
    
    @IBOutlet var searchbartext: UISearchBar!
    @IBOutlet var btndateofmatich: UIButton!
    
    @IBAction func btnActionGroupSettings(_ sender: Any)
    {
        let login: FootBallGroupSettingsVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallGroupSettingsVC") as! FootBallGroupSettingsVC)
        self.navigationController?.pushViewController(login!, animated: true)
    }
    @IBOutlet var grouptable: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btndateofmatich.layer.cornerRadius = 10
        btndateofmatich.clipsToBounds = true
        btndateofmatich.layer.borderWidth = 1
        btndateofmatich.layer.borderColor = UIColor.lightGray.cgColor

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
