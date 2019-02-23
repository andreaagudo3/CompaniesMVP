//
//  Config.swift
//  Companies
//
//  Created by Andrea Agudo on 16/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

enum URLKeys {
    case getCompanies

    var key: String {
        switch self {
        case .getCompanies:
            return "urlCompanies"
        }
    }
}
