//
//  PickTeamsVC.swift
//  Football Stats
//
//  Created by Chakri on 19/09/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class PickTeamsVC: UIViewController ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet var pickcollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
   let flowLayout = UICollectionViewFlowLayout()
           flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2, height:160)
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0.0
            pickcollection.collectionViewLayout = flowLayout
    
    let flowLayout1 = UICollectionViewFlowLayout()
    flowLayout1.itemSize = CGSize(width: UIScreen.main.bounds.width/2+60, height:220)
     flowLayout1.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
     flowLayout1.scrollDirection = .horizontal
     flowLayout1.minimumInteritemSpacing = 0.0
     pickcollection.collectionViewLayout = flowLayout1
    
     let flowLayout2 = UICollectionViewFlowLayout()
         flowLayout2.itemSize = CGSize(width: UIScreen.main.bounds.width/2+60, height:220)
          flowLayout2.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
          flowLayout2.scrollDirection = .horizontal
          flowLayout2.minimumInteritemSpacing = 0.0
          pickcollection.collectionViewLayout = flowLayout2
        // Do any additional setup after loading the view.
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
               return 3
          
           
            
            }
               
               func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
               {
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FootBallCollectionCel", for: indexPath as IndexPath) as! FootBallCollectionCel
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                {
                    layout.scrollDirection = .horizontal
                }

               
                    cell.mainimage.layer.cornerRadius = 8
                    cell.mainimage.clipsToBounds = true
              
    //               cell.borderview.clipsToBounds = true
    //                cell.borderview.layer.cornerRadius = 10;
    //               cell.borderview.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner,.layerMinXMaxYCorner]
    //               cell.borderview.layer.borderWidth = 0.5;
    //               cell.borderview.layer.borderColor = UIColor.white.cgColor
    //               cell.btntxt.layer.borderWidth = 1
    //               cell.btntxt.layer.cornerRadius = 15
    //               cell.btntxt.layer.borderColor = UIColor.init(red: 201.0/255.0, green:   214.0/255.0, blue:   237.0/255.0, alpha: 1).cgColor
    //               cell.btntxt.tag = indexPath.row
    //               cell.btntxt.addTarget(self, action: #selector(topupaction(sender:)), for: .touchUpInside)


                          return cell
               }
        
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
     {

        
        
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
