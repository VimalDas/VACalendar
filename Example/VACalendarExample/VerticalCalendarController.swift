//
//  VerticalCalendarController.swift
//  VACalendar
//
//  Created by Anton Vodolazkyi on 20.02.18.
//  Copyright © 2018 Vodolazkyi. All rights reserved.
//

import UIKit

class VerticalCalendarController: UIViewController {
    
    
    @IBOutlet weak var popupView: VerticalCalendar! {
        didSet{
            popupView.layer.cornerRadius = 15
            popupView.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
