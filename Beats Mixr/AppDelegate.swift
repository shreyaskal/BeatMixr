//
//  AppDelegate.swift
//  Beats Mixr
//
//  Created by Shreyas Kalyan on 2/21/15.
//  Copyright (c) 2015 Shreyas Kalyan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("noDUj8KCBV3KllfuVFOTKYzfONlWDzehcdA3hipa",
            clientKey: "bgfmGg7pTBMqGhJUWZU4xBehJQ4YkA6VPrI9Ble7")
        
        // Override point for customization after application launch.
        
        let CONSUMER_CLIENT_ID: NSString = "gSVGxCE5Z0Y";
        let CONSUMER_CLIENT_SECRET: NSString = "t1uyl7BeOtQ";
        Moxtra.clientWithApplicationClientID(CONSUMER_CLIENT_ID, applicationClientSecret: CONSUMER_CLIENT_SECRET);
        
        let useridentity:MXUserIdentity = MXUserIdentity();
        useridentity.userIdentityType = kUserIdentityTypeIdentityUniqueID;
        useridentity.userIdentity = "user's identity";
        
        Moxtra.sharedClient().initializeUserAccount(useridentity, orgID: nil, firstName: "John", lastName: "Doe", avatar: nil, devicePushNotificationToken: nil, success: nil, failure: nil);
        
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


