//
//  FootBallAddPlayersVC.swift
//  Football Stats
//
//  Created by Chakri on 22/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallAddPlayersVC: UIViewController , UITableViewDataSource, UITableViewDelegate
{

    
    @IBAction func btnaddplayer(_ sender: Any) {
        
        self.showalertview()
    }
    var arrSelectedRows:[Int] = []
    @IBOutlet var tableview: UITableView!
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var btnaddplayer: UIButton!
    
    @IBAction func btnback(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    var menu = ["Mehul", "Chakri", "John" ,"Chirsty","Pickle","Jack Cheese"]
        //      var recents = ["THE GOBBLER", "THE VENETIAN"]
        //      var favorites = ["FRIES", "THE VENETIAN"]
        //    var Features = ["FRESH CUT FRIES", "STIR FRY QUINOA"]
    var menuimages = ["download", "download", "download" ,"download","download","download" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        btnaddplayer.clipsToBounds = true
        btnaddplayer.layer.cornerRadius = 22
        btnaddplayer.layer.borderWidth = 1
        btnaddplayer.layer.borderColor = UIColor.darkGray.cgColor
        // Do any additional setup after loading the view.
    }
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
                        cell.checkbutton.clipsToBounds = true
                        cell.checkbutton.tag = indexPath.row
                        cell.checkbutton.layer.cornerRadius = cell.checkbutton.frame.size.width/2
                        if arrSelectedRows.contains(indexPath.row)
                        {
                            cell.checkbutton.setImage(UIImage(named:"checkmark"), for: .normal)
                        }
                        else
                        {
                            cell.checkbutton.setImage(UIImage(named:"checkBocUnchecked"), for: .normal)
                        }
                        cell.checkbutton.layer.borderColor = UIColor.darkGray.cgColor
                       cell.checkbutton.layer.borderWidth = 1
                       cell.checkbutton.addTarget(self, action: #selector(checkBoxSelection(_:)), for: .touchUpInside)

                         
                        return cell
               }
                  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                      return 70.0;//Choose your custom row height
                  }
            
              func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
                      {
            //           if indexPath.row == 0
                      // {
                  
                      
                        
                       }
    @objc func checkBoxSelection(_ sender:UIButton)
    {

        if self.arrSelectedRows.contains(sender.tag){
            self.arrSelectedRows.remove(at: self.arrSelectedRows.firstIndex(of: sender.tag)!)
        }else{
            self.arrSelectedRows.append(sender.tag)
        }
        tableview.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showalertview()
{
    let alertController = UIAlertController(title: "Add New Player Name", message: "", preferredStyle: UIAlertController.Style.alert)
    alertController.addTextField { (textField : UITextField!) -> Void in
          textField.placeholder = "Player Name"
      }
    let saveAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { alert -> Void in
        _ = alertController.textFields![0] as UITextField
        _ = alertController.textFields![1] as UITextField
      })
    let cancelAction = UIAlertAction(title: "Add Player", style: UIAlertAction.Style.default, handler: {
          (action : UIAlertAction!) -> Void in })
      alertController.addAction(saveAction)
      alertController.addAction(cancelAction)
      
    self.present(alertController, animated: true, completion: nil)
    }
}
