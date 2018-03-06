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
        UserNotiService.shared.timerRequest(with: 5)
        
    }
    
    @IBAction func onLocationTapped(){
        print("location")
    }
    
    @IBAction func onDateTapped(){
        print("date")
    }


}

