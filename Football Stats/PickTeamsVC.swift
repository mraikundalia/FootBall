//
//  PickTeamsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
import SDWebImage

class PickTeamsVC: UIViewController ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, NIDropDownDelegate, UICollectionViewDragDelegate,UICollectionViewDropDelegate {
    
    @IBOutlet var btnplus: UIButton!
    @IBOutlet var btnminus: UIButton!
    @IBAction func btnminusAction(_ sender: Any)
    {
        guard let presentValue = Int(storedversionnumber!.text!) else
               { return }

            let newValue = presentValue - 1
        if newValue<0
        {
            
        }
        else
        {
            
            storedversionnumber!.text = String(newValue)
            if  storedversion.count <= newValue
            {
                
            }
            else
            
            {
                let array = storedversion[newValue]
                let x:Int = (array as AnyObject).value(forKey: "storedTeams_id") as! Int
               storedTeams_id = String(x)
               // storedTeams_id = (array as AnyObject).value(forKey: "storedTeams_id") as! String
                print(storedTeams_id)
            }
           
        }
       
        
        
                   
    }
    
    @IBAction func btnplusAction(_ sender: Any)
    {
        guard let presentValue = Int(storedversionnumber!.text!) else
        { return }

            let newValue = presentValue + 1
            storedversionnumber!.text = String(newValue)
        if   storedversion.count <= newValue
        {
            
        }
        else
        {
           print(storedversion[newValue])
            let array = storedversion[newValue]
             let x:Int = (array as AnyObject).value(forKey: "storedTeams_id") as! Int
            storedTeams_id = String(x)
             
            // storedTeams_id = (array as AnyObject).value(forKey: "storedTeams_id") as! String
             print(storedTeams_id)
        }
          
    }
    
    
    @IBAction func btnrandomAction(_ sender: Any) {
        self.PickRandomCall()
    }
    @IBAction func btndraftAction(_ sender: Any) {
        self.SaveDraft()
    }
    
    
    @IBOutlet var storedversionnumber: UILabel!
    
    @IBOutlet var btnindexselection: UIButton!
    @IBOutlet var btnrandom: UIButton!
    
    @IBOutlet var btndraft: UIButton!
    @IBOutlet var btndefaultdatabase: UIButton!
    var databasearray =  NSMutableArray()
    var defaultdatabase = NSMutableArray()
    var storedversion = NSMutableArray()
    var btndropdown = NIDropDown ()

    func niDropDownDelegateMethod(_ sender: NIDropDown!) {
              
          }
          
          func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
          {
//              tuesdayheightcon.constant = 130
                 btndefaultdatabase.setTitle(title, for:.normal)
            self.PickteamsstoredteamidCall()
            
          }
          
          func niDropDownHidden(_ sender: NIDropDown!)
          {
//              tuesdayheightcon.constant = 130
//              btndropdown.isHidden = true
          }
    
