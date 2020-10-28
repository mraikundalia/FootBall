//
//  FootBallTabControllerViewController.swift
//  Football Stats
//
//  Created by Chakri on 12/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallTabControllerViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        //self.tabBarController?.delegate = self
        self.selectedIndex = 4
        self.tabBar.unselectedItemTintColor = UIColor.black
     //    self.tabBarController?.selectedIndex = 4
        //self.tabBarController?.tabBar.selectedItem = 1
        // Do any additional setup after loading the view.
    }
    
//    func tabBarController(_ tabBarController: UITabBarController,
//            shouldSelect viewController: UIViewController) -> Bool {
//          self.tabBarController!.selectedIndex = 3
//        return true
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
