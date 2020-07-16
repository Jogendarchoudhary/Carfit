//
//  CleanerListViewModel.swift
//  CarFit
//
//  Created by AA/MP/05 on 13/07/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

// json file name
let jsonFileName = "carfit"

protocol CleanerViewModelProtocol {
    
    var listDidChanges: ((Bool) -> Void)? { get set }
    func fetchCleanerListWith(date: String)
}

class CleanerListViewModel: CleanerViewModelProtocol {
    
    //MARK: - Internal Properties
    
    // Callback to refreshing data
    var listDidChanges: ((Bool) -> Void)?
    
    // "parsedCleanerData" has full parsed data from json file which is parsed by JSON parser
    var parsedCleanerData = CleanerList.parse(jsonFile: jsonFileName)
    
    // workOrders is a array of list data
    var workOrders: [WorkOrders]? {
        didSet {
            self.listDidChanges!(true)
        }
    }
    
    // This is to fetch data for a perticulare Date(This will return data for current date and selected date)
    func fetchCleanerListWith(date: String) {
        self.workOrders = parsedCleanerData?.data?.filter({ (list) -> Bool in
            if let listStartDate = list.startTimeUtc?.getFormattedDate(), (date == listStartDate || listStartDate == Date().string) {
                return true
            }
            return false
        })
    }
}
