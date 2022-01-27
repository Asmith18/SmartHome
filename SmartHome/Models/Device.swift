//
//  Device.swift
//  SmartHome
//
//  Created by adam smith on 1/27/22.
//

import Foundation

class Device: Codable {
    
    var name: String
    var isOn: Bool
    
    
    init(name: String, isOn: Bool = false){
        self.name = name
        self.isOn = isOn
    }
}
