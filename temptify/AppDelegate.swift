//
//  AppDelegate.swift
//  temptify
//
//  Created by mason on 2023-02-08.
//
//
//import Foundation
//import UIKit
//import UserNotifications
//
////@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//    var notificationCounter = 0
//    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        UNUserNotificationCenter.current().delegate = self
//        return true
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//    }
//}
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    static let shared = UIApplication.shared.delegate as! AppDelegate
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        notificationCounter += 1
//        completionHandler()
//    }
//}
