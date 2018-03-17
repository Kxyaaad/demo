//
//  WebViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/19.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate,UISearchBarDelegate,UIScrollViewDelegate {
   
    @IBOutlet weak var toolView: UIView!
    var webkit:WKWebView?
    var progrssView:UIProgressView?
    var sc : UISearchController!
    var link:String!
    @IBOutlet weak var searbar: UISearchBar!
    var stext:String?
    @IBOutlet weak var backbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        progrssView = UIProgressView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 90))
        progrssView?.progressTintColor = .blue
        progrssView?.progress = 0
        let configeration = WKWebViewConfiguration()
        webkit = WKWebView(frame: CGRect(x: 0, y: 76, width: self.view.frame.size.width, height: self.view.frame.size.height-183), configuration: configeration)
        webkit?.autoresizingMask = .flexibleHeight
        webkit?.allowsBackForwardNavigationGestures = true
        
        
        link = "https://www.baidu.com"
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        searbar.delegate = self
        webkit?.load(request)
        
        self.view.addSubview(webkit!)
        self.view.addSubview(progrssView!)
        
        webkit?.scrollView.delegate = self
        
      
        
        
//        sc = UISearchController(searchResultsController: nil)
//        sc.searchBar.barTintColor = UIColor(white: 0.5, alpha: 0.5)
//        //sc.searchResultsUpdater = self
//        sc.searchBar.searchBarStyle = .minimal
//        sc.searchBar.isTranslucent = true
//        sc.searchBar.enablesReturnKeyAutomatically = true
//
//        //搜索时，cell可以被点按
//        sc.dimsBackgroundDuringPresentation = false
//
//        //tableView.tableHeaderView = sc.searchBar
//        self.view.addSubview(sc.searchBar)
//        
       // searbar.inputAccessoryView = addToolBtn()
        
       
        webkit?.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
        let prefrence  = WKPreferences()
        prefrence.minimumFontSize = 1
        prefrence.javaScriptEnabled = true
        prefrence.javaScriptCanOpenWindowsAutomatically = false
        configeration.preferences = prefrence
    }
    override   func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progrssView?.progress = Float(webkit!.estimatedProgress)
            if progrssView?.progress == Float(1) {
                progrssView?.isHidden = true
            }else {
                progrssView?.isHidden = false
            }
        }
    }
    //判断网页滑动方向
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var newY:Float = 0
        var oldY:Float = 0
        newY = Float(scrollView.contentOffset.y)
        if (newY != oldY ) {
            //Left-YES,Right-NO
            if (newY > oldY) {

                UIView.animate(withDuration: 0.5, animations: {
                    self.searbar.transform = CGAffineTransform(translationX: 0, y: -76)
                  
                    self.webkit?.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height-67)
                    self.toolView.frame = CGRect(x:0 , y: self.view.frame.size.height-47, width: self.view.frame.size.width, height: 60)
                })
                searbar.resignFirstResponder()
                
                
            }else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.searbar.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.webkit?.frame = CGRect(x: 0, y: 76, width: self.view.frame.size.width, height: self.view.frame.size.height-183)
                    self.toolView.frame = CGRect(x:0 , y: self.view.frame.size.height-107, width: self.view.frame.size.width, height: 60)
                })
               searbar.resignFirstResponder()
            }
            oldY = newY;
            
            
            
            
            
            
        }
        
    }
    
    
 
    
//    func addToolBtn() {
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 35))
//        toolbar.backgroundColor = .white
//        let toolItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toolbarFunc))
//        toolbar.items = [toolItem]
//        toolbar.sizeToFit()
//
//    }
//    @objc func toolbarFunc(toolBarOItem: UIBarButtonItem) {
//        self.searbar.resignFirstResponder()
//    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goback(_ sender: Any) {
        
        webkit?.goBack()
        searbar.resignFirstResponder()
    }
    @IBAction func goForward(_ sender: Any) {
        webkit?.goForward()
        searbar.resignFirstResponder()
    }
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        stext = searbar.text!
        if stext == nil {
            
            let url = URL(string: link)
            let request = URLRequest(url: url!)
            
            webkit?.load(request)
        }else if ((stext?.hasSuffix(".com") == true && stext?.hasPrefix("www.") == false) )  {
            stext = "http://www." + stext!
            
            let url = URL(string: stext!)
            let request = URLRequest(url: url!)
            
            webkit?.load(request)
        }else if((stext?.hasSuffix(".com") == true && stext?.hasPrefix("www.") == true) ) {
            stext = "http://" + stext!
            
            let url = URL(string: stext!)
            let request = URLRequest(url: url!)
            
            webkit?.load(request)
        }else if ((stext?.hasSuffix(".com") == false && stext?.hasPrefix("www.") == false)) {
            let  stext2 = "http://www.baidu.com.cn/s?wd=" + stext!
            
            //处理搜索词中的中文字符
            var baseURL: NSURL {
                let str: String = "http://www.baidu.com.cn/s?wd="
                let queryItem1 = NSURLQueryItem(name: "searchword", value: stext)
                //let queryItem2 = NSURLQueryItem(name: "key", value: myWeatherKey)
                let urlCom = NSURLComponents(string: str)
                urlCom?.queryItems = [queryItem1 as URLQueryItem]
                return (urlCom?.url!)! as NSURL
            }
            
            
            let request = URLRequest(url: baseURL as URL)
            
            webkit?.load(request)
        }
        searbar.resignFirstResponder()
        searbar.text = ""
        searbar.setShowsCancelButton(false, animated: true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searbar.setShowsCancelButton(true, animated: true)
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searbar.resignFirstResponder()
        searbar.text = ""
        searbar.setShowsCancelButton(false, animated: true)
    }
   
    
    
    //            link = "https://www.baidu.com"
    //            let url = URL(string: link)
    //            let request = URLRequest(url: url!)
    //
    //            webkit?.load(request)

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
