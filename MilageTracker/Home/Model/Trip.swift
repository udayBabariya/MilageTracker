//
//  Trip.swift
//  MilageTracker
//
//  Created by Uday on 25/08/21.
//

import Foundation


/// Trip Model
struct Trip: Codable{
    var startTime: Date
    var endTime: Date
    var totalSteps: Int
    var peace: Double
    var status: Bool
    var distance: Double
}
