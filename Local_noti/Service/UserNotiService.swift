//
//  UserNotiService.swift
//  Local_noti
//
//  Created by Tanin on 06/03/2018.
//  Copyright © 2018 landtanin. All rights reserved.
//

import Foundation
import UserNotifications

/**
 * set a class as a delegate of NSObject to observe app state (background/foreground)
 */
class UserNotiService: NSObject {
    
    // singleton, private constructor
    private override init() {}
    static let shared = UserNotiService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    // request permission to send user alerts (ask for authorization)
    func authorize() {
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        
        unCenter.requestAuthorization(options: options) { (granted, erro) in
            print(erro ?? "No UN auth error")
            
            guard granted else {
                // handle the case of user denying notification permission to this app
                print("USER DENIED ACCESSs")
                return
            }
            self.configure()
            
        }
        
    }
    
    // configure notification
    func configure() {
        
        unCenter.delegate = self
        
    }
    
}

extension UserNotiService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        
        // a special kind of completionHandler
        completionHandler()
    }
    
    // incase your app is in the foreground, how you would like the notification to behave
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN WILL present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}
