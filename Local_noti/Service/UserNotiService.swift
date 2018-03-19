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
    static let instance = UserNotiService()
    
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
    
    // return an optional as we may or may not get the content attachment
    func getAttachment(for id: NotificationAttachmentId) -> UNNotificationAttachment? {
        
        var imageName: String
        
        switch id {
        case .timer:
                imageName = "TimeAlert"
        case .date:
                imageName = "DateAlert"
        case .location:
                imageName = "LocationAlert"
        }
        
        // get path to image assets
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else {
            return nil
        }
        
        // create attachment
        do {
            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url)
            return attachment
        } catch {
            return nil
        }
        
    }
    
    // MARK: Timer trigger
    /**
     The parameter type, TimeInteval, is just a sub-type of Double. We can legally use Double here as well
     But TimeInterval just makes it looks cleaner
     */
    func timerRequest(with interval: TimeInterval) {
        
        // 1/3 compenent, content
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done. YAY"
        content.sound = .default()
        content.badge = 1
        
        // add the attachment
        if let attachment = getAttachment(for: .timer) {
            content.attachments = [attachment]
        }
        
        // 2/3 compenent, trigger
        // in order to have it repeats, the interval has to be at least 60 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        
        // 3/3 compenent, request
        let request = UNNotificationRequest(identifier: "userNotification.timer",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request) { (error) in
            // extra logic after it's added
            print("request added")
        }
        
    }
    
    // MARK: Date trigger
    func dateRequest(with components: DateComponents) {
        
        let content = UNMutableNotificationContent()
        content.title = "Date Trigger"
        content.body = "It is now the future!"
        content.sound = .default()
        content.badge = 1
        
        // add the attachment
        if let attachment = getAttachment(for: .date) {
            content.attachments = [attachment]
        }
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.date",
                                            content: content,
                                            trigger: trigger)
        
        unCenter.add(request)
        
    }
    
    
    // MARK: Location trigger
    func locationRequest() {
        
        let content = UNMutableNotificationContent()
        content.title = "You have returned"
        content.body = "Welcome back"
        content.sound = .default()
        content.badge = 1
        
        // add the attachment
        if let attachment = getAttachment(for: .location) {
            content.attachments = [attachment]
        }
        
        // this one is not accurate and the reason why we need to use internal notification posting, observing instead
        // to get triggered when the users enter the region
        //        UNLocationNotificationTrigger
        
        let request = UNNotificationRequest(identifier: "userNotification.location",
                                            content: content,
                                            trigger: nil)
        
        unCenter.add(request)
        
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
        
        //        completionHandler(options)
        completionHandler(options)
        
    }
    
}
