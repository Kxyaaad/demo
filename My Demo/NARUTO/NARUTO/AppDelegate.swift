//
//  AppDelegate.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/9.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit
import CoreData
import AVOSCloud
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        //UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().barTintColor = UIColor(white: 0.3, alpha: 0.5)
        
        AVOSCloud.setApplicationId("SRowkKdl7O7aguXsycBv9L6G-gzGzoHsz", clientKey: "4Y3Cu4ToUB06JGg6y5Vg1lbs")
        
        let itemIcon1 = UIApplicationShortcutIcon.init(templateImageName: "icon1")
        let item1 = UIApplicationShortcutItem.init(type: "type1", localizedTitle: "微博", localizedSubtitle: "点击到主页", icon: itemIcon1, userInfo: nil)
        
        let itemIcon2 = UIApplicationShortcutIcon.init(templateImageName: "icon2")
        let item2 = UIApplicationShortcutItem.init(type: "type2", localizedTitle: "微信", localizedSubtitle: "点击到发现", icon: itemIcon2, userInfo: nil)
        
        let itemIcon3 = UIApplicationShortcutIcon.init(type: .add)
        let item3 = UIApplicationShortcutItem.init(type: "type3", localizedTitle: "添加", localizedSubtitle: "添加事件", icon: itemIcon3, userInfo: nil)
        
        let itemIcon4 = UIApplicationShortcutIcon.init(type: .alarm)
        let item4 = UIApplicationShortcutItem.init(type: "type4", localizedTitle: "事件", localizedSubtitle: "查看事件详情", icon: itemIcon4, userInfo: nil)
        
        //UIApplication.shared.shortcutItems = [item1, item2, item3, item4]
        application.shortcutItems = [item1, item2, item3, item4]
        
        return true
    }
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "type4":
           let vc = DiscoverTableViewController()
           self.window?.rootViewController = vc
            
            print("查看时间详情")
        default:
            return
        }
        
    }
    
   
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "NARUTO")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

