//
//  BundleExtension.swift
//  Companies
//
//  Created by Andrea Agudo on 17/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

extension Bundle {
    var developmentModeEnabled: Bool {
        // swiftlint:disable force_cast
        guard let developmentMode = Bool(infoDictionary?["DevelopmentMode"] as! String) else {
            return false
        }
        return developmentMode
    }
}
