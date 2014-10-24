//
//  Factory.swift
//  SlotMachine
//
//  Created by NanYar on 24.10.14.
//  Copyright (c) 2014 NanYar. All rights reserved.
//

import Foundation
import UIKit


class Factory
{
    class func createSlots() -> [[Slot]]
    {
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        
        var slots: [[Slot]] = [] // = Main array
        for var containerNumber = 0; containerNumber < kNumberOfContainers; containerNumber++
        {
            var slotArray: [Slot] = [] // = Inner array
            for var slotNumber = 0; slotNumber < kNumberOfSlots; slotNumber++
            {
                var slot = Slot(value: 0, image: UIImage(named: ""), isRed: true) // = generiert einen Slot mit den default Werten
                slotArray.append(slot)
            }
            slots.append(slotArray)
        }
        return slots
    }
}
