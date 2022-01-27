//
//  DeviceTableViewCell.swift
//  SmartHome
//
//  Created by adam smith on 1/27/22.
//

import UIKit

protocol DeviceTableViewCellDelegate: AnyObject {
    func isOnSwitchToggled(cell: DeviceTableViewCell)
}

class DeviceTableViewCell: UITableViewCell {

//MARK: - Outlets
    
    @IBOutlet weak var deviceNameTextLabel: UILabel!
    @IBOutlet weak var powerSwitchToggle: UISwitch!
    
    
//MARK: - Properties
    
   weak var delegate:DeviceTableViewCellDelegate?
    
    
//MARK: - Helper Function
    
    func updateViews(device: Device) {
        deviceNameTextLabel.text = device.name
        powerSwitchToggle.isOn = device.isOn
    }
    
    

//MARK: - Action
    
    @IBAction func powerSwitchToggled(_ sender: Any) {
        delegate?.isOnSwitchToggled(cell: self)
    }
}
