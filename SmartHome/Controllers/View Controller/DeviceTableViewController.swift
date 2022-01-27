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
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DeviceController.sharedInstance.devices.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as? DeviceTableViewCell else {return UITableViewCell()}
        let deviceToUpdate = DeviceController.sharedInstance.devices[indexPath.row]
//        cell.delegate = self
            cell.updateViews(device: deviceToUpdate)
        
        
        return cell
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
    
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
