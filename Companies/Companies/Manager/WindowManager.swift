//
//  WindowManager.swift
//  Companies
//
//  Created by Andrea Agudo on 23/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

enum Storyboard {
    case main

    var name: String {
        switch self {
        case .main:
            return "Main"
        }
    }

    func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
