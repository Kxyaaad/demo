//
//  ContentViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/18.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func pageControl(_ sender: UIPageControl) {
        //index = pageControl.currentPage
    }
    
    var index = 0
    var imageName = "p1"
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPage = index
        image.image = UIImage(named: imageName)
        if index != 2 {
            Donebtn.isHidden = true
        }else {
            Donebtn.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var Donebtn: UIButton!
    @IBAction func Done(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        let UserDefult = UserDefaults.standard
        UserDefult.set(true, forKey: "GuaidShowed")
        
    }
    
  

}
