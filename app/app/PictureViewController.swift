//
//  PictureViewController.swift
//  app
//
//  Created by 井元進一 on 2018/01/24.
//  Copyright © 2018年 井元進一. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    var imgPC = UIImagePickerController()
    var objectId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imgPC.delegate = self
        self.imgPC.allowsEditing = true
        self.notificationLabel.isHidden = true
    }
    
    @IBAction func tapSelectFromPicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        self.imgPC.sourceType = .photoLibrary
        self.present(imgPC,animated: true, completion: nil)
        }
    }
    @IBAction func tapSelectFromCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imgPC.sourceType = .camera
            self.present(imgPC,animated: true, completion: nil)
        }
    }
    
    @IBAction func tapCompleteButton(_ sender: Any) {
        if self.selectedImageView.image == nil {
            self.notificationLabel.isHidden = false
            return
        }

        let data = UIImagePNGRepresentation(self.selectedImageView.image!)

        let file = NCMBFile.file(withName: "\(objectId).png", data: data) as? NCMBFile

        file?.saveInBackground({ (error) in

            // もし、エラーでなかったら
            if error == nil {
                // 最初の画面に戻る
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerEditedImage] as! UIImage
        self.selectedImageView.image = img
    
        self.imgPC.dismiss(animated: true) {
        }
    }

}
