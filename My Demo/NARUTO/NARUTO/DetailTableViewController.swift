//
//  DetailTableViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/15.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var detailData : DataMo!
    
    @IBOutlet weak var detailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    
        detailImage.image = UIImage(data: detailData.image as! Data)
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
        view.backgroundColor = .black
        tableView.estimatedRowHeight = 50
        self.navigationController?.navigationBar.isTranslucent = true
        self.title = detailData.title
        
//        let bgImage = UIImageView(image: UIImage(named: detailData.img))
//        bgImage.frame = self.view.frame
//        
//        self.view.addSubview(bgImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailIdentifier", for: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.fileLable.text = "名称"
            cell.valueLable.text = detailData.title
        case 1:
            cell.fileLable.text = "地址"
            cell.valueLable.text = detailData.location
        case 2:
            cell.fileLable.text = "简介"
            cell.valueLable.text = detailData.detail
            if cell.valueLable.text != nil {
                tableView.rowHeight = UITableViewAutomaticDimension
                
            }else {
                cell.valueLable.text = "未收录简介"
            }
            
        default:
            break
        }

        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    @IBAction func jumpBAIDU(_ sender: Any) {
        let linke = "https://baike.baidu.com/" 
        let url = URL(string: linke)
        UIApplication.shared.open(url!)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passLoc" {
            let loc = segue.destination as! MapViewController
            if detailData.location != nil {
             loc.place = detailData.location!
            }
            
        }
        if segue.identifier == "toShareView" {
            let loc = segue.destination as! ShareViewController
            loc.img = detailImage.image!
        }
    }
    
    @IBAction func detailClose(segue:UIStoryboardSegue) {
        
    }
   

}
