//
//  FootBallWholeTeamVC.swift
//  Football Stats
//
//  Created by Chakri on 07/11/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
class FootBallWholeTeamVC: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate {
    var hud : MBProgressHUD!
    @IBOutlet var wholeteamCollection: UICollectionView!
    var databasearray =  NSMutableArray()
       var skippedArray = NSMutableArray()
    var name = ["Mehul", "Chakri", "Philips","Kelvin","Simon","Rish","Santa","Siree","Philip"]
       var gameplayed = ["Most Games Played", "Best win Percentage", "Consecutive wins" ,"Most Games Played", "Best win Percentage", "Consecutive wins" ,"Most Games Played", "Best win Percentage", "Consecutive wins"]
      var score = ["5", "%100", "00" ,"03","% 100","6","%100","5","1"]
    override func viewDidLoad() {
        super.viewDidLoad()

             let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-70, height:220)
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right:5)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0.5
            wholeteamCollection.collectionViewLayout = flowLayout
        self.GetWholeTeamCall()
        // Do any additional setup after loading the view.
    }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
                {
                  
                        return  self.databasearray.count
                    
                   
                }
                             
                         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
                         {
                                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FootBallStats1Cell", for: indexPath as IndexPath) as! FootBallStats1Cell
                                  if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                                  {
                                      layout.scrollDirection = .vertical
                                  }
                                  
                                DispatchQueue.main.async
                                    {
                               // cell.score.text = self.score[indexPath.row]
                               // cell.mainimage.image =  UIImage.init(named: "redshirt")
                                //cell.lblprofilename.text =  self.name[indexPath.row]
                               //cell.lblgameplayed.text = self.gameplayed[indexPath.row]
                      let array = self.databasearray[indexPath.row]
                        if let partname = (array as AnyObject).value(forKey: "profilePicture1") as? String
                       {
                           if partname.count>0
                           {
                           let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                           let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                           print(decodedimage)
                            cell.profileimage.image = decodedimage
                           }
                       }
                if let partname = (array as AnyObject).value(forKey: "profilePicture2") as? String
                {
                    if partname.count>0
                    {
                    let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                    print(decodedimage)
                     cell.profileimage1.image = decodedimage
                    }
                }
                if let partname = (array as AnyObject).value(forKey: "profilePicture3") as? String
             {
                 if partname.count>0
                 {
                 let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                 let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                 print(decodedimage)
                  cell.profileimage2.image = decodedimage
                 }
             }
            if let partname = (array as AnyObject).value(forKey: "profilePicture4") as? String
            {
                if partname.count>0
                {
                let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                print(decodedimage)
                 cell.profileimage3.image = decodedimage
                }
            }
                            //  let x : Int = (array as AnyObject).value(forKey: "measure") as! Int
                               //(array  as AnyObject).value(forKey: "ICanPlay_id") as? String
                                 // let myString = String(x)
                                    cell.lblprofilename.text = (array  as AnyObject).value(forKey: "names") as? String
                                    //cell.contentView.isHidden = false
                                    cell.layer.borderColor = UIColor.black.cgColor
                                  cell.lblgameplayed.text = (array  as AnyObject).value(forKey: "description") as? String
                    if let partname = (array as AnyObject).value(forKey: "measure") as? Int
                   {
                     let myString = String(partname)
                      cell.score.text = myString
                   }
                                    
                print((array  as AnyObject).value(forKey: "measure") as? String as Any)
                cell.contentView.clipsToBounds  = true
                //cell.contentView.layer.cornerRadius = 9
                cell.contentView.layer.borderWidth = 1;
                cell.contentView.layer.borderColor = UIColor.black.cgColor
                                }
                                return cell
                         }
                      
                   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
                   {
                                            
                      }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              
            let width = ((wholeteamCollection.frame.width - 15) / 2) // 15 because of paddings
                print("cell width : \(width)")
                return CGSize(width: 160, height: 190)
                
              
                }
    //MARK: API CALL////////////////////
             func GetWholeTeamCall()
                          {
                
                            hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                            hud.labelText = ""
                            
                            let defaults : UserDefaults = UserDefaults.standard
                            var hotelName =  ""
                            hotelName = (defaults.value(forKey: "database_name") as! String?)!
                              let str2 =  UserDefaults.standard.object(forKey: "registerid")
                                  
                           let verify_param = ["storedProcedureName":"getWholeTeamStats","input1":str2 as Any ,"input2":hotelName] as [String : Any]
                                  let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                            AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                                        response in
                               
                                       DispatchQueue.main.async
                                           {
                                           self.hud.hide(true)
                                              }
                                      //  SVProgressHUD.dismiss()
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
                                    
                                    self.databasearray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                                  // self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                 
                                   // let dataarray = skippedArray.firstObject as! NSDictionary

                                    //self.skippedArray = (jsonResponse["Data1"] as? NSArray)! as! NSMutableArray
                                   
                                   // let result = self.skippedArray[0] as? NSDictionary

                                    
                                    DispatchQueue.main.async{
                                   self.wholeteamCollection.reloadData()
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
