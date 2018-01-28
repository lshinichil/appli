//
//  PictureViewController.swift
//  app
//
//  Created by 井元進一 on 2018/01/24.
//  Copyright © 2018年 井元進一. All rights reserved.
//


import UIKit

class PostPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    var imgPC = UIImagePickerController()
    var objectId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgPC.delegate = self
        self.imgPC.allowsEditing = true
    }
    
    @IBAction func tapSelectFromPicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imgPC.sourceType = .photoLibrary
            self.present(imgPC, animated: true, completion: nil)
        }
    }
    @IBAction func tapSelectFromCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imgPC.sourceType = .camera
            self.present(imgPC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapPostCompleteButton(_ sender: Any) {
        if self.selectedImageView.image == nil {
            self.notificationLabel.isHidden = false
            return
        }
        let data = UIImagePNGRepresentation(self.selectedImageView.image!)
        let file = NCMBFile.file(withName: "ddd.png", data: data) as? NCMBFile
        /********** レッスン4-6 ファイル名にobjectIdを利用する **********/
        //let file = NCMBFile.file(withName: "\(objectId).png", data: data) as? NCMBFile
        /********** レッスン4-6 ファイル名にobjectIdを利用する **********/
        file?.saveInBackground({ (error) in
            if error == nil {
                // 最初の画面に戻る
                self.navigationController?.popToRootViewController(animated: true)
            }
            /********** レッスン4-2 保存が終わったあとの処理 **********/
        })
        /********** レッスン4-1 選んだ写真を保存する **********/
    }
    
    /********** レッスン3-6 UIImagePickerControllerとの相談 **********/
    // UIImagePickerControllerとの相談↓
    // 写真を選択した後どうするぅ？
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /********** レッスン3-7 選んだ写真を編集したいとき **********/
        // 編集した画像を取得
        let img = info[UIImagePickerControllerEditedImage] as! UIImage
        /********** レッスン3-7 選んだ写真を編集したいとき **********/
        // 選んだ画像をselectedImageViewに表示する
        self.selectedImageView.image = img
        // UIImagePickerControllerの画面を閉じる
        self.imgPC.dismiss(animated: true, completion: nil)
    }
    /********** レッスン3-6 写真を選択したらどうするぅ？ **********/
    
}

