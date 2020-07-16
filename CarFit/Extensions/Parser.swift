//
//  Parser.swift
//  CarFit
//
//  Created by AA/MP/05 on 13/07/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import Foundation

extension Decodable {
    static func parse(jsonFile: String) -> Self? {
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let response = try? JSONDecoder().decode(self, from: data)
            else {
                return nil
        }
        return response
    }
}
