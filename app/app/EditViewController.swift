//
//  HomeViewController.swift
//  app
//
//  Created by 井元進一 on 2018/01/22.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import Foundation
import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var postTitleView: UITextView!
    @IBOutlet weak var postMessageView: UITextView!
    
    @IBAction func tapNextView(_ sender: Any) {
        let timeLineTitle = self.postTitleView.text
        let timeLineMessage = self.postMessageView.text
        
        //mBaas
        let object = NCMBObject(className:"timeLine")
        
        object?.setObject(timeLineTitle, forKey: "timeLineTitle")
        object?.setObject(timeLineMessage, forKey: "timeLineMessage")
        object?.saveInBackground({ (error) in
            //保存失敗
            if error == nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PictureViewController") as! PictureViewController
                vc.objectId = object!.objectId
                self.show(vc, sender: nil)
            } else if error != nil {
                self.errorLabel.isHidden = false
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.errorLabel.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
