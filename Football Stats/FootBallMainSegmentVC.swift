//
//  FootBallMainSegmentVC.swift
//  Football Stats
//
//  Created by Chakri on 21/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallMainSegmentVC: UIViewController
{
     var currentViewController: UIViewController?
     var text:String = ""
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
        case thirdchildTab = 2
        case fouthchildTab = 3
    }
    @IBOutlet var contentview: UIView!
    
    @IBOutlet var mainsegment: UISegmentedControl!

    @IBAction func mainsegmentAction(_ sender: Any) {
        self.currentViewController!.view.removeFromSuperview()
               self.currentViewController!.removeFromParent()
               
        displayCurrentTab((sender as AnyObject).selectedSegmentIndex)
        
    }
    
    lazy var firstChildTabVC: UIViewController? =
        {
         let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "FootBallProfileVC")
         return firstChildTabVC
     }()
     lazy var secondChildTabVC : UIViewController? = {
         let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "FootBallJoinGroupVC")
         
         return secondChildTabVC
     }()
    
     lazy var Thirdchildvc : UIViewController? =
        {
            let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "FootBallGroupsVC")
            
            return secondChildTabVC
        }()
    lazy var FourthChildVC : UIViewController? =
        {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "FootBallSettingsVC") as! FootBallSettingsVC
        
        return secondChildTabVC
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainsegment.selectedSegmentIndex =  0
          mainsegment.removeBorders()
        

       
        if text == "Profile"
        {
      mainsegment.selectedSegmentIndex = TabIndex.secondChildTab.rawValue
            
                        displayCurrentTab(1)
        }
        else
        {
            mainsegment.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
                  
                              displayCurrentTab(0)
        }
          
      //  self.viewControllerForSelectedSegmentIndex(0)
        // Do any additional setup after loading the view.
      mainsegment.removeBorders()
        mainsegment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
         mainsegment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
            mainsegment.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
                  
                     //displayCurrentTab(0)
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
            case TabIndex.fouthchildTab.rawValue :
                vc = FourthChildVC
            default:
            return nil
            }
        
            return vc
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
extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        (context ?? "" as! CGContext).setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
