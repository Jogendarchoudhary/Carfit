//
//  CleanerListViewModel.swift
//  CarFit
//
//  Created by AA/MP/05 on 13/07/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation
import CoreLocation

struct CleanerList: Decodable {
    
    var success: Bool?
    var message: String?
    var data: [WorkOrders]?
}

struct WorkOrders: Decodable {
    
    var visitState: VisitState?
    var firstName: String?
    var lastName: String?
    var startTimeUtc: String?
    var expectedTime: String?
    var address: String?
    var zip: String?
    var city: String?
    var latitude: Double?
    var longitude: Double?
    var tasks: [Task]?
    
    enum CodingKeys: String, CodingKey {
        case visitState, startTimeUtc, expectedTime, tasks
        case firstName = "houseOwnerFirstName"
        case lastName = "houseOwnerLastName"
        case address = "houseOwnerAddress"
        case zip = "houseOwnerZip"
        case city = "houseOwnerCity"
        case latitude = "houseOwnerLatitude"
        case longitude = "houseOwnerLongitude"
    }
    
    func fullName() -> String {
        return "\(firstName ?? "") \(lastName ?? "")"
    }
    
    func fullAddress() -> String {
        return "\(address ?? "") \(zip ?? "") \(city ?? "")"
    }
    
    //Stopwatch time: total of all task time
    func totalTimeInMinutes() -> Int {
        return tasks?.map({($0.timesInMinutes ?? 0)}).reduce(0, +) ?? 0
    }
    
    //Title: combine of all task title
    func getTitle() -> String {
        return tasks?.map({($0.title ?? "")}).joined(separator: ",") ?? ""
    }
    
    // This will return startTimeUtc and also include expectedTime if available
    func getTime() -> String {
        let startTime = startTimeUtc?.getFormattedTime() ?? ""
        if let exptected = expectedTime {
            return "\(startTime) / \(exptected)"
        } else {
            return startTime
        }
    }
    
    func location() -> CLLocation? {
        if let lat = latitude, let long = longitude {
            return CLLocation(latitude: lat, longitude: long)
        }
        return nil
    }
    
}

struct Task: Decodable {
    var title: String?
    var timesInMinutes: Int?
}
