//
//  FootBallAllHeadsVC.swift
//  Football Stats
//
//  Created by Chakri on 08/11/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire

class FootBallAllHeadsVC: UIViewController
{
    
    @IBOutlet var Allheadcollection: UICollectionView!
    @IBAction func bntbackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    var hud : MBProgressHUD!
    
    var databasearray =  NSMutableArray()
    var skippedArray = NSMutableArray()
    let contentCellIdentifier = "ContentCellIdentifier"
     var dataArray = [[String:Any]]()
        
        var dummyObj = [String : Any]()
        var keyArrays = [String]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Allheadcollection.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                       forCellWithReuseIdentifier: contentCellIdentifier)
        
        self.GetAllHeads()
        // Do any additional setup after loading the view.
    }
    
    //MARK: API CALL////////////////////
         func GetAllHeads()
         {
                        
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

            hud.labelText = ""
            
            let defaults : UserDefaults = UserDefaults.standard
            var hotelName =  ""
            hotelName = (defaults.value(forKey: "database_name") as! String?)!
              let str2 =  UserDefaults.standard.object(forKey: "registerid")
                  
           let verify_param = ["storedProcedureName":"getPlayerStatsAll","input1":str2 as Any ,"input2":hotelName] as [String : Any]
                  let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
            AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                        response in
               
                       DispatchQueue.main.async
                           {
                           self.hud.hide(true)
                              }
                     if let json = response.value
                     {
                let jsonResponse = json as! NSDictionary
                    print(jsonResponse)
                     do
                     {
                      var stringvalue:String = ""
            stringvalue = jsonResponse["status"] as! String
                                                
                                                 
              if stringvalue == "Success"
                {
                    
                    self.dataArray = ((jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray) as! [[String : Any]]
                
                        if   self.dataArray.count > 0{
                      self.dummyObj = self.dataArray[0]
                      self.keyArrays = self.dummyObj.keys.reversed()
                      sizeOfObjects = self.keyArrays.count + 1
                              DispatchQueue.main.async
                                  {
                                 self.Allheadcollection.reloadData()
                              }
                                }

                
                    }
                else
              {
                 var skippedArray1 = NSMutableArray()
              skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
               let dataarray = skippedArray1.firstObject as! NSDictionary
                var stringvalue1:String = ""
                 stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                 self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                        }
                                            }
                                          }
                                         }
                                    
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
// MARK: - UICollectionViewDataSource
extension FootBallAllHeadsVC: UICollectionViewDataSource
{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataArray.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.keyArrays.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier,
                                                      for: indexPath) as! ContentCollectionViewCell

        if indexPath.section % 2 != 0 {
            cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        
        if indexPath.section == 0
        {
            if indexPath.row == 0 {
               
                cell.contentLabel.text = "Sno"
            }
            else
            {
                cell.contentLabel.text = self.keyArrays[indexPath.row - 1]
            }
        } else {
            if indexPath.row == 0 {
                cell.contentLabel.text = String(indexPath.section)
            } else {
                let dic = self.dataArray[indexPath.section - 1]
                let key = self.keyArrays[indexPath.row - 1]
                if let nam = dic[key] as? String{
                    cell.contentLabel.text = nam
                    
                }
             
//                cell.contentLabel.text = "Content"
            }
        }

        return cell
    }

}
