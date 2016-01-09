//
//  AppDelegate.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-02.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        loadViewControllers()
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barStyle = .Black
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    func loadViewControllers() {
        
        let articles = ArticleViewController()
        let articlesNav = UINavigationController(rootViewController:articles)
        
        let questions = QuestionViewController()
        let questionsNav = UINavigationController(rootViewController:questions)
        
        let discover = DiscoverViewController()
        let discoverNav = UINavigationController(rootViewController:discover)
        
        let search = SearchViewController()
        let searchNav = UINavigationController(rootViewController:search)
        
        let profile = ProfileViewController()
        let profileNav = UINavigationController(rootViewController:profile)
        
        // Create tabbarViewController without storyboard
        let tabBarController = UITabBarController()
        let tabBarItems = [articlesNav, questionsNav, discoverNav, searchNav, profileNav]
        tabBarController.viewControllers = tabBarItems
        
        let color = UIColor(red: 55.0/255.0, green: 168.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = color
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        let itemImages = ["icon_tab_article","icon_tab_qa","icon_tab_discover","icon_tab_search","icon_tab_user"]
        let selectedItemImages = ["icon_tab_article_active","icon_tab_qa_active",
                                  "icon_tab_discover_active","icon_tab_search_active","icon_tab_user_active"]
        let itemTitles = ["Articles", "Questions", "Discover", "Search", "Profile"]
        let attribute =  [NSForegroundColorAttributeName: UIColor(red: 0.0/255.0, green: 154.0/255.0, blue: 97.0/255.0, alpha: 1.0)];
        let tabItems = tabBarController.tabBar.items!
        for (index, item) in tabItems.enumerate() {
            var image = UIImage(named: itemImages[index])
            var selectedImage = UIImage(named: selectedItemImages[index])
            image = image?.imageWithRenderingMode(.AlwaysOriginal)
            selectedImage = selectedImage?.imageWithRenderingMode(.AlwaysOriginal)
            
            item.image = image
            item.selectedImage = selectedImage
            item.title = itemTitles[index]
            item.setTitleTextAttributes(attribute, forState: .Selected)
            
            tabBarItems[index].tabBarItem = item // Add tabBarItem to ViewController
        }
        
        window?.rootViewController = tabBarController // *Important: Add tabBarViewController to the window
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
    }
}


