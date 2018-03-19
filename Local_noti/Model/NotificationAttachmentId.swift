//
//  NotificationAttachmentId.swift
//  Local_noti
//
//  Created by Tanin on 19/03/2018.
//  Copyright © 2018 landtanin. All rights reserved.
//

import Foundation

enum NotificationAttachmentId: String {
    
    // this line could be just "timer". But to make it clear, we do it this way
    case timer = "userNotification.attachment.timer"
    case date = "userNotification.attachment.date"
    case location = "userNotification.attachment.location"
    
}
