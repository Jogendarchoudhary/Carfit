//
//  VisitState.swift
//  CarFit
//
//  Created by AA/MP/05 on 14/07/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import UIKit

enum VisitState: String, Decodable {
    case ToDo
    case InProgress
    case Done
    case Rejected
    
    func color() -> UIColor {
        switch self {
        case .ToDo:
            return .todoOption
        case .InProgress:
            return .inProgressOption
        case .Done:
            return .doneOption
        case .Rejected:
            return .rejectedOption
        }
    }
}
