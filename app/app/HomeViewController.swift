//
//  HomeViewController.swift
//  app
//
//  Created by 井元進一 on 2018/01/22.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController{
    
    @IBOutlet weak var randomImageView: UIImageView!
    var data = [NCMBObject]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let query = NCMBQuery(className: "timeLine")
        query?.order(byDescending: "createDate")
        query?.findObjectsInBackground({ (values, error) in
            
            if error == nil {
                //データの取得
                self.data = values as! [NCMBObject]
                
                let random = Int(arc4random()%3)
                let Id = self.data[random].objectId!
                    let file = NCMBFile.file(withName: "\(Id).png", data: nil) as! NCMBFile
                    file.getDataInBackground({ (data, error ) in
                        if error == nil {
                            self.randomImageView.image = UIImage(data: data!)
                        }
                    })
                
                
            }
        })
    }
    
    @IBAction func mottoButton(_ sender: Any) {
        let query = NCMBQuery(className: "timeLine")
        query?.order(byDescending: "createDate")
        query?.findObjectsInBackground({ (values, error) in
            
            if error == nil {
                //データの取得
                self.data = values as! [NCMBObject]
                
                let random = Int(arc4random()%3)
                let Id = self.data[random].objectId!
                let file = NCMBFile.file(withName: "\(Id).png", data: nil) as! NCMBFile
                file.getDataInBackground({ (data, error ) in
                    if error == nil {
                        self.randomImageView.image = UIImage(data: data!)
                    }
                })
                
                
            }
        })
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
