//
//  GuaidViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/18.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit

class GuaidViewController: UIPageViewController,UIPageViewControllerDataSource {
 
    var images = ["p1","p2","p3"]
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1
        return vc(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index += 1
        return vc(atIndex: index)
    }
    func vc(atIndex:Int) -> ContentViewController? {
        if case 0..<images.count = atIndex {
            if let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewControl") as? ContentViewController {
                contentVC.imageName = images[atIndex]
                contentVC.index = atIndex
                return contentVC
            }
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        if let startVC = vc(atIndex: 0) {
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
        
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
