//
//  FootBallStatsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
class FootBallStatsVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, NIDropDownDelegate{
    weak var currentViewController: UIViewController?
    @IBOutlet weak var containerView: UIView!

    @IBOutlet var lblnumgames: UILabel!
    @IBOutlet var gamesplayed: UILabel!
    
    @IBOutlet var profilename: UILabel!
    @IBOutlet var btnnamelist: UIButton!
    @IBAction func btnheaderAction(_ sender: Any)
    {
    }
    
    @IBAction func btnplayerindAction(_ sender: Any)
    {
    }
    
    @IBAction func btnnamelistAction(_ sender: Any)
    {
        if btndropdown.isDescendant(of: self.view)
        {
            //myView is subview of self.view, remove it.
             btndropdown.removeFromSuperview()
          }
          else
          {
        let myFloatForR = 250
          var r = CGFloat(myFloatForR)
         // lazy var value: Float = 200
          btndropdown.isHidden = false
          btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (playernames.value(forKey: "name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
          btndropdown.setDropDownSelectionColor(UIColor.gray)
          btndropdown.delegate = self
             btndropdown.tag = 2
        }
    }
    
   var hud : MBProgressHUD!
    var btndropdown = NIDropDown ()
    var databasearray =  NSMutableArray()
     var skippedArray = NSMutableArray()
    var playernames = NSMutableArray()
    var databasenames =  NSMutableArray()
    @IBAction func btnstatsAction(_ sender: Any) {
        let login: FootBallAllStatsVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallAllStatsVC") as! FootBallAllStatsVC)
    self.navigationController?.pushViewController(login!, animated: true)
    }
    @IBOutlet var topcurve: UIView!
    
    @IBOutlet var profileimage: UIImageView!
    @IBOutlet var statscollectionview: UICollectionView!
    
    @IBOutlet var btnheader: UIButton!
    @IBOutlet var btnplayerind: UIButton!
    @IBOutlet var btnstats: UIButton!
    
    
    var menu = ["Won", "Lost", "Draw" ,"Consecutive Wins","% won","Consecutive Wins Lost","Dominance  Rank","Dominance","Infulence Rank","Infulence","Index Rank","Index "]
    var num = ["03", "00", "00" ,"03","% 100","00","1 to 20","1.1","1 to 20","2.1","1 to 20","3.1"]
    var name = ["Mehul", "Chakri", "Philips","Kelvin","Simon","Rish","Santa","Siree","Philip"]
    var gameplayed = ["Most Games Played", "Best win Percentage", "Consecutive wins" ,"Most Games Played", "Best win Percentage", "Consecutive wins" ,"Most Games Played", "Best win Percentage", "Consecutive wins"]
   var score = ["5", "%100", "00" ,"03","% 100","6","%100","5","1"]
    var playername = ""
      var hotelName =  ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        btntuesday.clipsToBounds = true
//        btntuesday.layer.cornerRadius = 8
//        btntuesday.layer.borderColor = UIColor.black.cgColor
//        btntuesday.layer.borderWidth = 1
        
      
        
        btnstats.clipsToBounds = true
        btnstats.layer.cornerRadius = 8
        //2,148,44,1
        btnstats.layer.borderColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 44.0/255.0, alpha: 1).cgColor
        btnstats.layer.borderWidth = 1
        
//        btnplayerind.clipsToBounds = true
//        btnplayerind.layer.cornerRadius = 8
//        btnplayerind.layer.borderColor =  UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 44.0/255.0, alpha: 1).cgColor
//        btnplayerind.layer.borderWidth = 1
        btnnamelist.clipsToBounds = true
               btnnamelist.layer.cornerRadius = 8
        btnnamelist.layer.borderColor =  UIColor.black.cgColor
               btnnamelist.layer.borderWidth = 1
        profileimage.clipsToBounds = true
        profileimage.layer.cornerRadius = profileimage.frame.size.width/2
        
        let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-80, height:100)
                flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right:0)
                flowLayout.scrollDirection = .horizontal
                flowLayout.minimumInteritemSpacing = 0.0
                         statscollectionview.collectionViewLayout = flowLayout
                     // Do any additional setup after loading the view.
         let defaults : UserDefaults = UserDefaults.standard
        
        hotelName = (defaults.value(forKey: "database_name") as! String?)!
         
             self.GetStatsCall()
          
        
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
            {
             
                    return  self.databasearray.count
              
               
            }
                         
                     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
                     {
                        
                       
                            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FootBallCollectionCel", for: indexPath as IndexPath) as! FootBallCollectionCel
                                              if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                                              {
                                                  layout.scrollDirection = .vertical
                                              }
                                              
                                            DispatchQueue.main.async{
                                                //cell.lblname.text = self.databasearray[indexPath.row]
                                           // cell.mainimage.image =  UIImage.init(named: "redshirt")
                                            //cell.lblnumber.text =  self.num[indexPath.row]
                                                cell.contentView.clipsToBounds  = true
                                                cell.contentView.layer.cornerRadius = 9
                                                cell.contentView.layer.borderWidth = 1;
                                                cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
                      let array = self.databasearray[indexPath.row]
//                      let x : Int = (array as AnyObject).value(forKey: "valuex") as! Int
//                       //(array  as AnyObject).value(forKey: "ICanPlay_id") as? String
//                          let myString = String(x)
                            cell.lblname.text = (array  as AnyObject).value(forKey: "dimension") as? String
                            cell.contentView.isHidden = false
                            cell.layer.borderColor = UIColor.black.cgColor
                          cell.lblnumber.text = (array  as AnyObject).value(forKey: "valuex") as? String
                            }
                        return cell
                        
                      
                         
                     }
                  
               func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
               {
                  
    //              let array = self.skippedArray[indexPath.row]
    //                  let x : Int = (array as AnyObject).value(forKey: "position") as! Int
    //              let str2 = String(x)
    //             // let postionnum : String = (array  as AnyObject).value(forKey: "position") as! String
    //
    //              if btndefaultdatabase.currentTitle == "Select Database"
    //              {
    //                  self.showToast(message: "Select DataBase", font: UIFont.systemFont(ofSize: 13))
    //              }
    //              else
    //              {
    //                  let login: FootBallSelectPlayerVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallSelectPlayerVC") as! FootBallSelectPlayerVC)
    //                  login!.btnallowplay =  btndefaultdatabase.currentTitle!
    //                  login!.postionnum = str2
    //                  login!.sortedteamid = storedTeams_id
    //                   login!.icanplayid = icanplayid
    //                  self.navigationController?.pushViewController(login!, animated: true)
    //              }
                  
                  
                  }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
                let width = ((statscollectionview.frame.width - 15) / 2) // 15 because of paddings
                          print("cell width : \(width)")
                          return CGSize(width: 110, height: 110)
            
            
          
            }
    
    
    
    
    func niDropDownDelegateMethod(_ sender: NIDropDown!)
    {
        
    }
    
    func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
    {
        
            btnnamelist.setTitle(title, for: .normal)
            playername = title
            self.GetStatsCall()
        
        
     
        
    }
    
    func niDropDownHidden(_ sender: NIDropDown!) {
        btndropdown.isHidden = true

    }
    //MARK: API CALL////////////////////
          func GetStatsCall()
            {
                        //SVProgressHUD.show()
            //            var string = String.self
            //            string = UserDefaults.standard.integer(forKey: "registerid")
                        
                    
                        
                        hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                        hud.labelText = ""
                        
                        
                        
                        let str2 =  UserDefaults.standard.object(forKey: "registerid")
                                // let string = btndateofmatich.currentTitle
                            //String(UserDefaults.standard.integer(forKey: "registerid"))
                    let verify_param = ["storedProcedureName":"getplayerStats","input1":str2 as Any ,"input2":hotelName,"input3":playername] as [String : Any]
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
                                
                                self.databasearray = (jsonResponse["Data2"]! as! NSArray).mutableCopy() as! NSMutableArray
                            self.skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
//                                if <#condition#> {
//                                    <#code#>
//                                }
                    self.playernames = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                    self.databasenames = (jsonResponse["Data4"]! as! NSArray).mutableCopy() as! NSMutableArray
                            // let dataarray = skippedArray.firstObject as! NSDictionary

                                //self.skippedArray = (jsonResponse["Data1"] as? NSArray)! as! NSMutableArray
                            
                                let result = self.skippedArray[0] as? NSDictionary

                            // var stringvalue1 = ""
                        
                                if let partname = result!.value(forKey: "playername") as? String
                                    {
                                    
                                    self.profilename.text = partname
                                }
//
                                if let partname = result!.value(forKey: "playerPic") as? String
                                {
                                    if partname.count>0
                                    {
                                    let dataDecoded:NSData = NSData(base64Encoded: partname, options: NSData.Base64DecodingOptions(rawValue: 0))!
                                    let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
                                    print(decodedimage)
                                    self.profileimage.image = decodedimage
                                    }
                                }
                            
                                if let partname = result!.value(forKey: "Measure") as? Int
                            {
                                let str2 = String(partname)
                            self.lblnumgames.text = str2
                            }
                                if let partname = result!.value(forKey: "MeasureName") as? String
                                {
                                    // let str2 = String(partname)
                                self.gamesplayed.text = partname
                                }
//                             if let partname = result!.value(forKey: "Game_ID") as? Int
//                             {
//                             let str2 = String(partname)
//                              self.gameid.text = str2
//                              }
//                             self.stringvalue1 =  NSString(format: "%@",(result!.value(forKey: "iCanPlay_id") as! CVarArg)) as String
//                             print(self.stringvalue1)
//
                                
                                DispatchQueue.main.async{
                            self.statscollectionview.reloadData()
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
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
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
