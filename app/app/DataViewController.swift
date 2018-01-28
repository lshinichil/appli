//
//  DataViewController.swift
//  app
//
//  Created by 井元進一 on 2018/01/27.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    

    @IBOutlet weak var detailTitle: UITextView!
    @IBOutlet weak var detailMessage: UITextView!
    @IBOutlet weak var detailImage: UIImageView!

    
    var titleText: String!
    var messageText: String!
    var objectId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailTitle.text = titleText
        self.detailMessage.text = messageText
        
        let file = NCMBFile.file(withName: "\(self.objectId!).png", data: nil) as! NCMBFile
        file.getDataInBackground { (data, error) in
            
            if error == nil {
                self.detailImage.image = UIImage(data: data!)
            }
        }
        
        

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
