//
//  CapacityMainModel.swift
//  freespacewidget
//
//  Created by Sergey Vasilevkin on 28/04/2019.
//  Copyright © 2019 Sergey Vasilevkin. All rights reserved.
//

import Foundation

struct CapacityMainModel {

    public var freeSpace: Int
    public var usedSpace: Int
    public var totalSpace: Int

    public init() {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)

        let values = try? fileURL.resourceValues(forKeys: [
            .volumeTotalCapacityKey,
            .volumeAvailableCapacityKey
            ])

        if let totalCapacity = values?.volumeTotalCapacity,
            let freeCapacity = values?.volumeAvailableCapacity {

            #if DEBUG
            print("ComputationMainModel::Available capacity: \(freeCapacity)")
            print("ComputationMainModel::Total capacity: \(totalCapacity)")
            #endif

            freeSpace = freeCapacity
            usedSpace = totalCapacity - freeCapacity
            totalSpace = totalCapacity

        } else {
            freeSpace = 0
            usedSpace = 0
            totalSpace = 0
        }
    }
}