    @IBAction func btndefaultAction(_ sender: Any) {
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
          btndropdown.show((sender as! UIButton), theHeight: &r, theArr: (defaultdatabase.value(forKey: "database_name") as! [Any]), theImgArr: nil, theDirection: "down", with: self)
          btndropdown.setDropDownSelectionColor(UIColor.gray)
          btndropdown.delegate = self
             btndropdown.tag = 2
        }

    }
    
    @IBAction func gamesettings(_ sender: Any)
    {
        if btndefaultdatabase.currentTitle == "Select Database"
        {
            self.showToast(message: "Select DataBase", font: UIFont.systemFont(ofSize: 13))
        }
        else
        {
            let login: FootBallPickGameSettingVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallPickGameSettingVC") as! FootBallPickGameSettingVC)
            login!.btnallowplay =  btndefaultdatabase.currentTitle!
            self.navigationController?.pushViewController(login!, animated: true)
        }
    }
    @IBOutlet var pickcollection: UICollectionView!
    var hud : MBProgressHUD!
    var hotelName =  ""
     var hudshow =  ""
     var stringvalue1 = ""
     var storedTeams_id = ""
    var icanplayid = ""
    var skippedArray = NSMutableArray()
    
    
    //MARK: ViewDidLoad///////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
   let flowLayout = UICollectionViewFlowLayout()
           flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-130, height:100)
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right:0)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0.0
            pickcollection.collectionViewLayout = flowLayout
        // Do any additional setup after loading the view.
        self.GetDatabaseNames()
       let bgImage = UIImageView();
        bgImage.image = UIImage(named: "pitchview1");
        bgImage.contentMode = .scaleToFill


        self.pickcollection?.backgroundView = bgImage
        self.pickcollection.dragDelegate = self
        self.pickcollection.dropDelegate = self

      
        btnrandom.clipsToBounds = true
        btnrandom.layer.cornerRadius = 6;
        btnrandom.layer.borderColor =  UIColor.darkGray.cgColor
        btnrandom.layer.borderWidth = 1;
        btnindexselection.clipsToBounds = true
       btnindexselection.layer.cornerRadius = 6;
       btnindexselection.layer.borderColor =  UIColor.darkGray.cgColor
       btnindexselection.layer.borderWidth = 1;
        btndraft.clipsToBounds = true
      btndraft.layer.cornerRadius = 6;
      btndraft.layer.borderColor =  UIColor.darkGray.cgColor
      btndraft.layer.borderWidth = 1;
     btndefaultdatabase.clipsToBounds = true
     btndefaultdatabase.layer.cornerRadius = 6;
     btndefaultdatabase.layer.borderColor =  UIColor.darkGray.cgColor
     btndefaultdatabase.layer.borderWidth = 1;
        let defaults : UserDefaults = UserDefaults.standard
        hotelName = (defaults.value(forKey: "database_name") as! String?)!
          if(hotelName != "")
          {
              btndefaultdatabase .setTitle(hotelName, for: .normal)
              hudshow = "YES"
             self.PickteamsCall()
              
          }
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handlelogpressgesture(_:)))
        pickcollection?.addGestureRecognizer(gesture)
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//                     backgroundImage.image = UIImage(named: "pitchview1")
//                     backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
//                     self.view.insertSubview(backgroundImage, at: 0)
//               self.view.backgroundColor = UIColor(patternImage: UIImage(named:"pitchview")!)
    }
    @objc func handlelogpressgesture(_ gesture: UILongPressGestureRecognizer)
    {
        guard let collectionview = pickcollection else
        {
            return
        }
        switch gesture.state {
        case .began:
            guard let targetindexpath = collectionview.indexPathForItem(at: gesture.location(in: collectionview)) else
            {
                return
            }
            collectionview.beginInteractiveMovementForItem(at: targetindexpath)
        case .changed:
            
        collectionview.updateInteractiveMovementTargetPosition(gesture.location(in: collectionview))
            
        case .ended:
            collectionview.endInteractiveMovement()
        default:
            collectionview.cancelInteractiveMovement()
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        if storedTeams_id.count > 0
        {
        self.PickteamsstoredteamidCall()
        }
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        return skippedArray.count
          
            
            }
               
               func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
               {
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FootBallCollectionCel", for: indexPath as IndexPath) as! FootBallCollectionCel
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                {
                    layout.scrollDirection = .vertical
                }
                cell.mainimage.layer.cornerRadius = 8
                cell.mainimage.clipsToBounds = true
                  DispatchQueue.main.async{
                let array = self.skippedArray[indexPath.row]
                                        
                let x : Int = (array as AnyObject).value(forKey: "visible") as! Int
                // //(array  as AnyObject).value(forKey: "ICanPlay_id") as? String
                //
                //    let myString = String(x)
                //
                //    cell.profilename.text = myString
                       
                //(array as AnyObject).value(forKey: "ICanPlay_id") as? String
                    if x == 0
                    {
                       cell.contentView.isHidden = true
                        cell.layer.borderColor = UIColor.white.cgColor
                    }
                    else
                    {
                       cell.contentView.isHidden = false
                      cell.layer.borderColor = UIColor.black.cgColor //Set Default color here
                    cell.lblname.text = (array  as AnyObject).value(forKey: "name") as? String
                        
                        cell.mainimage.sd_setImage(with: URL(string: ((array  as AnyObject).value(forKey: "shirtColour") as? String)!), placeholderImage: UIImage(named: "load"))

//                        if (array  as AnyObject).value(forKey: "shirtColour") as? String ==  "Pick"
//                   {
//                       cell.mainimage.image = UIImage.init(named: "default image")
//
//                   }
//                        if (array  as AnyObject).value(forKey: "shirtColour") as? String ==  "Red"
//                      {
//                          cell.mainimage.image = UIImage.init(named: "redshirt")
//
//                      }
//                        if (array  as AnyObject).value(forKey: "shirtColour") as? String ==  "White"
//                        {
//                            cell.mainimage.image = UIImage.init(named: "redshirt")
//
//                        }
                        
                    }
               
                }
                
                 
//                if dataSource[indexPath.row] == "@" {
//
//                   
//                }
//                else {
//                   
//                }
//                   
            return cell
               }
        
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
     {
        
        let array = self.skippedArray[indexPath.row]
            let x : Int = (array as AnyObject).value(forKey: "position") as! Int
        let str2 = String(x)
       // let postionnum : String = (array  as AnyObject).value(forKey: "position") as! String
                     
        if btndefaultdatabase.currentTitle == "Select Database"
        {
            self.showToast(message: "Select DataBase", font: UIFont.systemFont(ofSize: 13))
        }
        else
        {
            let login: FootBallSelectPlayerVC? = (storyboard?.instantiateViewController(withIdentifier: "FootBallSelectPlayerVC") as! FootBallSelectPlayerVC)
            login!.btnallowplay =  btndefaultdatabase.currentTitle!
            login!.postionnum = str2
            login!.sortedteamid = storedTeams_id
             login!.icanplayid = icanplayid
            self.navigationController?.pushViewController(login!, animated: true)
        }
        
        
        }
    //Provides the initial set of items (if any) to drag.
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = skippedArray[indexPath.row]
        // let itemProvider = NSItemProvider(object: self)
        //let itemProvider = NSItemProvider(object: String(item) as NSString)
        let dragItem = UIDragItem(itemProvider: item as! NSItemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    //Tells your delegate that the position of the dragged data over the collection view changed.
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
     func collectionView(_ collectionView: UICollectionView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
     {
       let movedObject = self.skippedArray[sourceIndexPath.row]
        self.skippedArray.remove(sourceIndexPath.row)
        self.skippedArray.insert(movedObject, at: destinationIndexPath.row)
    }
   
           func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
               if collectionView.hasActiveDrag {
                   return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
               }
               return UICollectionViewDropProposal(operation: .forbidden)
           }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
    }
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
             if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
                 collectionView.performBatchUpdates({
                    skippedArray.remove(sourceIndexPath.item)
                    skippedArray.insert(item.dragItem.localObject as! Int, at: destinationIndexPath.item)
                     collectionView.deleteItems(at: [sourceIndexPath])
                     collectionView.insertItems(at: [destinationIndexPath])
                 }, completion: nil)
                 coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
             }
         }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = ((pickcollection.frame.width - 15) / 2) // 15 because of paddings
         print("cell width : \(width)")
         return CGSize(width: 90, height: 120)
     }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    //MARK: Api Call/////////////
           
           func GetDatabaseNames()
                   {


                       //hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                           //hud.labelText = ""
                     //SVProgressHUD.show()
           //            var string = String.self
           //            string = UserDefaults.standard.integer(forKey: "registerid")
                       let str2 =  UserDefaults.standard.object(forKey: "registerid")
                               
                           //String(UserDefaults.standard.integer(forKey: "registerid"))
                       let verify_param = ["storedProcedureName":"getDatabaseNames","input1":str2 as Any] as [String : Any]
                           let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
                       AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                                 response in
                               DispatchQueue.main.async{

                                  // self.hud.hide(true)

                                   }
                               //  SVProgressHUD.dismiss()
                              if let json = response.value
                              {
                         let jsonResponse = json as! NSDictionary
                             print(jsonResponse)
                              do
                              {
                                 //UserDefaults.standard.set(jsonResponse.object(forKey: "register_id"), forKey: "registerid")
                               var skippedArray = NSMutableArray()
                               skippedArray = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                               
                               let dataarray = skippedArray.firstObject as! NSDictionary
                              
                               self.defaultdatabase = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                             
                               if self.databasearray.count>0
                               {
                                  // btndateofmatich .setTitle((self.databasearray.object(0), for: <#T##UIControl.State#>)
                                 //  UserDefaults.standard.array(dataarray, forKey:"databasearray")

                               }
//                               else
//                               {
//
//                               }

                               //Integer
           //                      let login: FootBallTabControllerViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "FootBallTabControllerViewController") as! FootBallTabControllerViewController)
           //                         self.navigationController?.pushViewController(login!, animated: true)
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
    func PickteamsCall()
         {
           //SVProgressHUD.show()
 //            var string = String.self
 //            string = UserDefaults.standard.integer(forKey: "registerid")
           
               hud = MBProgressHUD.showAdded(to: self.view, animated: true)

               hud.labelText = ""
          
            let strInt = Int(storedversionnumber.text!)
             let str2 =  UserDefaults.standard.object(forKey: "registerid")
                    // let string = btndateofmatich.currentTitle
                 //String(UserDefaults.standard.integer(forKey: "registerid"))
            let verify_param = ["storedProcedureName":"getPickTeams","input1":str2 as Any ,"input2":btndefaultdatabase.currentTitle!,"input3":strInt as Any] as [String : Any]
                 let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
           AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                       response in
                      DispatchQueue.main.async{

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
                self.storedversion = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                if self.databasearray.count == 0
                {
                    self.showToast(message: "No Data", font: UIFont.systemFont(ofSize: 12))
                }
                else
                {
                    let result = self.databasearray[0] as? NSDictionary
                                     // var stringvalue1 = ""
                
                      if let partname = result!.value(forKey: "TotalVersions") as? Int
                          {
                             let str2 = String(partname)
                           self.storedversionnumber.text = str2
                            if str2 == "0"
                            {
                                self.btnminus.isHidden = true
                            }
                            if str2 == "1"
                            {
                                self.btnplus.isHidden = true
                            }
                            if str2 == "2"
                            {
                                self.btnplus.isHidden = true
                            }
                           }
                   if let partname = result!.value(forKey: "storedTeams_id") as? Int
                        {
                           let str2 = String(partname)
                        self.storedTeams_id = str2
                         }
                   if let partname = result!.value(forKey: "icanplayId") as? Int
                   {
                      let str2 = String(partname)
                   self.icanplayid = str2
                    }
                }
                    
                   //et dataarray = skippedArray1.firstObject as! NSDictionary

                  // self.databasearray = (jsonResponse["Data2"] as? NSArray)! as! NSMutableArray
                  
                  //self.storedTeams_id =  NSString(format: "%@",(result!.value(forKey: "storedTeams_id") as! CVarArg)) as String
                  // print(self.storedTeams_id)
                   
               self.skippedArray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                self.pickcollection.reloadData()
                   }
               else
             {
                var skippedArray1 = NSMutableArray()
             skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
              let dataarray = skippedArray1.firstObject as! NSDictionary
               var stringvalue1:String = ""
                stringvalue1 = dataarray.value(forKey:"Column1") as! String
                self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
                       }
                   }
                 }
                }
           
           }
    
    func SaveDraft()
            {
              //SVProgressHUD.show()
    //            var string = String.self
    //            string = UserDefaults.standard.integer(forKey: "registerid")
              
                  hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                  hud.labelText = ""
             
              // let strInt = Int(storedversionnumber.text!)
                let strInt1 = Int(storedTeams_id)
               // let str2 =  UserDefaults.standard.object(forKey: "registerid")
                       // let string = btndateofmatich.currentTitle
                    //String(UserDefaults.standard.integer(forKey: "registerid"))
                let verify_param = ["storedProcedureName":"sp_ConfirmDraftSelection","input1":strInt1 as Any ,"input2":storedversionnumber.text!] as [String : Any]
                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
              AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                          response in
                         DispatchQueue.main.async{

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
                 var skippedArray1 = NSMutableArray()
                   skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                    if skippedArray1.count == 0
                    {
                        self.showToast(message:"No Data" , font: UIFont.systemFont(ofSize: 14))

                    }
                    else
                    {
                    let dataarray = skippedArray1.firstObject as! NSDictionary
                    var stringvalue1:String = ""
                     stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
                     self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
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
    func PickteamsstoredteamidCall()
            {
              //SVProgressHUD.show()
    //            var string = String.self
    //            string = UserDefaults.standard.integer(forKey: "registerid")
              
                  hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                  hud.labelText = ""
             
               let strInt = Int(storedTeams_id)
                let str2 =  UserDefaults.standard.object(forKey: "registerid")
                       // let string = btndateofmatich.currentTitle
                    //String(UserDefaults.standard.integer(forKey: "registerid"))
               let verify_param = ["storedProcedureName":"getPickTeams","input1":str2 as Any ,"input2":btndefaultdatabase.currentTitle!,"input3":strInt as Any] as [String : Any]
                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
              AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                          response in
                         DispatchQueue.main.async{

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
                   self.storedversion = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
                   if self.databasearray.count == 0
                   {
                       self.showToast(message: "No Data", font: UIFont.systemFont(ofSize: 12))
                   }
                   else
                   {
                       let result = self.databasearray[0] as? NSDictionary
                                        // var stringvalue1 = ""
                   
                         if let partname = result!.value(forKey: "TotalVersions") as? Int
                             {
                                let str2 = String(partname)
                              self.storedversionnumber.text = str2
                              }
                      if let partname = result!.value(forKey: "storedTeams_id") as? Int
                           {
                              let str2 = String(partname)
                           self.storedTeams_id = str2
                            }
                      if let partname = result!.value(forKey: "icanplayId") as? Int
                      {
                         let str2 = String(partname)
                      self.icanplayid = str2
                       }
                   }
                       
                      //et dataarray = skippedArray1.firstObject as! NSDictionary

                     // self.databasearray = (jsonResponse["Data2"] as? NSArray)! as! NSMutableArray
                     
                     //self.storedTeams_id =  NSString(format: "%@",(result!.value(forKey: "storedTeams_id") as! CVarArg)) as String
                     // print(self.storedTeams_id)
                      
                  self.skippedArray = (jsonResponse["Data3"]! as! NSArray).mutableCopy() as! NSMutableArray
                   self.pickcollection.reloadData()
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
    func PickRandomCall()
            {
              //SVProgressHUD.show()
    //            var string = String.self
    //            string = UserDefaults.standard.integer(forKey: "registerid")
              
                  hud = MBProgressHUD.showAdded(to: self.view, animated: true)

                  hud.labelText = ""
             
               let strInt = Int(storedTeams_id)
                //let str2 =  UserDefaults.standard.object(forKey: "registerid")
                       // let string = btndateofmatich.currentTitle
                    //String(UserDefaults.standard.integer(forKey: "registerid"))
               let verify_param = ["storedProcedureName":"proc_helpSelection","input1":strInt as Any ,"input2":btnrandom.currentTitle!] as [String : Any]
                    let signin_headers: HTTPHeaders = ["x-api-key":"CODEX@123"]
              AF.request(GlobalConstants.ApiURL, method: .post, parameters: verify_param, encoding: URLEncoding.httpBody, headers:signin_headers).responseJSON {
                          response in
                         DispatchQueue.main.async{

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

                  var skippedArray1 = NSMutableArray()
        skippedArray1 = (jsonResponse["Data1"]! as! NSArray).mutableCopy() as! NSMutableArray
        let dataarray = skippedArray1.firstObject as! NSDictionary
         var stringvalue1:String = ""
         stringvalue1 = dataarray.value(forKey:"ErrorDescription") as! String
          self.showToast(message:stringvalue1 , font: UIFont.systemFont(ofSize: 14))
              
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
}

