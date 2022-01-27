//
//  ToggleAllViewController.swift
//  SmartHome
//
//  Created by adam smith on 1/27/22.
//

import UIKit

let TurnOnAllNotificationName = Notification.Name("TurnOnAllDevicesNotification")
let TurnAllOffNotificationName = Notification.Name("TurnOffAllDevicesNotification")

class ToggleAllViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func turnAllOnButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: TurnOnAllNotificationName, object: nil)
    }
    @IBAction func turnAllOffButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: TurnAllOffNotificationName, object: nil)
    }
}




