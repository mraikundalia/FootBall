//
//  FootBallResultNoteVC.swift
//  Football Stats
//
//  Created by Chakri on 29/11/20.
//  Copyright © 2020 Mehul. All rights reserved.
//

import UIKit

class FootBallResultNoteVC: UIViewController,UITextViewDelegate {

    @IBOutlet var lblnametitle: UILabel!
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var TxtNoteView: UITextView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
     TxtNoteView.clipsToBounds = true
            TxtNoteView.layer.cornerRadius = 2;
            TxtNoteView.layer.borderColor = UIColor.black.cgColor
            TxtNoteView.layer.borderWidth = 1;
        // Do any additional setup after loading the view.
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         if(text == "\n") {
             textView.resignFirstResponder()
             return false
         }
         return true
     }

     /* Older versions of Swift */
     func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
         if(text == "\n") {
             textView.resignFirstResponder()
             return false
         }
         return true
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
