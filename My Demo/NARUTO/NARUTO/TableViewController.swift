//
//  TableViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/9.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit
import CoreData
var celldatas:[DataMo] = []
class TableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if var text = searchController.searchBar.text {
            //去搜索词空格
            text = text.trimmingCharacters(in: .whitespaces)
            searchFliter(text: text)
            tableView.reloadData()
        }
    }
    
    var sc : UISearchController!
    var celldata : DataMo!
    var fc:NSFetchedResultsController<DataMo>!
    var searchResults:[DataMo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        sc = UISearchController(searchResultsController: nil)
        sc.searchBar.barTintColor = UIColor(white: 0.5, alpha: 0.5)
        sc.searchResultsUpdater = self
        sc.searchBar.searchBarStyle = .minimal
        sc.searchBar.isTranslucent = true
        //搜索时，cell可以被点按
        sc.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = sc.searchBar
        //下拉刷新
//        self.refreshControl = UIRefreshControl()
//        refreshControl?.addTarget(self, action: #selector(  ), for: .valueChanged)
        
        
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tableView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        view.backgroundColor = .gray
        fetchAllData2()
    }
    //搜索筛选器
    func searchFliter(text: String) {
        if sc.searchBar.text == "" {
            searchResults = celldatas
        }else {
            searchResults = celldatas.filter({ (celldata) -> Bool in
                return (celldata.title?.localizedCaseInsensitiveContains(text))!
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  sc.isActive ? searchResults.count : celldatas.count
    }
  
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        celldata = sc.isActive ? searchResults[indexPath.row] : celldatas[indexPath.row]
            cell.img.image = UIImage(data: celldata.image as! Data)
            cell.tit.text = celldata.title
            cell.det.text = celldata.detail
        
        
        // Configure the cell...
        cell.backgroundColor = .gray
        return cell
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
       // tableView.reloadData()
    }
 
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .normal, title: "分享") { (_, indexPath) in
            let alt = UIAlertController(title: "分享", message: "", preferredStyle: .actionSheet)
            let weibo = UIAlertAction(title: "微博", style: .default, handler: nil)
            let weixin = UIAlertAction(title: "微信", style: .default, handler: nil)
            let quxiao = UIAlertAction(title: "取消", style: .destructive, handler: nil)
            alt.addAction(weibo)
            alt.addAction(weixin)
            alt.addAction(quxiao)
            self.present(alt, animated: true, completion: nil)
        }
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
//            celldatas.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(self.fc.object(at: indexPath))
            appDelegate.saveContext()
        }
        return [delete,share]
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let UserDefault = UserDefaults.standard
        if UserDefault.bool(forKey: "GuaidShowed") {
            return
        }
        
        
        
        if let pageVC = storyboard?.instantiateViewController(withIdentifier: "GuaidControl") as? GuaidViewController {
        present(pageVC, animated: true, completion: nil)
    }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        if let object = controller.fetchedObjects {
            celldatas = object as! [DataMo]
        }
    }
    
    
    func fetchAllData2() {
        let request:NSFetchRequest<DataMo> = DataMo.fetchRequest()
        let sd = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sd]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        do {
            try fc.performFetch()
            if let object = fc.fetchedObjects {
                celldatas = object
            }
        } catch  {
            print(error)
        }
    }
    
//    func fetchAllData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        do {
//            celldatas =  try appDelegate.persistentContainer.viewContext.fetch(DataMo.fetchRequest())
//        } catch {
//            print(error)
//        }
//    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !sc.isActive
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "imagename" {
            let name = segue.destination as! DetailTableViewController
            
            name.detailData = sc.isActive ? searchResults[(tableView.indexPathForSelectedRow?.row)!] : celldatas[(tableView.indexPathForSelectedRow?.row)!]
           
            sc.isActive = false
        }
        
    }
    

}
