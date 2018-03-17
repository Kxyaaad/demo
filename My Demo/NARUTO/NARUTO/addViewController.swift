//
//  addViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/9.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit
import CoreData
import AVOSCloud
class addViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var addData:DataMo?
    @IBOutlet weak var yulanImg: UIImageView!
    @IBOutlet weak var loucationTEXT: UITextField!
    @IBOutlet weak var txtBACKView: UIView!
    var photorequer = UIImagePickerController()
    @IBOutlet weak var titletext: UITextField!
    @IBOutlet weak var dettext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func t3(_ sender: Any) {
    }
    @IBAction func t2(_ sender: Any) {
    }
    @IBAction func gg(_ sender: Any) {
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        loucationTEXT.resignFirstResponder()
        titletext.resignFirstResponder()
        dettext.resignFirstResponder()
    }
    @IBAction func add(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        addData = DataMo(context: appDelegate.persistentContainer.viewContext)
        
        if let imageData = UIImageJPEGRepresentation(yulanImg.image!, 0.7) {
            addData?.image = imageData
        }
        addData?.title = titletext.text!
        addData?.detail = dettext.text!
        addData?.location = loucationTEXT.text!
        print("Saving")
        appDelegate.saveContext()
       // celldatas.append(datamod)
        saveToCloud(addData: addData)
    //self.navigationController?.popViewController(animated: true)
        
    }
    //上传云储存,必须强制解包，否则会出错。
    func saveToCloud(addData:DataMo!) {
        let cloudObject = AVObject(className: "ZERO")
        cloudObject["name"] = addData.title!
        cloudObject["detail"] = addData.detail!
        cloudObject["location"] = addData.location!
        
        let origeImg = UIImage(data: addData.image as! Data)!
        let factor = (origeImg.size.width > 1024) ? (1024/(origeImg.size.width)) : 1
        let sceledImg = UIImage(data: addData.image as! Data, scale: factor)
        
        let imgFile = AVFile(name: "\(addData.title!).jpg", data: UIImageJPEGRepresentation(sceledImg!, 0.7)!)
        cloudObject["image"] = imgFile
        cloudObject.saveInBackground { (succeed, error) in
            if succeed {
                let alertView = UIAlertController(title: "成功上传至云端", message: nil, preferredStyle: .alert)
                let alertACt = UIAlertAction(title: "确定", style: .default, handler:{(_) in
                        self.navigationController?.popViewController(animated: true)
                })
                alertView.addAction(alertACt)
                self.present(alertView, animated: true, completion: nil)
            }else {
                let alertView = UIAlertController(title: "未能成功上传至云端", message: nil, preferredStyle: .alert)
                let alertACt = UIAlertAction(title: "确定", style: .default, handler:{(_) in
                    self.navigationController?.popViewController(animated: true)
            })
                alertView.addAction(alertACt)
                self.present(alertView, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @IBAction func alumBtn(_ sender: UIButton) {
        
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("相册不可用")
            return
        }
        
       
        let alumAlr = UIAlertController()
        let alum = UIAlertAction(title: "相册", style: .default) { (_) in
            let picker = UIImagePickerController()
           // picker.allowsEditing = true
           
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
            picker.delegate = self
        }
       
        
        let cam = UIAlertAction(title: "拍摄", style: .default) { (_) in
            let picker = UIImagePickerController()
            //picker.allowsEditing = true
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
            picker.delegate = self
        }
       
        alumAlr.addAction(alum)
        alumAlr.addAction(cam)
        self.present(alumAlr, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        yulanImg.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //yulanImg.image = UIImage(data: info[UIImagePickerController] as? UIImage)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func yindao(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(false, forKey: "GuaidShowed")
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
