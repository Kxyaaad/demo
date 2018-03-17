//
//  DiscoverTableViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/31.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit
import AVOSCloud
class DiscoverTableViewController: UITableViewController {
    var objects:[AVObject] = []
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //tableView.estimatedRowHeight = 250
        spinner.center = self.view.center
        self.view.addSubview(spinner)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.Update), for: .valueChanged)
        tableView.rowHeight = 500
        tableView.separatorColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        getDataFromCloud()
    }
    
    @objc func Update() {
        getDataFromCloud(update: true)
    }

    func getDataFromCloud(update:Bool = false) {
        let query = AVQuery(className: "ZERO")
        query.order(byDescending: "createdAt")
        
        if update {
            query.cachePolicy = .ignoreCache
        }else{
            query.cachePolicy = .networkElseCache
            query.maxCacheAge = 60*3
        }
    
        query.findObjectsInBackground { (result, error) in
            if let result = result as? [AVObject] {
                self.objects = result
                OperationQueue.main.addOperation {
                    self.spinner.stopAnimating()
                    self.spinner.removeFromSuperview()
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
                
            }else{
                let art = UIAlertController(title: "没有数据", message: "未能在云端找到数据", preferredStyle: .alert)
                let act = UIAlertAction(title: "确定", style: .default, handler: nil)
                art.addAction(act)
                self.present(art, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisCell", for: indexPath) as! DiscoverTableViewCell
        
        let object = objects[indexPath.row]
        if  (object["name"] as? String != "") {
        cell.name?.text = object["name"] as? String
        }else {
            cell.name?.text = "未知"
        }
        if (object["detail"] as? String != "") {
        cell.detailTextLabel?.text = object["detail"] as? String
        }else {
            cell.detailTextLabel?.text = "未备注简介"
        }
        //使用图片占位符，使得文字先加载就显示，图片可以后加载，优化显示
        cell.img.image = #imageLiteral(resourceName: "2.jpg")
        
        if let imgFile = object["image"] as? AVFile {
            imgFile.getDataInBackground({ (data, error) in
                if let data  = data {
                    OperationQueue.main.addOperation {
                         cell.img?.image = UIImage(data: data)
                    }
                  
                }
            })
            
            
           
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
