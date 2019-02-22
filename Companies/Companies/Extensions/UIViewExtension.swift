//
//  UIViewExtension.swift
//  Companies
//
//  Created by Andrea Agudo on 22/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

extension UIView {
    func setCustomizedShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.cornerRadius = 10
    }
}
