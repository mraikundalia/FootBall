//
//  FootBallAllStatsVC.swift
//  Football Stats
//
//  Created by Chakri on 31/10/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
var sizeOfObjects = 0

class FootBallAllStatsVC: UIViewController , UICollectionViewDelegate
{
    var hud : MBProgressHUD!
    @IBAction func bntbackAction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
     }
    @IBOutlet var allstatsCollectionview: UICollectionView!
    let contentCellIdentifier = "ContentCellIdentifier"
    var dataArray = [[String:Any]]()
       
       var dummyObj = [String : Any]()
       var keyArrays = [String]()
    var databasearray =  NSMutableArray()
     var dataarray =  NSMutableArray()
    var skippedArray = NSMutableArray()
    var databasearray1 = [DatabaseArray]()
    var menu = ["BeatenTheMost","Consecutive_Loss","Consecutive_Wins","Dominance_Rank","Draw", "Draw_Percentage","LastGame" ,"LastTenGames","Loss", "Loss_Percentage","LostMostWith","LostToTheMost","MOM","PlayedMostAgainst","PlayedMostWith","TotalGames","Total_Assists","Total_Goals","Win_Percentage","Won","WonMostWith","dominance","firstGame", "influence_rank","minGamesForStats","name"]
    struct DatabaseArray {

       var announcementBeatenTheMost = ""
            var   announcementConsecutive_Loss = ""
            var   announcementConsecutive_Wins = ""
              var announcementDominance_Rank = ""
               
       var announcementDraw = ""
        var  announcementDraw_Percentage = ""
      var  announcementLastGame = ""
       var  announcementLastTenGames = ""
        var  announcementLoss = ""
       var  announcementLoss_Percentage = ""
        
       var announcementLostMostWith = ""
       var announcementLostToTheMost = ""
        
       var announcementMOM = ""
       var announcementPlayedMostAgainst = ""
        var announcementPlayedMostWith = ""
      var  announcementTotalGames = ""
       var announcementTotal_Assists = ""
      var  announcementTotal_Goals = ""
        var announcementWin_Percentage = ""
       var announcementWon = ""
        var announcementWonMostWith = ""
        
         var announcementdominance = ""
        
         var announcementfirstGame = ""
             var  announcementinfluence = ""
        var announcementDescription = ""
         var announcementinfluence_rank = ""
        var announcementname = ""
              
      
    init(){
        
    }
    init(json:JSON)
    {
     
        announcementBeatenTheMost = json["BeatenTheMost"].stringValue
        announcementConsecutive_Loss = json["Consecutive_Loss"].stringValue
        announcementConsecutive_Wins = json["Consecutive_Wins"].stringValue
        announcementDominance_Rank = json["Dominance_Rank"].stringValue
        
        announcementDraw = json["Draw"].stringValue
        announcementDraw_Percentage = json["Draw_Percentage"].stringValue
        announcementLastGame = json["LastGame"].stringValue
        announcementLastTenGames = json["LastTenGames"].stringValue
        announcementLoss = json["Loss"].stringValue
        announcementLoss_Percentage = json["Loss_Percentage"].stringValue
        
        announcementLostMostWith = json["LostMostWith"].stringValue
        announcementLostToTheMost = json["LostToTheMost"].stringValue
        
        announcementMOM = json["MOM"].stringValue
        announcementPlayedMostAgainst = json["PlayedMostAgainst"].stringValue
        announcementPlayedMostWith = json["PlayedMostWith"].stringValue
        announcementTotalGames = json["TotalGames"].stringValue
        announcementTotal_Assists = json["Total_Assists"].stringValue
        announcementTotal_Goals = json["Total_Goals"].stringValue
        announcementWin_Percentage = json["Win_Percentage"].stringValue
        announcementWon = json["Won"].stringValue
        announcementWonMostWith = json["WonMostWith"].stringValue
        
        announcementdominance = json["dominance"].stringValue
        
        announcementfirstGame = json["firstGame"].stringValue
        announcementinfluence = json["influence"].stringValue
        announcementDescription = json["influence_rank"].stringValue
        announcementinfluence_rank = json["minGamesForStats"].stringValue
        announcementname = json["name"].stringValue
        
    }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
       
        allstatsCollectionview.register(UINib(nibName: "ContentCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: contentCellIdentifier)
        self.GetAllStats()
        // Do any additional setup after loading the view.
    }
    //MARK: API CALL////////////////////
       func GetAllStats()
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
                           self.allstatsCollectionview.reloadData()
                        }
                                    }
               
                
                  DispatchQueue.main.async
                    {
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
      
      
         
     //    @objc func startTimer(theTimer: Timer){
     //        UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseOut, animations: {
     //            self.announcementCollectionView.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredHorizontally, animated: false)
     //        }, completion: nil)
     //    }
    
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
    extension FootBallAllStatsVC: UICollectionViewDataSource
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

//// MARK: - UICollectionViewDelegate
//extension FootBallAllStatsVC: UICollectionViewDelegate
//{
//
//}
