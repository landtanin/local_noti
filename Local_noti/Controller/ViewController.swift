//
//  ViewController.swift
//  Local_noti
//
//  Created by Tanin on 05/03/2018.
//  Copyright © 2018 landtanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UserNotiService.shared.authorize()
        
    }

    @IBAction func onTimeTapped(){
        
        print("timer")
        AlertService.actionSheet(in: self, title: "5 seconds") { 
            UserNotiService.shared.timerRequest(with: 5)
        }
        
    }
    
    @IBAction func onDateTapped(){
        print("date")
        
        var components = DateComponents()
        // Looking for everytime the time hit the specific second in a minute
        components.second = 0
        // Looking for everytime the time hit the Wednesday in a week
//        components.weekday = 4
        
        AlertService.actionSheet(in: self, title: "Some future time") {
            UserNotiService.shared.dateRequest(with: components)
        }
        
    }
    
    @IBAction func onLocationTapped(){
        print("location")
        AlertService.actionSheet(in: self, title: "When I return") {
            
        }
    }


}

