//
//  DeviceTableViewController.swift
//  SmartHome
//
//  Created by adam smith on 1/27/22.
//

import UIKit

class DeviceTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(turnAllDevicesOn), name: TurnOnAllNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(turnAllDevicesOff), name: TurnAllOffNotificationName, object: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DeviceController.sharedInstance.devices.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as? DeviceTableViewCell else {return UITableViewCell()}
        let deviceToUpdate = DeviceController.sharedInstance.devices[indexPath.row]
        cell.delegate = self
        cell.updateViews(device: deviceToUpdate)
        
        
        return cell
    }
    
    @objc func turnAllDevicesOn() {
        DeviceController.sharedInstance.turnAllDevicesToOn()
        tableView.reloadData()
    }
    
    @objc func turnAllDevicesOff() {
        DeviceController.sharedInstance.turnAllDevicesToOff()
        tableView.reloadData()
    }

//MARK: - Helper Func
    
    private func presentNewDeviceAlertController() {
        let alertController = UIAlertController(title: "Add a Device", message: "Enter Device Name", preferredStyle: .alert)
        alertController.addTextField {
            textField in textField.placeholder = "New Device Name"
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        let confirmAction = UIAlertAction(title: "Create", style: .default) { _ in guard let contentTextField = alertController.textFields?.first,
            let name = contentTextField.text else {return}
            DeviceController.sharedInstance.createDevice(name: name)
            self.tableView.reloadData()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        presentNewDeviceAlertController()
    }
}

extension DeviceTableViewController: DeviceTableViewCellDelegate {
    func isOnSwitchToggled(cell: DeviceTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let urmom = DeviceController.sharedInstance.devices[indexPath.row]
        DeviceController.sharedInstance.toggleIsOn(device: urmom)
        cell.updateViews(device: urmom)
        
    }
    
    
}
