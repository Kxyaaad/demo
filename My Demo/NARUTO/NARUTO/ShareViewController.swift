//
//  ShareViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/16.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    @IBOutlet weak var ratingStackView: UIStackView!
    
    @IBOutlet weak var bgImgView: UIImageView!
    
    @IBOutlet weak var doneBtn: UIButton!
    var cancelBtn = UIButton()
    var blueEffert = UIVisualEffectView()
    var img = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        blueEffert = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blueEffert.frame = view.frame
       
       bgImgView.image = img
        // Do any additional setup after loading the view.
        let startPos = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        let starSize = CGAffineTransform(scaleX: 0, y: 0)
        ratingStackView.transform = starSize.concatenating(startPos)
        
        
        cancelBtn.frame = doneBtn.frame
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.isHidden = true
 
        
        
        
    }
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBAction func shareBtn(_ sender: Any) {
         bgImgView.addSubview(blueEffert)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform.identity
        }, completion: nil)
        doneBtn.setTitle("取消", for: .normal)
       
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.5) {
//            self.ratingStackView.transform = CGAffineTransform.identity
//        }
        
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
