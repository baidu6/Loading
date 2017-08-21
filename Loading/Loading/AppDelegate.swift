
//  AppDelegate.swift
//  Loading
//
//  Created by mac on 2017/2/7.
//  Copyright © 2017年 czj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController:ViewController())
        
        let ADVC = ADViewController()
        ADVC.complete = {[weak self] in
            print("complete")
            self?.window?.rootViewController = nav
            self?.window?.makeKeyAndVisible()
        }
        self.window?.rootViewController = ADVC
        
        
        //3DTouch分享功能的实现
        if #available(iOS 9.0, *) {
            let serachShortcutIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIconType.search)
            let searchShortcutItem = UIApplicationShortcutItem(type: "com.wangyun.search", localizedTitle: "Search", localizedSubtitle: "Search Subtitle", icon: serachShortcutIcon, userInfo: nil)
            let shareShortcutIcon = UIApplicationShortcutIcon(type: UIApplicationShortcutIconType.share)
            let shareShortcurItem = UIApplicationShortcutItem(type: "com.wangyun.share", localizedTitle: "Share", localizedSubtitle: "Share Subtitle", icon: shareShortcutIcon, userInfo: nil)
            
            UIApplication.shared.shortcutItems = [searchShortcutItem,shareShortcurItem]
            
        }
        self.window?.makeKeyAndVisible()
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, comple tionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.wangyun.search"{
            print("搜索")
        }else if shortcutItem.type == "com.wangyun.share"{
            
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
    
    
}

