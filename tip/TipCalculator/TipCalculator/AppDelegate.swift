//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Larry Bulen on 4/15/17.
//  Copyright © 2017 LarryBulen. All rights reserved.
//

import UIKit
import Amplitude_iOS // importing Amplitude's Analytic API

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    // FUNC APPLICATION(_ APPLICATION: UIAPPLICATION, DIDFINISHLAUNCHINGWITHOPTIONS LAUNCHOPTIONS: [UIAPPLICATIONLAUNCHOPTIONSKEY: ANY]?) -> BOOL
    // method is called during the app launch, and hands off to the ROOTVIEWCONTROLLER or STORYBOARD.
    // here we initialize an instance of AMPLITUDE ANALYTICS API, and start listening to location.
    // listening to location required changing INFO.PLIST to prompt user about the app using location data.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Used Amplitude's Analytics framework as a Cocoapod, also found documentation for BUILDSETTINGS and APPDELEGATAE
        // URL: https://cocoapods.org/pods/Amplitude-iOS
        
        // From Amplitude's portal:
        // [[Amplitude instance] initializeApiKey:@"89897cb80b046b127084d7d90f8965a2"];
        Amplitude.instance().initializeApiKey("89897cb80b046b127084d7d90f8965a2")
        Amplitude.instance().enableLocationListening()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    // FUNC APPLICATIONDIDENTERBACKGROUND(_ APPLICATION: UIAPPLICATION)
    // if the app goes to the background, disable listening to the location
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Amplitude.instance().disableLocationListening()
    }

    // FUNC APPLICATIONWILLENTERFOREGROUND(_ APPLICATION: UIAPPLICATION)
    // if the app returns to foreground, enable listening to the location
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        Amplitude.instance().enableLocationListening()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    // FUNC APPLICATIONWILLTERMINATE(_ APPLICATION: UIAPPLICATION)
    // if the app terminates, disable listening to the location
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        Amplitude.instance().disableLocationListening()
    }


}

