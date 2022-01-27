//
//  DeviceController.swift
//  SmartHome
//
//  Created by adam smith on 1/27/22.
//

import Foundation
import UIKit

class DeviceController {
//MARK: - properties

    
///  Singleton

    static let sharedInstance = DeviceController()
    
/// Source of Truth
    
    var devices: [Device] = []
    
//MARK: - Initializer
    
    init() {
        loadDevice()
    }
    
//MARK: - CRUD
    
    func createDevice(name: String) {
        let device = Device(name: name)
        devices.append(device)
        saveDevice()
    }
    
    func toggleIsOn(device: Device) {
        device.isOn.toggle()
        saveDevice()
    }
    
    func saveDevice() {
        guard let devicesURL = devicesURL else {return}
        do {
            let data = try JSONEncoder().encode(devices)
            try data.write(to: devicesURL)
        } catch {
            print("Error Saving Device", error)
        }
    }
    
    func loadDevice() {
        guard let devicesURL = devicesURL else {return}
        do {
            let data = try Data(contentsOf: devicesURL)
            let devices = try JSONDecoder().decode([Device].self, from: data)
            self.devices = devices
        } catch {
            print("Error Loading Devices", error)
        }
    }
    
    private var devicesURL: URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let url = documentDirectory.appendingPathComponent("device.json")
        return url
    }
}
