//
//  AlertService.swift
//  Local_noti
//
//  Created by Tanin on 06/03/2018.
//  Copyright © 2018 landtanin. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    private init() {}
    static func actionSheet(in vc: UIViewController, title: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { (_) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
}
