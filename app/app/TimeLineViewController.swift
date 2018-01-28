//
//  TimeLineViewController.swift
//  app
//
//  Created by 井元進一 on 2018/01/23.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    var data = [NCMBObject]()
    var imgData = [String:Data]()
    var refreshControl = UIRefreshControl()

    @IBAction func Logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var TimeLineTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.TimeLineTable.delegate = self
        self.TimeLineTable.dataSource = self
        
        //xibの登録
        let xib = UINib(nibName: "CosutomTableViewCell", bundle: nil)
        self.TimeLineTable.register(xib, forCellReuseIdentifier: "CosutomTableViewCell")
        
        self.refreshControl.addTarget(self, action: #selector(TimeLineViewController.refreshData), for: .valueChanged)
        self.TimeLineTable.addSubview(self.refreshControl)
    }
    override func viewWillAppear(_ animated: Bool) {
        //mBaasからデータの取得
        let query = NCMBQuery(className: "timeLine")
        query?.order(byDescending: "createDate")
        query?.findObjectsInBackground({ (values, error) in
            
            self.data = [NCMBObject]()
            self.imgData = [String:Data]()
            
            
            if error == nil {
                self.data = values as! [NCMBObject]
                self.TimeLineTable.reloadData()
            }
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.TimeLineTable.dequeueReusableCell(withIdentifier: "CosutomTableViewCell",for: indexPath) as! CosutomTableViewCell
        
        cell.TextLabel.text = self.data[indexPath.row].object(forKey: "timeLineTitle") as! String
        
        
        cell.ImageView.image = nil
        let id = self.data[indexPath.row].objectId!
        if self.imgData[id] != nil {
            cell.ImageView.image = UIImage(data: self.imgData[id]!)
        return cell
        }
        
        let file = NCMBFile.file(withName: "\(self.data[indexPath.row].objectId!).png", data: nil) as! NCMBFile
        
            file.getDataInBackground { (data, error) in
            
                if error == nil {
                cell.ImageView.image = UIImage(data: data!)
                    self.imgData[self.data[indexPath.row].objectId!] = data!
                }
            }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        //データを渡す
        next.titleText = self.data[indexPath.row].object(forKey: "timeLineTitle") as! String
        next.messageText = self.data[indexPath.row].object(forKey: "timeLineMessage") as! String
        next.objectId = self.data[indexPath.row].objectId!
        
        self.show(next,sender: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    
    @objc func refreshData() {
        
        
        let query = NCMBQuery(className: "timeLine")
        query?.order(byDescending: "createDate")
        query?.findObjectsInBackground({ (values, error) in
        self.refreshControl.endRefreshing()
            self.data = [NCMBObject]()
            self.imgData = [String:Data]()
            
            if error == nil {
                self.data = values as! [NCMBObject]
                self.TimeLineTable.reloadData()
            }
        })
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
