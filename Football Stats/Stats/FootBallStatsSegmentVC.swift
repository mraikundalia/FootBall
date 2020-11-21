//
//  FootBallStatsSegmentVC.swift
//  Football Stats
//
//  Created by Chakri on 07/11/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit
import Alamofire
import iOSDropDown
class FootBallStatsSegmentVC: UIViewController , NIDropDownDelegate {

    var currentViewController: UIViewController?
        var text:String = ""
       enum TabIndex : Int {
           case firstChildTab = 0
           case secondChildTab = 1
           case thirdchildTab = 2
       }
    @IBOutlet var contentview: UIView!

    @IBOutlet var btntuesday: UIButton!
    var btndropdown = NIDropDown ()

    @IBAction func btntuedasyAction(_ sender: Any)
    {
        if btndropdown.isDescendant(of: self.view) {
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
    
    @IBOutlet var mainsegment: UISegmentedControl!
    var dataarray = NSMutableArray()
    var defaultdatabase = NSMutableArray()
    @IBAction func mainsegmentAction(_ sender: Any) {
        self.currentViewController!.view.removeFromSuperview()
               self.currentViewController!.removeFromParent()
               
        displayCurrentTab((sender as AnyObject).selectedSegmentIndex)
        
    }
    
    lazy var firstChildTabVC: UIViewController? =
           {
            let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "FootBallStatsVC")
            return firstChildTabVC
        }()
        lazy var secondChildTabVC : UIViewController? = {
            let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "FootBallHeadtoHeadVC")
            
            return secondChildTabVC
        }()
       
        lazy var Thirdchildvc : UIViewController? =
           {
               let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "FootBallWholeTeamVC")
               
               return secondChildTabVC
           }()
       
       
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btntuesday.clipsToBounds = true
        btntuesday.layer.cornerRadius = 6
        btntuesday.layer.borderColor = UIColor.black.cgColor
        btntuesday.layer.borderWidth = 1
        
        mainsegment.selectedSegmentIndex =  0
                 mainsegment.removeBorders()
               mainsegment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
               
                mainsegment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 18)!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
             
                   mainsegment.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
                         
                            displayCurrentTab(0)
        self.GetDatabaseNames()
               
    }
    func displayCurrentTab(_ tabIndex: Int)
       {
                if let vc = viewControllerForSelectedSegmentIndex(tabIndex)
                {
                    
                    self.addChild(vc)
                    vc.didMove(toParent: self)
                    
                    vc.view.frame = contentview.bounds
                    contentview.addSubview(vc.view)
                    self.currentViewController = vc
                }
            }
            
       func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController?
       {
               var vc: UIViewController?
               switch index {
               case TabIndex.firstChildTab.rawValue :
                   vc = firstChildTabVC
               case TabIndex.secondChildTab.rawValue :
                   vc = secondChildTabVC
               case TabIndex.thirdchildTab.rawValue :
               vc = Thirdchildvc
               default:
               return nil
               }
           
               return vc
           }
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

                                   //self.hud.hide(true)

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
                             
                             }
                           }
                          }
                     
                     }
    func niDropDownDelegateMethod(_ sender: NIDropDown!)
     {
         
     }
     
     func niDropDownDelegateMethod(_ sender: UIView!, withTitle title: String!)
     {
         
             btntuesday.setTitle(title, for: .normal)
     }
     
     func niDropDownHidden(_ sender: NIDropDown!)
     {
         btndropdown.isHidden = true
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
