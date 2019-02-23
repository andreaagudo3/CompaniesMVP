//
//  LogManager.swift
//  Companies
//
//  Created by Andrea Agudo on 17/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

final class Log {
    static func debug(_ text: String?) {
        if Config.isDevelopment {
            guard let text = text else { return }
            print(text)
        }
    }
}
